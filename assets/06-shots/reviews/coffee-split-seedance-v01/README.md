# Seedance coffee orbit — one-take comparison

**Current selection (2026-11-01T23:38:50+05:30):** Seedance test not selected: user prefers MiniMax v04 TPP. Both versions retained for comparison.

[New ten-second review](shot-09-coffee-seedance-review-v01.mp4) · [Comparison player](index.html) · [Individual Seedance take](../../videos/shot-09-coffee-tpp-orbit-seedance-480p-v01.mp4)

The same liked MiniMax FPP excerpt leads into the new Seedance TPP orbit/catch. No visible cup release. There is a continuous broad camera arc, handback and fast cyan-wake departure. The catch is still slow: contact about 2.125–2.5s versus the requested 1.1s, and later than the MiniMax take. The eye reaction reads mainly downward, with little distinct sideways flick. The cup remains suspended for much of the slow-motion setup. Treat this as a comparison candidate, not an automatic upgrade or selected replacement.

One Seedance 2.5 / 480p / eight-second request, actual 854×480 / 24fps / 193 picture frames / 8.042s. Stereo AAC 32kHz, 8.064s track duration. Cost **10,418.352 credits / INR 151.27**, matching quote. No retries, new stills or extra audio generation. Start image reused from the liked MiniMax test.

Ten-second edit: unchanged FPP frames23–71 (49 frames), then Seedance frames0–190 (191 frames). Original speed, hard perspective cut, fit framing on 854×480 canvas; FPP has narrow side bars. Native audio A -2dB, Seedance -1dB with short fades. Decoded AAC peak -4.927dBFS. No VO/music changes, no retiming, optical flow, artificial camera turn, upscaling or accepted-cut replacement.

[Generation record](../../videos/shot-09-coffee-tpp-orbit-seedance-480p-v01.generation.json) · [Batch](../../videos/coffee-tpp-orbit-seedance-batch-v01.json) · [Timeline](timeline.json) · [Edit provenance](shot-09-coffee-seedance-review-v01.edit.json) · [Review](review.json) · [Verification](verification.json)

Visual review uses native starting frame, sampled contact sheets and full decode; it is not real-time playback or listening approval. Native audio RMS -25.366dBFS and peak -3.885dBFS. Speech content and subjective continuity require listening review.

## Reproduce locally without another generation

Run from repository root; use fresh output paths for assembly/gallery/contact sheets.

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/coffee-tpp-orbit-seedance-batch-v01.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/coffee-split-seedance-v01/timeline.json /private/tmp/coffee-seedance-review-new.mp4
python3 scripts/build-startframe-gallery.py assets/06-shots/reviews/coffee-split-seedance-v01/gallery-batch.json /private/tmp/coffee-seedance-gallery-new
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-coffee-tpp-orbit-seedance-480p-v01.mp4 /private/tmp/coffee-seedance-catch-new.jpg 0 0.125 25 5 427 240
```
