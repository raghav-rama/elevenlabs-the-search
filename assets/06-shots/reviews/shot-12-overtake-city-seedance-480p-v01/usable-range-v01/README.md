# Overhead usable range

[Play the three-second trim](shot-12-usable-01-to-04-v01.mp4). Source 00:01.000–00:04.000, out exclusive; 72 frames at 24 fps, 854×480. No source retime or upscale. User gave approximate boundaries; this derivative is for edit review.

Reproduce from repository root with unused output names:

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/shot-12-overtake-city-seedance-480p-v01/usable-range-v01/timeline.json /private/tmp/afterhuman-overhead-usable-new.mp4
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/inspect-review-video.swift /private/tmp/afterhuman-overhead-usable-new.mp4 /private/tmp/afterhuman-overhead-usable-last.png /private/tmp/afterhuman-overhead-usable-inspection.json
```

The existing assembler re-encodes picture/audio and adds eight-millisecond audio edge fades. No gain change requested; source remains intact. [Selection record](selection.json), [export report](shot-12-usable-01-to-04-v01.edit.json), [inspection](inspection.json).

## Trim approved — 2026-11-01T20:00:11+05:30

User says “Ok good” after the delivered 00:01–00:04 trim. The three-second, original-speed range is approved for editing. Preserve the full source; final assembly timing and sound remain separate work. No new generation or spend.
