#!/usr/bin/env python3
"""Add deterministic local UI accents to the existing review mix.
Usage: python3 scripts/mix-upgrade-diagnostic-sfx.py CONFIG.json NEW_MIX.wav
Uses macOS afconvert; sources are read-only. No provider calls.
"""
import array, hashlib, json, math, random, struct, subprocess, sys, tempfile, wave
from pathlib import Path
if len(sys.argv)!=3:raise SystemExit(__doc__)
config_path,output=map(Path,sys.argv[1:]);config=json.loads(config_path.read_text())
record=output.with_suffix('.mix.json');stem=output.with_name(output.stem+'-effects-only.wav')
for p in (output,record,stem):
 if p.exists():raise SystemExit('Output exists: '+str(p))
def digest(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
assert digest(config['source'])==config['source_sha256']
rate=48000;channels=2
with tempfile.TemporaryDirectory(prefix='afterhuman-diagnostic-sfx-') as scratch:
 target=Path(scratch)/'base.wav'
 subprocess.run(['afconvert','-f','WAVE','-d','LEF32@48000','-c','2',config['source'],str(target)],check=True,capture_output=True)
 data=target.read_bytes();offset=12
 while offset+8<=len(data):
  tag=data[offset:offset+4];size=struct.unpack_from('<I',data,offset+4)[0]
  if tag==b'data':
   base=array.array('f');base.frombytes(data[offset+8:offset+8+size]);break
  offset+=8+size+(size%2)
 else:raise RuntimeError('Missing float PCM')
if sys.byteorder!='little':base.byteswap()
assert len(base)==45*rate*channels
start=config['start_frame']/config['fps'];duration=config['frame_count']/config['fps']
fx=array.array('f',[0])*round(duration*rate*channels)
events=[];rng=random.Random(20261101)
def add(kind,at,length,amp,frequencies=(),pan=0):
 first=round(at*rate);count=round(length*rate);low=0.0
 for i in range(count):
  frame=first+i
  if not 0<=frame<len(fx)//2:continue
  t=i/rate;u=i/max(1,count-1)
  if kind=='whoosh':
   noise=rng.uniform(-1,1);low+=0.08*(noise-low)
   value=(noise-low)*math.sin(math.pi*u)**2*amp
  else:
   envelope=min(1,i/(rate*.003))*math.exp(-u*5)*(1-u)
   value=sum(math.sin(2*math.pi*f*t) for f in frequencies)/max(1,len(frequencies))*envelope*amp
  fx[frame*2]+=value*(1-pan*.3);fx[frame*2+1]+=value*(1+pan*.3)
 events.append({'kind':kind,'at_seconds_relative_to_upgrade':at,'length_seconds':length,'amplitude':amp,'frequencies_hz':list(frequencies),'pan':pan})
add('whoosh',.05,.65,.034,pan=-.1)
for text,at,cps in ((config['brand'],.25,18),(config['descriptor'],.85,31)):
 for i,ch in enumerate(text):
  if ch!=' ':add('typing',at+i/cps,.022,.013,(1750+(i%5)*105,),-.15)
for i,module in enumerate(config['modules']):add('module_lock',module['at'],.19,.040,(550+i*110,1100+i*220),(-1 if i%2==0 else 1)*.45)
add('confirmation',3.28,.4,.055,(65,440,554.365,659.255))
add('whoosh',3.90,.68,.030,pan=.12)
first=round(start*rate)*2
ceiling=10**(-1.5/20);gain=1.0
while max(abs(base[first+i]+value*gain) for i,value in enumerate(fx))>ceiling and gain>.01:gain*=.8
mixed=array.array('f',base)
for i,value in enumerate(fx):mixed[first+i]+=value*gain
assert max(map(abs,mixed))<1
assert mixed[:first]==base[:first] and mixed[first+len(fx):]==base[first+len(fx):]
def write(path,values):
 pcm=array.array('h',(round(max(-1,min(1,x))*32767) for x in values))
 if sys.byteorder!='little':pcm.byteswap()
 with wave.open(str(path),'wb') as f:f.setnchannels(2);f.setsampwidth(2);f.setframerate(rate);f.writeframes(pcm.tobytes())
write(output,mixed);write(stem,array.array('f',(x*gain for x in fx)))
report={'status':'local_ui_sound_mockup_pending_listening_review','source':config['source'],'source_sha256':config['source_sha256'],'config':str(config_path),'config_sha256':digest(config_path),'output':str(output),'output_sha256':digest(output),'effects_stem':str(stem),'effects_stem_sha256':digest(stem),'stem_timeline_start_seconds':start,'stem_duration_seconds':duration,'effects_gain':gain,'duration_seconds':45,'sample_rate':rate,'channels':2,'peak_dbfs_before_pcm_quantization':20*math.log10(max(map(abs,mixed))),'source_gain':1,'base_float_samples_outside_effect_window_unchanged':True,'events':events,'new_provider_generations':0,'script':'scripts/mix-upgrade-diagnostic-sfx.py','note':'Original voice/music/mix decoded once at original timing and gain; deterministic low-level UI effects added only within the diagnostic insert. Final 16-bit WAV/AAC encode is not byte-identical to source AAC.'}
record.write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:report[k] for k in ['output','effects_stem','effects_gain','peak_dbfs_before_pcm_quantization','base_float_samples_outside_effect_window_unchanged']}))
