# Coffee reflexes — two-part MiniMax prototype v04

**Current selection (2026-11-01T23:38:50+05:30):** MiniMax v04 TPP is the user-preferred catch. Combined edit retained; no final ad lock implied.

[Combined 10-second review](shot-09-coffee-split-review-v04.mp4) · [Browser player](index.html) · [Keyframes](../coffee-split-keyframes-v01/index.html)

- [A: fast FPP run, native 5.167s](../../videos/shot-09-coffee-fpp-run-minimax-v04.mp4)
- [B: TPP orbit/catch, native 8s](../../videos/shot-09-coffee-tpp-orbit-minimax-v04.mp4)

Both are MiniMax H3 Max / 480p from dedicated starting frames. Neither is locked. The hero mug first appears already airborne in B: the man never visibly releases it. B has continuous camera travel, a visible catch, handback and fast departure. The FPP side glance is too gradual and the reaching hand remains slow. Eye motion and reverse-angle geography still need refinement. Some small table cups are generated in A's background despite the cup-free keyframe.

The edit uses A frames 23–71 (0.958333–3.000s) and B frames 0–190 (0–7.958333s), totaling 240 frames / 10.000s at 24 fps. Native 832×480, fit framing, original speed, hard picture cut. No retiming, interpolation, synthesized head turn, upscale or accepted-cut change.

Native audio only: A -2 dB, B +8 dB, short 25ms half crossfade, 8ms outer fades. Numeric decoded AAC peak is -2.950 dBFS. No new voice/music/SFX assets; no independent listening or speech-content approval. Locked David and Chrome Swagger are unchanged.

## Cost and provenance

Two GPT Image 2 low/1K stills: 940.992432 credits / INR 13.66. Two MiniMax videos: 3,939 credits / INR 57.19. Total **4,879.992432 credits / INR 70.86**. Exactly one generation per image/clip; no paid retry or automatic variant. All charges match quotes.

[Image batch](../../images/coffee-split-keyframes-batch-v01.json) · [Video batch](../../videos/coffee-split-minimax-batch-v04.json) · [Timeline](timeline.json) · [Edit provenance](shot-09-coffee-split-review-v04.edit.json) · [Inspection](inspection.json) · [Review](review.json) · [Verification](verification.json)

Visual review uses native starting frames, full-frame decode and sampled contact sheets, including 0.125-second reaction/catch samples. It is not a real-time playback review. Native sources, approved fallback and existing ad are preserved.

## Reproduce without another generation

From repository root; review helpers preserve existing files. Use a fresh output path for assembly/gallery.

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/coffee-split-minimax-batch-v04.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/coffee-split-minimax-v04/timeline.json /private/tmp/coffee-split-review-new.mp4
python3 scripts/build-startframe-gallery.py assets/06-shots/reviews/coffee-split-minimax-v04/gallery-batch.json /private/tmp/coffee-split-gallery-new
python3 scripts/build-startframe-gallery.py assets/06-shots/images/coffee-split-keyframes-batch-v01.json /private/tmp/coffee-keyframes-gallery-new
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-coffee-tpp-orbit-minimax-v04.mp4 /private/tmp/coffee-tpp-full-new.jpg 0 0.3333333333 25 5 416 240
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-coffee-tpp-orbit-minimax-v04.mp4 /private/tmp/coffee-tpp-catch-new.jpg 0 0.125 21 5 416 240
```
