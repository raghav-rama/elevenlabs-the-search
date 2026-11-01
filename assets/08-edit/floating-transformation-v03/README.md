# Refined floating-transformation masks v03

Same 127-frame transformation and float as v02, with repaired foreground extraction. Source: verified 2× Topaz station take, frames 162–288. Mask coordinate space: conformed 1920×1080, bottom-left origin; tight source crop `[850,130,430,880]`. Original pose records and all motion/typography settings retained.

Tested five frames using cropped foreground, person and hybrid segmentation. Foreground retained the limbs best; person/hybrid introduced weaker edges and were not selected. `test-clean` had the right lamp-cleanup window in the wrong position; `test-clean-v02` corrected its position but left small projections. The final matte-config uses foreground segmentation, small morphology regions and two bounded exclusions for fixed station lights outside the arms while raised. All tests retained as provenance.

`matte-config.json` drives scripts/refine-upgrade-mattes.swift. `config.json` drives the existing scripts/render-upgrade-diagnostic.swift. No external model or provider generation. The script refuses existing output directories. Configuration preserves the original mask record source/hash for renderer compatibility and explicitly records the actual Topaz segmentation source/hash separately.

Final mask previews include original source, old cutout and refined cutout at sampled frames. The complete 127-frame mask sequence is retained. Final arm-visibility check also uses the encoded full-cut frame at 14.5 seconds. Original files and earlier masks are preserved.
