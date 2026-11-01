# Selected C tactical HUD — Seedance take 2

[Watch the 2.75-second candidate](edit-preview-v01/shot-08-hud-c-edit-preview-v01.mp4) · [Full five-second source](../../videos/shot-08-intelligence-city-seedance-480p-v02.mp4) · [Player](index.html) · [Polished start frame](../../images/shot-08-hud-c-tactical-v02.png)

The user has locked the delivered 2.75-second excerpt for the edit. C remains the selected HUD design. Full-source tail and final audio mastering are outside that range approval. Native 854×480, 24 fps, 121 frames / 5.042 seconds; stereo AAC 32 kHz / 5.056 seconds.

One GPT Image 2 medium/1K cleanup: 419.687651 credits / INR 6.09. One five-second Seedance 2.5 480p take: 6511.470000 credits / INR 94.55. Total 6931.157651 credits / INR 100.64, matching the quotes. No retries or upscale.

## Sampled review

- Selected C density remains visible: neural circle, waveform, body diagnostics, circular radar, route data and four subsystem dials.
- Amber route branch lights by 0.25s, with a bright cyan radar route by approximately 0.75s.
- A clear bright pulse travels up the real ramp at approximately 2.25–2.9s; city and first-person hand composition remain recognizable.
- Panels stay mostly fixed within the view; distant train and pedestrians move, with increasing finger curl late in the take.

## Limits

- Main ramp pulse occurs later than the requested 1.3-second confirmation; no clear sustained early route-lock beat.
- Fine type and numeric readouts change or soften in animation, including the cognition multiplier. Exact production text needs an editorial pass.
- Magenta train bracket disappears around 2.9–3.0s although the HUD and train remain visible; tracking and colored pedestrian labels are not perfectly stable.
- Strong hand curl late in the source is outside the proposed excerpt. Natural motion and geography still need user playback judgment.
- Native audio has been decoded and level-checked only; speech absence, chirp timing and mix continuity have not had an independent listening review.
- Proposed 2.75-second excerpt is not user-selected and has not replaced the shot in the accepted ad.

## Proposed excerpt

Source [0.25, 3.00), frames 6–71 inclusive, gives 66 frames / 2.75 seconds at original speed. Includes radar activation and the bright ramp pulse. The magenta target bracket disappears near the end; this remains a source limitation. Stronger late finger curl is omitted. The accepted ad is unchanged.

Local re-encode at native dimensions, zero requested gain and the existing assembler's eight-millisecond audio edge fades. Export emitted its known non-interleaved-audio-setting warning and completed successfully; decoded excerpt has one stereo track.

[Contact sheet](contact-sheet.jpg) · [Route detail](route-detail.jpg) · [Native audio](native-audio.wav) · [Inspection](inspection.json) · [Review](review.json) · [Generation record](../../videos/shot-08-intelligence-city-seedance-480p-v02.generation.json) · [Exact prompt](../../video-prompts/shot-08-intelligence-city-seedance-480p-v02.txt)

## Reproduce

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/city-intelligence-seedance-batch-v02.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-08-intelligence-city-seedance-480p-v02.mp4 /private/tmp/afterhuman-hud-c-detail-new.jpg 1.75 0.25 6 2 854 480
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/shot-08-intelligence-city-seedance-480p-v02/edit-preview-v01/timeline.json /private/tmp/afterhuman-hud-c-preview-new.mp4
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/city-intelligence-seedance-batch-v02.json /private/tmp/afterhuman-hud-c-player-new
```

Use fresh derivative output paths. The original C still, previous sparse-HUD video, approved overhead range and current 45-second ad remain intact.

## User selection — 2026-11-01T21:08:16+05:30

User says “Lock it and continue.” The delivered 2.75-second excerpt is locked for the edit at original speed. Full-source tail remains archival; prior observations and audio limits are preserved. Coffee-reflex production is next.
