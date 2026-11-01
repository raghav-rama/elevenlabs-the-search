#!/usr/bin/env python3
"""Overlay the supplied contest logo; preserve source media and compressed audio.

Usage: python3 scripts/add-contest-watermark.py CONFIG.json --ffmpeg /path/to/ffmpeg
Paths in the config are relative to the current working directory. No generation.
"""
import argparse
import hashlib
import json
import subprocess
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo


def sha256(path):
    digest = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('config', type=Path)
    parser.add_argument('--ffmpeg', required=True)
    args = parser.parse_args()
    config = json.loads(args.config.read_text())
    source, logo, output = map(Path, (config['source'], config['logo'], config['output']))
    assert sha256(source) == config['source_sha256'], 'Source changed'
    assert sha256(logo) == config['logo_sha256'], 'Official logo changed'
    report = output.with_suffix('.render.json')
    log = output.with_suffix('.render.log')
    for path in (output, report, log):
        if path.exists():
            raise FileExistsError(path)
    output.parent.mkdir(parents=True, exist_ok=True)
    # 480px logo = quarter of the 1920px landscape frame, per official guide.
    # A soft black shadow aids contrast without recoloring the official white mark.
    width, margin = config['watermark_width'], config['margin_pixels']
    graph = (
        f'[1:v]scale={width}:-1:flags=lanczos,format=rgba,split=2[logo][shadow];'
        '[shadow]pad=iw+16:ih+16:8:8:color=black@0,'
        'colorchannelmixer=rr=0:gg=0:bb=0:aa=0.8,boxblur=3:1[soft];'
        f'[0:v][soft]overlay=x=W-w-{margin}+10:y=H-h-{margin}+10:format=auto[base];'
        f'[base][logo]overlay=x=W-w-{margin}:y=H-h-{margin}:format=auto,'
        'format=yuv420p[v]'
    )
    command = [args.ffmpeg, '-hide_banner', '-nostdin', '-n', '-i', str(source),
               '-i', str(logo), '-filter_complex', graph, '-map', '[v]',
               '-map', '0:a:0', '-c:v', 'libx264', '-preset', 'slow', '-crf', '18',
               '-r', '24', '-fps_mode', 'cfr', '-c:a', 'copy',
               '-map_metadata', '0', '-movflags', '+faststart', str(output)]
    with log.open('w') as stream:
        subprocess.run(command, check=True, stdout=stream, stderr=stream)
    assert sha256(source) == config['source_sha256'], 'Source modified'
    assert sha256(logo) == config['logo_sha256'], 'Logo modified'
    report.write_text(json.dumps({
        'created_at': datetime.now(ZoneInfo('Asia/Kolkata')).isoformat(timespec='seconds'),
        'config': config, 'config_sha256': sha256(args.config),
        'script_sha256': sha256(__file__), 'output_sha256': sha256(output),
        'output_bytes': output.stat().st_size, 'command': command,
        'audio': 'Compressed source audio copied; verify separately.',
        'new_provider_generations': 0, 'new_provider_credits': 0,
        'status': 'rendered_pending_verification',
    }, indent=2) + '\n')
    print(output)


if __name__ == '__main__':
    main()
