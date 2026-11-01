# Coffee reflexes — Seedance city take 1

[Watch the 10.125-second candidate](edit-preview-v01/shot-09-coffee-edit-preview-v01.mp4) · [Full source](../../videos/shot-09-coffee-city-seedance-480p-v01.mp4) · [Player](index.html)

User likes the overall shot but requested an opening correction. See the [revised edit and its limitations](../shot-09-coffee-opening-correction-seedance-480p-v02/README.md). This source remains preserved and unselected. One Seedance 2.5 take at 480p with native audio. Source is 854×480, 24 fps, 265 frames / 11.042 seconds; stereo AAC 32 kHz / 11.072 seconds. Actual cost **14,325.234 credits / INR 208.00**, matching the live quote. No retries, new stills or upscale.

The approved cafe composition, Riley face and gold wardrobe/body styling were wired as three image references. Reference-only mode permits all three together; start/end-frame mode cannot. Opening composition is guided by the cafe reference, not guaranteed pixel-identical.

## Sampled findings

- Opening closely follows the approved first-person cafe image and approaches the distinct male stranger with a single white mug.
- The mug visibly tilts, separates from the man's hand and drops at approximately 1.25–1.5s, rather than being intentionally handed over.
- By 2.25s Riley is revealed crouching with the caught mug; short brunette bob, asymmetric cyberware, gold dress, boots and mostly natural skin follow the approved references.
- The same mug is returned around 5.5–7s; the man's hand closes on it before Riley withdraws.
- Riley pivots around 8s and accelerates away with strong parallax and cyan motion streaks; city lighting and materials are broadly consistent.

## Limits

- The generated FPP-to-TPP move inserts a tight face/eye shot around 1.6–2.1s. Exact hand-to-mug catch contact is hidden, so the intended uninterrupted visible rescue is not fully achieved.
- Slow motion lingers on the already-caught mug/crouch for several seconds; performance and pacing still need user judgment.
- Full-source cafe and rail sides reverse around 10.4s. The proposed first-10.125-second excerpt excludes this visible ending error.
- Running anatomy, physical contact and exact facial likeness have only been inspected in sampled frames; this is not a user-approved replacement.
- Native audio is decoded and level-checked only; no independent listening approval, speech-absence verification or final sound mix.
- Existing locked MiniMax coffee and accepted ad remain unchanged; this new take and excerpt are review candidates.

## Proposed edit

Source [0.000,10.125), frames 0–242 inclusive, gives 243 frames / 10.125 seconds at original speed. The shortened review omits the final cafe/rail reversal and fits the existing coffee slot. It does not fix the face insert hiding the exact catch. The full source and accepted ad are retained unchanged.

Local re-encode at native dimensions, zero requested audio gain, existing assembler's eight-millisecond audio edge fades. The known non-interleaved-audio-setting warning did not prevent successful export/decode. Native source audio RMS -26.440 dBFS / peak -3.666 dBFS; independent listening and final sound mix remain open.

[Contact sheet](contact-sheet.jpg) · [Drop/catch detail](drop-catch-detail.jpg) · [Exit detail](exit-detail.jpg) · [Native audio](native-audio.wav) · [Inspection](inspection.json) · [Review](review.json) · [Exact prompt](../../video-prompts/shot-09-coffee-city-seedance-480p-v01.txt) · [Generation record](../../videos/shot-09-coffee-city-seedance-480p-v01.generation.json)

## Reproduce

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/city-coffee-seedance-batch-v01.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-coffee-city-seedance-480p-v01.mp4 /private/tmp/afterhuman-coffee-drop-new.jpg 1.0 0.125 13 3 640 360
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-coffee-city-seedance-480p-v01.mp4 /private/tmp/afterhuman-coffee-exit-new.jpg 9.5 0.25 7 2 854 480
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/shot-09-coffee-city-seedance-480p-v01/edit-preview-v01/timeline.json /private/tmp/afterhuman-coffee-preview-new.mp4
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/city-coffee-seedance-batch-v01.json /private/tmp/afterhuman-coffee-player-new
```

Use fresh derivative outputs. HUD excerpt is locked. This coffee source and proposed excerpt remain unselected; the previously locked MiniMax coffee remains preserved. Station takeoff, strength and speed still await Seedance production.
