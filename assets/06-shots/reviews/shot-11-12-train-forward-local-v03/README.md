# Stopped local train-tracking diagnostic

No corrected video was rendered. The user stopped work and selected the unchanged v07 full ad for publication.

`inspect-train-world-motion.py` records a proposed path and stationary-feature homographies; it is not a working video correction. Tracking matched the later overhead reasonably, but early perspective/parallax alignment was insufficient. Three tracker attempts ran locally; the first two stopped on too few surviving points, and the third produced diagnostics.

Reproduction of diagnostics only:

```sh
uv run --python 3.12 --with numpy --with opencv-python-headless --with imageio-ffmpeg python assets/06-shots/reviews/shot-11-12-train-forward-local-v03/inspect-train-world-motion.py assets/06-shots/videos/shot-11-12-fpp-overhead-seedance-480p-v01.mp4 /private/tmp/afterhuman-train-tracking
```
