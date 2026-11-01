# AFTERHUMAN — Product clarity review v02

[Watch the new 45-second cut](afterhuman-product-clarity-v02.mp4) · [Open the player](index.html) · [City design and overhead staging board](../../06-shots/reviews/city-continuity-v01/index.html)

Adds **AFTERHUMAN / CYBERNETIC IMPLANTS** in the lower-left during the transformation, from 12.833 to 17.333 seconds with short fades. The final spiral/card now repeats **CYBERNETIC IMPLANTS**, retaining **A STEP AHEAD.** Exact copy is rendered editorially.

The 45-second timing, source action, full coffee shot, David narration, Chrome Swagger and sound mix remain intact. The original AAC payload is passed through and verified byte for byte; this is not a new speech/music generation or mix. Original v01 and every source are preserved.

The scene environments and overhead footage still use the current prototypes. Their redesign is prepared in the linked reference board, with six unrun prompts and an interactive overhead diagram. No paid image/video generation or production upscale ran. New output is pending user review.

## Verification

- 45.000 seconds, 1,080 frames, 24 fps, 1920×1080 review canvas; all frames decoded, no near-black frames by the documented threshold.
- One stereo AAC 48 kHz track. Original compressed audio payload matches exactly; duration remains 45 seconds. Independent float-PCM decodes differ only at numerical precision (maximum difference about −135 dBFS); decoded WAVs are not bit-identical. See [audio comparison](audio-comparison.json).
- Sampled transformation frames show the readable product label below/left of Riley, removed before launch. Ending frame shows all three lines without overlap.
- This re-encodes the existing picture for a local preview; native low-resolution source detail is not improved. No new overhead action or city environments are claimed.
- Initial post-export verification stopped on empty zero-sample AAC boundary markers. Corrected the checker and verified the existing render; no rerender or paid retry was needed.

[Upgrade-label contact sheet](upgrade-label-contact-sheet.jpg) · [Final frame](last-picture-frame.png) · [Edit provenance](afterhuman-product-clarity-v02.edit.json) · [Delivery record](delivery.json) · [Frame inspection](inspection.json)

## Reproduction

Run from repository root with unused output paths (edit a copy of the config when choosing a different export directory):

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/render-brand-outro.swift assets/06-shots/reviews/shot-12-overtake-coastal-minimax-startframe-v01/last-picture-frame.png NEW_OUTRO.mp4 'CYBERNETIC IMPLANTS'
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/add-product-clarity.swift NEW_CONFIG.json
```

Set `outro` and `output` in the copied [configuration](product-clarity-config.json) to the new paths. The label export replaces the 2.5-second outro, renders the label over the existing review picture and remuxes its original compressed audio. Existing outputs and provenance files are refused. `--verify-existing` only rechecks a completed export and creates missing provenance after an interrupted verification; it does not render or overwrite media. The source hash remains mandatory.
