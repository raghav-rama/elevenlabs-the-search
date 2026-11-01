# Diagnostic and launch reference provenance

The authorized Seedance test uses both original videos as actual `reference_videos`, plus three approved `reference_images`. See [references.json](references.json) for stable provider IDs, exact local paths and SHA-256 hashes. No reference resize, crop, concatenation or retiming was necessary. The diagnostic video is1920×1080 /127frames /24fps; the preferred MiniMax launch is1344×768 /124frames /24fps. Both exceed the previously encountered407696-pixel input minimum.

The diagnostic upload used Creative Studio `upload_flow_reference`, followed by Playwright `setInputFiles` on `[data-id="F3uai0wFoA6K2POFAznE"] input[type="file"]`. The normal click did not open a modal file chooser, so the observed file input was assigned directly. `get_flow` confirmed asset `3dO81G7mF5cGpeXWC4Ea` before generation. The MiniMax video was reused from existing generation `ej2C9dJQ3zVUYbMXcOTm`, without another upload or render.

[Preserved media checksums](preserved-files.json) cover25 existing files. The exact paid prompt, refreshed model schema/guide, settings, quote and request IDs are in [the generation record](../../videos/shot-06-07-diagnostic-launch-seedance-480p-v01.generation.json). No signed URLs or authentication tokens are stored.
