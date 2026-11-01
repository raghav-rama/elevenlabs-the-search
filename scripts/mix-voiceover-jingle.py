#!/usr/bin/env python3
"""Build a listening-only WAV preview; preserve the original voice and music.

Usage: python scripts/mix-voiceover-jingle.py CONFIG.json NEW_PREVIEW.wav
Run from the repository root. Requires macOS afconvert; no third-party packages.
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
    raise SystemExit('Refusing to overwrite an existing preview or report')
config = json.loads(config_path.read_text())
rate, channels = 48000, 2

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def gain(db):
    return 10 ** (db / 20)

def levels(samples, scale=1):
    peak = max(abs(x) for x in samples) / scale
    rms = math.sqrt(sum(x * x for x in samples) / len(samples)) / scale
    return {'sample_peak_dbfs': 20 * math.log10(max(peak, 1e-12)),
            'rms_dbfs': 20 * math.log10(max(rms, 1e-12))}

sources = {}
decoded = {}
with tempfile.TemporaryDirectory(prefix='afterhuman-jingle-preview-') as scratch:
    for name in ('voiceover', 'music'):
        source = Path(config[name + '_path'])
        source_hash = digest(source)
        expected_hash = config.get(name + '_sha256')
        if expected_hash and source_hash != expected_hash:
            raise SystemExit(f'{name} source hash mismatch')
        target = Path(scratch) / (name + '.wav')
        subprocess.run(['afconvert', '-f', 'WAVE', '-d', 'LEI16@48000',
                        '-c', '2', str(source), str(target)],
                       check=True, capture_output=True, text=True)
        with wave.open(str(target), 'rb') as wav:
            if (wav.getframerate(), wav.getnchannels(), wav.getsampwidth()) != (rate, channels, 2):
                raise RuntimeError(f'Unexpected PCM format for {name}')
            samples = array.array('h', wav.readframes(wav.getnframes()))
        if not samples:
            raise RuntimeError(f'Empty audio source: {name}')
        if sys.byteorder != 'little':
            samples.byteswap()
        decoded[name] = samples
        sources[name] = {'path': str(source), 'sha256': source_hash,
                         'decoded_seconds': len(samples) / (rate * channels),
                         'decoded_levels': levels(samples, 32768)}

voice, music = decoded['voiceover'], decoded['music']
start_frame = round(config['music_start_seconds'] * rate)
if start_frame < 0:
    raise SystemExit('Music start must be nonnegative')
voice_frames, music_frames = len(voice) // channels, len(music) // channels
total_frames = max(voice_frames, start_frame + music_frames)
mixed = array.array('f', [0]) * (total_frames * channels)
voice_gain = gain(config['voiceover_gain_db'])
music_source_rms = sources['music']['decoded_levels']['rms_dbfs']
music_match_gain_db = config.get('music_reference_rms_dbfs', music_source_rms) - music_source_rms
bed_db, hit_db = config['music_under_voice_db'], config['music_initial_hit_db']
after_db = config['music_after_voice_db']
hit_seconds, settle_seconds = config['initial_hit_seconds'], config['initial_settle_seconds']
recovery_start = voice_frames / rate + config['recovery_delay_seconds']
recovery_seconds = config['recovery_seconds']
if settle_seconds <= 0 or recovery_seconds <= 0:
    raise SystemExit('Envelope transition times must be positive')
for frame in range(total_frames):
    position = frame * channels
    music_frame = frame - start_frame
    music_gain = 0
    if 0 <= music_frame < music_frames:
        local_time = music_frame / rate
        if local_time < hit_seconds:
            music_db = hit_db
        elif local_time < hit_seconds + settle_seconds:
            blend = (local_time - hit_seconds) / settle_seconds
            music_db = hit_db + blend * (bed_db - hit_db)
        else:
            music_db = bed_db
        if frame / rate >= recovery_start:
            blend = min(1, (frame / rate - recovery_start) / recovery_seconds)
            music_db = bed_db + blend * (after_db - bed_db)
        music_gain = gain(music_db + music_match_gain_db) * min(1, local_time / 0.005)
    for channel in range(channels):
        value = voice[position + channel] * voice_gain if frame < voice_frames else 0
        if music_gain:
            value += music[music_frame * channels + channel] * music_gain
        mixed[position + channel] = value / 32768

unscaled_peak = max(abs(x) for x in mixed)
if 'fixed_master_gain_db' in config:
    master_gain = gain(config['fixed_master_gain_db'])
    if unscaled_peak * master_gain > gain(config['sample_peak_ceiling_dbfs']):
        raise SystemExit('Fixed master gain would exceed the configured sample-peak ceiling')
else:
    master_gain = min(1, gain(config['sample_peak_ceiling_dbfs']) / max(unscaled_peak, 1e-12))
pcm = array.array('h', (round(max(-1, min(1, x * master_gain)) * 32767) for x in mixed))
output_levels = levels(pcm, 32768)
full_scale = sum(x in (-32768, 32767) for x in pcm)
if sys.byteorder != 'little':
    pcm.byteswap()
output.parent.mkdir(parents=True, exist_ok=True)
with wave.open(str(output), 'wb') as wav:
    wav.setnchannels(channels)
    wav.setsampwidth(2)
    wav.setframerate(rate)
    wav.writeframes(pcm.tobytes())
for source in sources.values():
    if digest(Path(source['path'])) != source['sha256']:
        raise RuntimeError('A source changed during rendering')
report = {'status': 'listening_preview_not_final_mix', 'config_path': str(config_path),
          'config': config, 'sources': sources, 'sample_rate': rate, 'channels': channels,
          'music_start_frame': start_frame, 'music_start_seconds': start_frame / rate,
          'total_frames': total_frames, 'duration_seconds': total_frames / rate,
          'master_gain_db': 20 * math.log10(max(master_gain, 1e-12)),
          'music_rms_match_gain_db': music_match_gain_db,
          'levels': output_levels, 'full_scale_pcm_samples': full_scale,
          'output': {'path': str(output), 'sha256': digest(output), 'bytes': output.stat().st_size},
          'limitation': 'Mix is for audition only; no perceptual listening approval or final picture alignment implied.'}
report_path.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({'output': str(output), 'report': str(report_path),
                  'duration_seconds': total_frames / rate, 'levels': output_levels,
                  'master_gain_db': report['master_gain_db']}))
