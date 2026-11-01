# Continuous diagnostic and launch — Seedance480p v01

[Play native take](../../videos/shot-06-07-diagnostic-launch-seedance-480p-v01.mp4) · [Review player](index.html) · [Exact generation record](../../videos/shot-06-07-diagnostic-launch-seedance-480p-v01.generation.json) · [Reference provenance](../../references/diagnostic-launch-seedance-v01/README.md)

One user-authorized Seedance2.5 take, requested eight seconds/480p/16:9. Native854×480,24fps,193 picture frames/8.042s; AAC stereo32kHz,8.064s. Reported14,436.450168credits /₹209.62 matches the quote. Generation `CeI75xz4e5uwe849gN9N`, session `4pDBLjaLuF9VQzubhCHY`. SHA-256 `dacbdc7e5c7f03047dcfd91251b4d4554d0d20b54fe88bb740aca22533c7841d`. One generation, no retry.

## Review

The render incorporates the actual diagnostic and MiniMax launch videos: central cyan scan with typed AFTERHUMAN/product/ability labels, gradual return to the station, then a fast leftward/away launch. Major labels are readable in the native3.125s sample. Train stays absent; gold outfit and human skin broadly remain.

The timing is not fully met: she settles around5.0s, starts turning around5.6–5.9s and strongly accelerates around6.3s. The prompt asked for running by5.5s. Small terminal text is soft and the station framing shifts slightly during the return. Bright trails match MiniMax but dominate the late frame. Pending user review; not selected. The native file has not been locally cut, retimed, resized, sharpened or upscaled.

[Overview](contact-sheet.jpg) · [Return detail](return-detail.jpg) · [Diagnostic text at3.125s](diagnostic-text-3_125s.png) · [Review record](review.json) · [Inspection](inspection.json) · [Verification](verification.json)

Full picture decode found no near-black frames. Native audio measured RMS−25.016dBFS /peak−6.817dBFS; numeric analysis only, no independent listening claim. Existing David narration, Chrome Swagger jingle and accepted45s cut remain untouched.

## Reproduce local inspection

Run from the repository root. The batch helper skips existing inspection artifacts. Use fresh output filenames/directories for a repeat of the other commands; none starts provider generation.

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/diagnostic-launch-seedance-batch-v01.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-06-07-diagnostic-launch-seedance-480p-v01.mp4 /private/tmp/afterhuman-diagnostic-launch-return-new.jpg 4 0.08333333333333333 24 4 427 240
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/extract-video-frame.swift assets/06-shots/videos/shot-06-07-diagnostic-launch-seedance-480p-v01.mp4 3.125 /private/tmp/afterhuman-diagnostic-launch-text-new.png
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/diagnostic-launch-seedance-batch-v01.json /private/tmp/afterhuman-diagnostic-launch-gallery-new
```

The two original videos were supplied separately on `reference_videos`; face, wardrobe and station stills were on `reference_images`. No `start_frame`/`end_frame` inputs were mixed in. Exact prompt, live schema/guide, effective settings, quote, input IDs/hashes and submission are preserved in the generation record. This generation is a new continuous candidate, not a replacement of the accepted timeline.

## User approval — 2026-11-02T01:09:23+05:30

User: “Okay looks good. Let's move on.” This combined take is approved for use; earlier technical observations remain as review history. Native video preserved. Continue with a new full narrated review assembled from the latest selected/preferred shots.
