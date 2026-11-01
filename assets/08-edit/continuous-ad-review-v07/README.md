# AFTERHUMAN — Arm-mask cleanup v07

[Play revised cut](index.html) · [MP4](afterhuman-arm-cleanup-v07.mp4) · [Before](before-frame-0348.png) / [after](after-frame-0348.png)

**44.875 seconds, 1,077 visible frames at exactly 24 fps.** The original transformation, central float, typed labels, return and launch timings are unchanged.

Refined the foreground masks from a tight crop of the same Topaz station footage. This restores the forearm and hand lost in v06, improves the silhouette through hand inspection, and removes small station-light projections near the elbows. Same source frames and pose records; no generated replacement body or footage.

Only timeline frames 308–434 were replaced. All **950 other decoded frames are pixel-identical** to v06. All 127 inserted frames match the corrected component, and every timestamp was checked. The **compressed AAC payload is identical** to v06, preserving the complete David/Chrome Swagger mix and native effects exactly. Original files remain intact. Zero provider credits.

AVFoundation reports an approximate container nominal rate of 23.911358 after compressed splicing. The individually verified presentation timestamps are exactly 24 fps throughout; picture/audio duration remains 44.875 seconds. See the verification and inspection JSON records.

User approved the arm-mask cleanup and v07 is the current review cut. Existing native source softness and the defocused background patch remain. The old overhead remains temporary pending separate review of the matched-boulevard reference.

Reproduction: follow scripts/README.md with fresh output paths. The delivered file uses splice-config.json; timeline.json documents the same source ranges. No Final Cut project change, commit or push.
