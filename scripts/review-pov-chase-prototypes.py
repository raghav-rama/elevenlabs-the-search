#!/usr/bin/env python3
"""Inspect downloaded prototype clips without changing source media.

Run from repo root: python scripts/review-pov-chase-prototypes.py BATCH.json
Requires macOS Swift/AVFoundation. Existing inspection outputs are preserved.
"""
import json
from pathlib import Path
import subprocess
import sys

if len(sys.argv) != 2:
    raise SystemExit(__doc__)
batch = json.loads(Path(sys.argv[1]).read_text())
sample_count = int(batch.get('review_sample_count', 14))
sample_interval = float(batch.get('review_interval_seconds', 0.375))
if sample_count < 1 or sample_interval <= 0:
    raise SystemExit('Review sample count and interval must be positive.')
swift = ['swift', '-suppress-warnings', '-module-cache-path', '/private/tmp/afterhuman-swift-cache']
for shot in batch['shots']:
    asset = shot['asset_id']
    source = Path('assets/06-shots/videos') / (asset + '.mp4')
    if not source.is_file():
        print(json.dumps({'asset': asset, 'status': 'not_downloaded'}), flush=True)
        continue
    review = Path('assets/06-shots/reviews') / asset
    review.mkdir(parents=True, exist_ok=True)
    inspection = review / 'inspection.json'
    if not inspection.exists():
        subprocess.run(swift + ['scripts/inspect-review-video.swift', str(source),
            str(review / 'last-frame.png'), str(inspection)], check=True, capture_output=True, text=True)
    data = json.loads(inspection.read_text())
    sheet = review / 'contact-sheet.jpg'
    if not sheet.exists():
        subprocess.run(swift + ['assets/06-shots/reviews/extract-contact-sheet.swift',
            str(source), str(sheet), '0', str(sample_interval), str(sample_count), '4', '416', '240'],
            check=True, capture_output=True, text=True)
    audio = review / 'native-audio.wav'
    if data['audio_tracks'] and not audio.exists():
        result = subprocess.run(swift + ['assets/06-shots/audio/extract-audio.swift',
            str(source), str(audio)], check=True, capture_output=True, text=True)
        (review / 'native-audio-levels.txt').write_text(result.stdout)
    print(json.dumps({'asset': asset, 'review_dir': str(review),
        'width': data['frame_width'], 'height': data['frame_height'],
        'fps': data['nominal_fps'], 'duration': data['video_duration_seconds'],
        'near_black_frames': len(data['near_black_frame_times_seconds']),
        'sha256': data['source_sha256']}), flush=True)
