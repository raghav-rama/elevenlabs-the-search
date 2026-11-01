#!/usr/bin/env python3
"""Arrange existing VO/music at original speed for a picture review.

Usage: python scripts/mix-ad-review.py CONFIG.json NEW_OUTPUT.wav
Run from repo root. Uses macOS afconvert and Python standard library only.
"""
import array
import hashlib
import json
import math
from pathlib import Path
import subprocess
import sys
import tempfile
import wave

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
config_path, output = map(Path, sys.argv[1:])
report_path = output.with_suffix('.mix.json')
if output.exists() or report_path.exists():
    raise SystemExit('Output/report exists; use a new version')
config = json.loads(config_path.read_text())
rate, channels = 48000, 2
count = round(config['duration_seconds'] * rate)
def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def db_gain(db):
    return 10 ** (db / 20)
def levels(values):
    return {'sample_peak_dbfs': 20 * math.log10(max(1e-12, max(map(abs, values)))),
            'rms_dbfs': 20 * math.log10(max(1e-12, math.sqrt(sum(x*x for x in values)/len(values))))}
decoded, sources = {}, {}
with tempfile.TemporaryDirectory(prefix='afterhuman-ad-mix-') as scratch:
    for key, entry in config['sources'].items():
        path = Path(entry['path'])
        if digest(path) != entry['sha256']:
            raise SystemExit('Source hash mismatch: ' + key)
        target = Path(scratch)/(key + '.wav')
        subprocess.run(['afconvert', '-f', 'WAVE', '-d', 'LEI16@48000', '-c', '2', str(path), str(target)],
                       check=True, capture_output=True)
        with wave.open(str(target)) as wav:
            assert (wav.getframerate(),wav.getnchannels(),wav.getsampwidth()) == (rate,channels,2)
            pcm = array.array('h', wav.readframes(wav.getnframes()))
        if sys.byteorder != 'little':
            pcm.byteswap()
        decoded[key] = array.array('f', (x/32768 for x in pcm))
        sources[key] = dict(entry, decoded_seconds=len(pcm)/(rate*channels), levels=levels(decoded[key]))

voice = array.array('f', [0]) * (count*channels)
music = array.array('f', [0]) * (count*channels)
def place(destination, source_key, segment, default_fade):
    source = decoded[source_key]
    source_start = round(segment['source_in_seconds']*rate)
    start = round(segment['timeline_start_seconds']*rate)
    frames = round(segment['duration_seconds']*rate)
    fade_in = max(1, round(segment.get('fade_in_seconds', default_fade)*rate))
    fade_out = max(1, round(segment.get('fade_out_seconds', default_fade)*rate))
    assert source_start >= 0 and start >= 0 and frames > 0
    assert source_start+frames <= len(source)//channels and start+frames <= count
    for i in range(frames):
        envelope = min(1, i/fade_in, (frames-1-i)/fade_out)
        destination[(start+i)*2] += source[(source_start+i)*2]*envelope
        destination[(start+i)*2+1] += source[(source_start+i)*2+1]*envelope

for segment in config['voice_segments']:
    place(voice, 'voice', segment, 0.006)
for segment in config['music_segments']:
    place(music, 'music', segment, 0.04)

music_match = config['music_reference_rms_dbfs'] - sources['music']['levels']['rms_dbfs']
mixed = array.array('f', [0]) * (count*channels)
low = [0.0, 0.0]
alpha = 1 - math.exp(-2*math.pi*config['slow_motion_filter_hz']/rate)
filter_start, filter_end = config['slow_motion_filter_range']
under = config['music_under_voice_db']
open_gain = config['music_between_lines_db']
for frame in range(count):
    t = frame/rate
    duck = 0.0
    for start, end in config['voice_duck_windows']:
        duck = max(duck, max(0, min(1, (t-start+0.12)/0.12, (end+0.28-t)/0.28)))
    music_db = open_gain + (under-open_gain)*duck
    for hit in config['music_hit_times']:
        if hit <= t < hit+0.12:
            music_db = min(music_db, config['music_initial_hit_db'])
    filtered = max(0, min(1, (t-filter_start)/0.2, (filter_end-t)/0.08))
    music_db += config['slow_motion_music_drop_db'] * filtered
    mg = db_gain(music_db+music_match)
    vg = db_gain(config['voice_gain_db'])
    for c in range(2):
        j=frame*2+c
        low[c] += alpha*(music[j]-low[c])
        m = music[j]*(1-filtered)+low[c]*filtered
        mixed[j] = voice[j]*vg+m*mg

unscaled_peak=max(map(abs,mixed))
master=min(1,db_gain(config['sample_peak_ceiling_dbfs'])/max(unscaled_peak,1e-12))
pcm=array.array('h',(round(max(-1,min(1,x*master))*32767) for x in mixed))
final_levels=levels(array.array('f',(x/32768 for x in pcm)))
if sys.byteorder!='little':pcm.byteswap()
output.parent.mkdir(parents=True,exist_ok=True)
with wave.open(str(output),'wb') as wav:
    wav.setnchannels(2);wav.setsampwidth(2);wav.setframerate(rate);wav.writeframes(pcm.tobytes())
for entry in sources.values():
    assert digest(entry['path'])==entry['sha256']
report={'status':'picture_review_mix_pending_listening','config_file':str(config_path),
        'config':config,'sources':sources,'duration_seconds':count/rate,'sample_rate':rate,'channels':2,
        'music_rms_match_gain_db':music_match,'master_gain_db':20*math.log10(master),
        'levels':final_levels,'full_scale_samples':sum(x in (-32768,32767) for x in pcm),
        'output_file':str(output),'output_sha256':digest(output),
        'source_retiming':False,'new_synthesis':False,'script':'scripts/mix-ad-review.py',
        'review_limits':'Sample-peak and RMS checks, not perceptual loudness or independent listening. Native scene effects are added by the picture assembler.'}
report_path.write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({'output':str(output),'duration_seconds':count/rate,'levels':final_levels,'master_gain_db':report['master_gain_db']}))
