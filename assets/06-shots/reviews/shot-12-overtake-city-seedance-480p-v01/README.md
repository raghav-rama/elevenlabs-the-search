# Overhead train overtake — Seedance take 1

[Play native video](../../videos/shot-12-overtake-city-seedance-480p-v01.mp4) · [Player](index.html) · [ElevenLabs Flow](https://elevenlabs.io/app/flows/3dGbKlj9VZitLDr91dyM)

**Pending user review; not selected or inserted into the approved cut.** One five-second Seedance 2.5 request at 480p, with native audio. Actual source is 854×480, 24 fps, 121 picture frames / 5.042 seconds; AAC audio is 5.056 seconds. Cost: **6,511.47 credits / INR 94.55**. No retry, upscale, other video generation or source retime.

## Sampled visual review

- The train stays longitudinally aligned with the right-hand rails, with its nose facing upward throughout sampled frames.
- One Riley remains on the separated left lane. She begins behind the train nose and finishes with her entire body and both boots clearly ahead.
- Finer temporal samples show changing leg positions rather than one frozen running pose. The train and Riley remain separate without crossing paths.
- The gold dress, dark bob, black boots and bright cyberpunk city palette follow the approved references; no generated titles are visible.
- A wider elevated-lane junction passes through the middle of the shot, introducing more environment geometry than the starting still.

## Limits and remaining review

- Full-speed playback is still needed to judge whether the sprint feels superhuman and whether camera, train, lane and distant-building motion remain coherent through the junction.
- Exact foot contacts, facial likeness and fine chrome detail cannot be certified at this distant native 854x480 scale.
- Native audio is retained and level-checked, but speech absence, effect quality and continuity with the approved mix are not independently verified.
- The clip is pending user selection. No final-cut replacement, retiming, upscale or other paid take has been made.

[Full contact sheet](contact-sheet.jpg) · [Stride detail](stride-detail.jpg) · [Ending frame](last-frame.png) · [Native audio](native-audio.wav) · [Review](review.json) · [Inspection](inspection.json)

[Exact prompt](../../video-prompts/shot-12-overtake-city-seedance-480p-v01.txt) · [Generation record](../../videos/shot-12-overtake-city-seedance-480p-v01.generation.json) · [Batch](../../videos/city-overhead-seedance-batch-v01.json)

The selected start/end images, approved 45-second diagnostic cut, David and Chrome Swagger remain unchanged.

## Reproduce local checks

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/city-overhead-seedance-batch-v01.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-12-overtake-city-seedance-480p-v01.mp4 /private/tmp/afterhuman-overhead-stride-new.jpg 0.5 0.0833333333 12 3 854 480
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/city-overhead-seedance-batch-v01.json /private/tmp/afterhuman-overhead-player-new
```

Use fresh output paths for the detail sheet and player. The review helper preserves existing inspection files. Sampled image review and successful audio decoding do not establish full playback/listening approval.

## User feedback — 2026-11-01T19:57:18+05:30

The user finds the gradual acceleration/deceleration unsuitable outside roughly 00:01–00:04. [Review the usable middle three seconds](usable-range-v01/shot-12-usable-01-to-04-v01.mp4).

The derived review keeps source frames 24–95 at original 24 fps: exactly 72 frames / three seconds / 854×480. Exact boundaries remain open to review. It is re-encoded locally by the existing assembler, with zero added audio gain and its normal eight-millisecond audio edge fades. No generation or credit cost. Original source and assembled ad are unchanged.

The current overhead slot spans 38.5–42.5 seconds, so replacing it with this three-second range leaves one second to redistribute during assembly. A possible edit is to extend the preceding speed shot by one second; no timing change has been made. Do not stretch this excerpt to fill four seconds.

[Selection and provenance](usable-range-v01/selection.json) · [Trim timeline](usable-range-v01/timeline.json) · [Inspection](usable-range-v01/inspection.json)

## Trim approved — 2026-11-01T20:00:11+05:30

User says “Ok good” after the delivered 00:01–00:04 trim. The three-second, original-speed range is approved for editing. Preserve the full source; final assembly timing and sound remain separate work. No new generation or spend.
