# Floating-body diagnostic components

Selected for the new local review: [picture v02](upgrade-diagnostic-picture-v02.mp4), a silent 127-frame / 5.291667-second insert placed at full-cut 12.833333s. The user approves the rendered motion/edit direction. “Selected” here means the corrected component used for assembly; final production polish remains open.

[Full cut and focused preview](../continuous-ad-review-v03/index.html) · [Final configuration](diagnostic-config-v02.json) · [Render record](upgrade-diagnostic-picture-v02.edit.json) · [Source mattes and pose record](mattes/mattes.json)

The source is frames 308–434 inclusive of the preserved continuous review v01. Each source frame retains its original time. Local Apple Vision foreground masks isolate Riley; Core Image and Core Graphics move her body, dim the station, render a translucent diagnostic network and type exact text. No provider generation or credits. Apple documents [foreground instance masks](https://developer.apple.com/documentation/vision/vninstancemaskobservation/generatescaledmaskforimage%28forinstances%3Afrom%3A%29) and [body-pose detection](https://developer.apple.com/documentation/vision/detecting-human-body-poses-in-images).

## Motion and limitations

The body eases from source pivot (1057,560) to (960,595), scales to 0.92, then returns during insert 3.85–5.0s. Coordinates use the compositing canvas's bottom-left origin. The remaining seven frames are back in original placement. The scan uses pose-guided lines, approximate ribs and spine, joints and implant callouts; it is not photoreal anatomy. Dark boots require explicit ankle guide positions in the renderer.

A local adjacent-background patch fills the original body position while the station is blurred/dimmed. This is a temporary mock-up technique, not a final clean plate. Matte edges, movement and reconstruction need production review. The supplied cyberware screenshot is only inspiration and is not composited into the output.

## Retained experiments

- `matte-test/`: rejected person-segmentation test omitted the boots. Retained as a failed test, not used in assembly.
- `matte-test-foreground/`: successful foreground-mask trial, followed by all 127 masks in `mattes/`.
- `upgrade-diagnostic-picture-v01.mp4`: first successful local render had a brief integration-counter/completion-label overlap. Preserved, superseded by v02.
- `frames/` and `source-upgrade-contact.jpg`: initial review images. The source contact sampling is approximate; the renderer checks exact source frame timestamps.
- `upgrade-diagnostic-picture-v02-frames/`: samples from the final corrected insert.
- Initial Swift compilation timed out while type-checking a large closure; extracting `renderFrame` fixed compilation before any successful render. No paid retry.

## Sound

[Full 45-second sound mix](afterhuman-diagnostic-mix-v01.wav), [effects-only stem](afterhuman-diagnostic-mix-v01-effects-only.wav) and [mix report](afterhuman-diagnostic-mix-v01.mix.json) preserve original voice/music timing and add deterministic local UI accents. Place the stem at 12.833333s. It lasts 5.291667s. Base floating-point samples outside that window were unchanged before WAV quantization and final AAC encoding. No independent listening/mastering claim.

The final assembler applies a negligible peak-ceiling adjustment. Refer to the full-cut export record for the delivered audio level. Use the full review rather than the silent insert to judge the effect with narration and music.

See [scripts guide](../../../scripts/README.md) for reproducible commands. Use fresh output paths; do not overwrite these review records.
