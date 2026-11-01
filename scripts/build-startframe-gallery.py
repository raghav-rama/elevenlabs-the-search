#!/usr/bin/env python3
"""Build a local image/video review gallery without modifying source media.

Run from repo root: python scripts/build-startframe-gallery.py BATCH.json NEW_DIR
"""
import html
import json
import os
from pathlib import Path
import sys

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
batch_path = Path(sys.argv[1]).resolve()
destination = Path(sys.argv[2]).resolve()
destination.mkdir(parents=True, exist_ok=True)
output = destination / 'index.html'
if output.exists():
    raise SystemExit('Gallery already exists; use a new output directory.')
batch = json.loads(batch_path.read_text())
cards = []
escape = html.escape
for shot in batch['shots']:
    record = json.loads(Path(shot.get('latest_review_record', shot['record_file'])).read_text())
    media = Path(record['output_file']).resolve()
    if not media.is_file():
        raise SystemExit(f'Missing media: {media.name}')
    relative = escape(os.path.relpath(media, destination), quote=True)
    if media.suffix.lower() in {'.mp4', '.mov', '.webm'}:
        poster = ''
        if shot.get('source_file'):
            source = Path(shot['source_file']).resolve()
            if not source.is_file():
                raise SystemExit(f'Missing poster: {source.name}')
            poster = f' poster="{escape(os.path.relpath(source, destination), quote=True)}"'
        player = f'<video controls playsinline preload="metadata"{poster} src="{relative}"></video>'
        player += f'<p><a href="{relative}" target="_blank">Open native video</a></p>'
    else:
        player = f'<a href="{relative}" target="_blank"><img src="{relative}" alt="{escape(record["title"], quote=True)}"></a>'
    observations = record['assistant_visual_review']['observations']
    limits = record['assistant_visual_review']['limitations']
    cards.append(f'''<article>
      <h2>{escape(record['title'])}</h2>
      <p class="location">{escape(record['location'])}</p>
      {player}
      <p>{escape(' '.join(observations))}</p>
      <details><summary>What still needs testing</summary><ul>
      {''.join('<li>' + escape(item) + '</li>' for item in limits)}</ul></details>
    </article>''')
page = '''<!doctype html><html lang="en"><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>__TITLE__</title>
<style>
*{box-sizing:border-box}body{margin:0;background:#0c1016;color:#edf4f6;font:16px/1.5 system-ui,sans-serif}
header,main,footer{max-width:1500px;margin:auto;padding:24px}h1{font-size:30px;margin:0}h2{font-size:20px;margin:0}
header p,.location{color:#9daeb9}.location{margin:5px 0 14px}a{color:#59e6df}main{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:22px;padding-top:0}
article{background:#141b25;border:1px solid #2b3948;border-radius:10px;padding:18px}img,video{width:100%;height:auto;display:block;border-radius:5px}summary{cursor:pointer;color:#ffcf88}li{margin-bottom:8px}
@media(max-width:800px){main{grid-template-columns:1fr}header,main,footer{padding:16px}}
</style><header><h1>__TITLE__</h1>
<p>__DESCRIPTION__</p>
<p>__STATUS__</p></header><main>'''
for token, key, default in [
    ('__TITLE__', 'gallery_title', 'AFTERHUMAN · Starting frames'),
    ('__DESCRIPTION__', 'gallery_description', 'Five different locations. Four first-person powers and an overhead race. Click any image for its native file.'),
    ('__STATUS__', 'gallery_status', 'Image concepts pending your review. No new videos or sound effects generated.'),
]:
    page = page.replace(token, escape(batch.get(key, default)))
page += '\n'.join(cards)
footer = batch.get('gallery_footer', 'GPT Image 2 via ElevenLabs · 1280×720 · One image per scene · No upscaling')
page += '</main><footer><p>' + escape(footer) + '</p></footer></html>\n'
output.write_text(page)
print(output)
