#!/usr/bin/env python3
"""Decode voice auditions to temporary PCM and save format/level/hash checks.

Usage: python scripts/inspect-voiceover-auditions.py INPUT_DIR NEW_REPORT.json
Requires macOS afconvert. Original audio is never modified.
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
source_dir, report = map(Path, sys.argv[1:])
if report.exists():
    raise SystemExit(f"Refusing to overwrite {report}")
sources = sorted(source_dir.glob("afterhuman-vo-*-full-v01.mp3"))
if not sources:
    raise SystemExit(f"No audition files in {source_dir}")
checks = []
with tempfile.TemporaryDirectory(prefix="afterhuman-voice-check-") as scratch:
    for source in sources:
        decoded = Path(scratch) / (source.stem + ".wav")
        command = ["afconvert", "-f", "WAVE", "-d", "LEI16", str(source), str(decoded)]
        subprocess.run(command, check=True, capture_output=True, text=True)
        with wave.open(str(decoded), "rb") as wav:
            channels, rate, frames, width = (wav.getnchannels(), wav.getframerate(),
                                             wav.getnframes(), wav.getsampwidth())
            if width != 2 or frames == 0:
                raise RuntimeError(f"Unexpected PCM format or empty audio: {source}")
            samples = array.array("h", wav.readframes(frames))
        if sys.byteorder != "little":
            samples.byteswap()
        peak = max(abs(x) for x in samples) / 32768
        rms = math.sqrt(sum(x * x for x in samples) / len(samples)) / 32768
        checks.append({"file": source.name,
                       "sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
                       "bytes": source.stat().st_size,
                       "decoded_channels": channels, "decoded_sample_rate": rate,
                       "decoded_frames": frames, "decoded_duration_seconds": frames / rate,
                       "decoded_sample_peak_dbfs": 20 * math.log10(max(peak, 1e-12)),
                       "decoded_rms_dbfs": 20 * math.log10(max(rms, 1e-12)),
                       "full_scale_pcm_samples": sum(x in (-32768, 32767) for x in samples)})
result = {"method": "macOS afconvert decode to temporary 16-bit PCM at source sample rate",
          "limitation": "Numerical decoding/level checks do not establish performance or listening approval.",
          "files": checks}
report.write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps(result, indent=2))
