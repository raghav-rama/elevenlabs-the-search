# Prepared running reference

Use [running-rightward-3s-v02.mp4](running-rightward-3s-v02.mp4).

- Three seconds, 1280×720, 24 fps, silent.
- Source excerpt: 1.0–26.2 seconds, played at 8.4× and horizontally mirrored.
- Approximately nine new alternating landings in three seconds. The clip starts during an ongoing stride; the initial planted foot is separate from the new landings.
- Reviewed the [contact sheet](contact-sheet-v02.png) and [every frame of the final second](final-second-v02.png). Timing is approximate visual annotation, not motion-capture measurement.
- Tracking lines, treadmill, and the obstructing stand remain visible. This is a prepared motion reference, not cleaned final footage.

Version 01 used 7.8× and was slightly below the requested cadence; it is retained as a preparation iteration. The user accepted version 02, which drove shot 1 take 5. The speed multiplier matches the requested creative rhythm; it is not a claim about the original recording's real-time speed.

Generated ad takes were not retimed. Exact settings and hashes accompany each MP4 in a `.preparation.json` file; those records describe the preparation-time state, before user acceptance and model submission. The downloaded original is currently absent from its recorded path. Restore that local source to reproduce the preparation; prepared outputs remain available.

Reproduce version 02 into a new filename with:

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/references/prepared-running/prepare-reference.swift \
  'assets/references/Slow motion running - side view (focus on legs).mp4' \
  assets/references/prepared-running/running-rightward-3s-reproduction.mp4
```
