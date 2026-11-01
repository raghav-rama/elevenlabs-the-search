# Matched-boulevard overhead — Seedance take 1

[Watch native take and sprint context](index.html) · [Native MP4](../../videos/shot-12-overtake-boulevard-seedance-480p-v01.mp4)

Generated exactly one five-second **Seedance 2.5 / 480p** take from the exact image attached and approved by the user. Cost **6,511.47 credits / ₹94.55**, matching the live estimate. No retry, new still or upscale.

The broad wet boulevard, railway on the left, glass frontage on the right, amber bollards and cyan planters now follow the approved image. The train stays aligned with its track and Riley stays on the separate boulevard. The intended full pass is missing: she closes the gap in the middle but does not clearly get her whole body and boots ahead of the nose, and the gap widens again toward the end. **Not recommended for final selection yet.** User review remains pending.

Native output: 852×480, 24 fps, 121 picture frames / 5.042 seconds; stereo AAC 32 kHz / 5.056 seconds. Full decode passed with no near-black frames. Sampled 21 overview frames, 16 finer stride frames and the native 2.25-second/ending frames. Audio decoded at RMS −31.027 dBFS and sample peak −12.009 dBFS; no independent listening claim.

The optional 5.5-second context preview joins the approved sprint range [0.75,3.25) to new overhead [1,4), at original speed, with the existing v07 mix from [36.875,42.375). It is a timing/world comparison, not approval of that overhead range. The new native effects are muted in context; the existing mix excerpt is decoded and re-encoded with normal edge fades. The complete native take retains its generated audio separately.

Approved v07 remains unchanged at 44.875 seconds. No new full cut, retiming or Final Cut project changes. A future motion correction should use a matching end frame with Riley's trailing boots clearly ahead of the train nose; no further generation was started.

Prompt, live schema/guide, settings, quote, request IDs and output hash are saved in the linked generation record. The exact supplied reference is archived with provenance under ../../references/boulevard-overtake-v01/.

Reproduce inspection with:

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/boulevard-overhead-seedance-batch-v01.json
```

For the context use scripts/assemble-continuation.swift with context-review-v01/timeline.json and a fresh output filename. Existing source and output files are preserved.
