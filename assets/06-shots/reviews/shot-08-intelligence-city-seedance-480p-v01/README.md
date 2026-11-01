# Intelligence HUD — Seedance take 1

[Proposed 2.75-second edit preview](edit-preview-v01/shot-08-hud-edit-preview-v01.mp4) · [Full five-second source](../../videos/shot-08-intelligence-city-seedance-480p-v01.mp4) · [Player](index.html) · [ElevenLabs Flow](https://elevenlabs.io/app/flows/3dGbKlj9VZitLDr91dyM)

**Pending user review; no ad replacement or source selection.** One Seedance 2.5 generation: 480p / five seconds / native audio. Actual source: 854×480, 24 fps, 121 frames / 5.042 seconds; stereo AAC 32 kHz / 5.056 seconds. **6,511.47 credits / INR 94.55**, matching the quote. No retry or upscale.

## Sampled findings

- Transparent cyan HUD, pedestrian-ramp route arrows and upper-right map stay visible throughout sampled frames.
- Horizontal scan traverses the view early; the upper-right selected cyan branch becomes bright around 2.0 seconds.
- Magenta rail bracket tightens and a cyan destination/confirmation diamond appears around 3.5 seconds, later than the prompted 1.5-second lock.
- First-person viewpoint remains behind the parapet with one natural skin hand and narrow chrome/cyan inlays; bright cyberpunk architecture is coherent with the approved starting image.
- The train and pedestrians move while the hand makes small finger movements. Camera leans slightly toward the ramp late in the take.

## Limits

- Full-source confirmation is late for the 2.75-second edit slot. A proposed original-speed [1.25,4.00) preview includes the scan tail, route highlight and final cue; it is not user-approved or inserted into the ad.
- The upper-left NEURAL LINK heading becomes partly obscured near the source ending as the viewpoint changes; HUD is not perfectly fixed to the viewer. Exact typography/tracking may need editorial cleanup.
- Competing-route evaluation is subtle and the pedestrian route is present from the beginning, so the shot may read more as navigation than an unmistakable comparison of alternatives.
- The train appears to progress toward screen right rather than the requested leftward motion; confirm intended geography in the assembled sequence before locking.
- Native audio is decoded/level-checked only. Speech absence, scan/confirmation sound timing and continuity with David/Chrome Swagger are not independently verified.
- Fine hand anatomy, optical tracking and perceived intelligence/action clarity require user playback review. No retake or upscale has been started.

## Proposed edit

Source 00:01.25–00:04.00, frames 30–95 inclusive, produces 66 frames / 2.75 seconds at original speed. It matches the existing intelligence slot length without changing the assembled ad. Local re-encode at native dimensions; zero requested audio gain and normal 8 ms edge fades. No new credits. Preview remains unapproved.

[Full contact sheet](contact-sheet.jpg) · [Route-lock detail](route-lock-detail.jpg) · [Ending frame](last-frame.png) · [Native audio](native-audio.wav) · [Review JSON](review.json) · [Inspection](inspection.json)

[Exact prompt](../../video-prompts/shot-08-intelligence-city-seedance-480p-v01.txt) · [Generation record](../../videos/shot-08-intelligence-city-seedance-480p-v01.generation.json) · [Batch](../../videos/city-intelligence-seedance-batch-v01.json) · [Preview timeline](edit-preview-v01/timeline.json) · [Preview selection](edit-preview-v01/selection.json)

## Reproduce checks and preview

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/city-intelligence-seedance-batch-v01.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-08-intelligence-city-seedance-480p-v01.mp4 /private/tmp/afterhuman-hud-detail-new.jpg 1.25 0.25 11 3 854 480
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/shot-08-intelligence-city-seedance-480p-v01/edit-preview-v01/timeline.json /private/tmp/afterhuman-hud-preview-new.mp4
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/city-intelligence-seedance-batch-v01.json /private/tmp/afterhuman-hud-player-new
```

Use fresh derivative output paths. No source retiming or overwrite. Native audio has not had an independent listening review. Approved overhead range and current 45-second ad remain intact.

## HUD revision requested — 2026-11-01T20:25:29+05:30

User requests more HUD elements, in an Iron Man-like direction. This take and proposed excerpt are preserved but not selected. [Three new still concepts](../intelligence-hud-concepts-v01/index.html) await selection before a fresh video.
