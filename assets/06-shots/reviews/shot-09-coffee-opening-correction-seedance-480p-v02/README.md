# Coffee opening revision

[Watch revised 8.875-second edit](assembled-review-v03/shot-09-coffee-revised-v03.mp4) · [Player](index.html) · [Opening contact sheet](assembled-review-v03/opening-review.jpg)

**User rejected this edit on 2026-11-01.** Retained for history. The next requested test uses MiniMax and a slow-motion camera orbit.

One four-second Seedance 2.5 / 480p correction cost **5,209.176 credits / INR 75.64**. The raw generation improved forward running and made catch contact visible, but did not produce the requested physical left head turn or already-falling first reveal. No retry was submitted. This local recut is a review candidate, not a locked replacement.

## Proposed sequence

| Edit time | Picture | Source frames at 24 fps |
|---|---|---|
| 0–1.500s | Forward FPP run | Correction 0–35 |
| 1.500–1.625s | Mug already airborne in FPP | Original 32–34 |
| 1.625–2.750s | Visible TPP catch | Correction 69–95 |
| 2.750–8.875s | Original crouch, handoff and sprint | Original 96–242 |

All source ranges run at original speed. A local screen-right shift and directional blur on edit frames 32–35 suggest a leftward glance before the airborne insert. This is an editorial cue, not a generated head rotation or newly revealed three-dimensional scene. The patron remains visible on the left during the forward run.

The three-frame airborne glimpse is brief. Review its legibility, the camera/cup continuity into TPP and the small pose change at the original crouch join. The edit is 1.25 seconds shorter than the prior 10.125-second slot; the accepted ad is unchanged. The earlier assembled-review-v02 folder contains an unselected longer base edit; its planned whip-pan final was never rendered.

## Evidence and limits

Final export: 854×480, 24 fps, 213 frames / 8.875s; stereo AAC 48 kHz. Full decode found no near-black frames. Raw generation: 854×480, 24 fps, 97 frames / 4.042s. Native source audio RMS -33.096 dBFS, peak -13.756 dBFS. Numeric levels and sampled frames do not establish independent playback, listening approval or a final sound mix.

[Timeline](assembled-review-v03/timeline.json) · [Edit review and hashes](assembled-review-v03/review.json) · [Cue provenance](assembled-review-v03/shot-09-coffee-revised-v03.cue.json) · [Inspection](assembled-review-v03/inspection.json) · [Raw correction](../../videos/shot-09-coffee-opening-correction-seedance-480p-v02.mp4) · [Generation record](../../videos/shot-09-coffee-opening-correction-seedance-480p-v02.generation.json) · [Exact prompt](../../video-prompts/shot-09-coffee-opening-correction-seedance-480p-v02.txt)

The unused full-video reference configuration quoted 11,776.905101 credits / INR 171.00. Replacing it with an extracted native pose still reduced the quote before submission. Only the final 5,209.176-credit run was submitted. Four still references, no new image generation; no automatic retry, upscale, accepted-cut overwrite, commit or push.

## Reproduce locally

Run from repository root with fresh output paths. Copy the saved cue config and point it to the rebuilt base; do not overwrite reviewed files.

```sh
coffee_work=$(mktemp -d /private/tmp/afterhuman-coffee-recut.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/shot-09-coffee-opening-correction-seedance-480p-v02/assembled-review-v03/timeline.json "$coffee_work/base.mp4"
python3 - "$coffee_work" <<'PYCFG'
import json, sys
from pathlib import Path
work = Path(sys.argv[1])
config = json.loads(Path('assets/06-shots/reviews/shot-09-coffee-opening-correction-seedance-480p-v02/assembled-review-v03/whip-pan-config.json').read_text())
config.update(input=str(work/'base.mp4'), output=str(work/'revised.mp4'))
(work/'cue.json').write_text(json.dumps(config, indent=2)+'\n')
PYCFG
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/add-whip-pan-cue.swift "$coffee_work/cue.json"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/inspect-review-video.swift "$coffee_work/revised.mp4" "$coffee_work/last.png" "$coffee_work/inspection.json"
```

No provider calls in reproduction. Export byte hashes can vary. Original sources, locked HUD/overhead excerpts and accepted ad are preserved.
