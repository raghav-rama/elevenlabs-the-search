# User's Final Cut opening — review export v01

`fcp-opening-review-v01.mov` is a byte-identical copy of the export supplied from
Downloads. The original remains in Downloads. See `provenance.json` for its
original filename, import time and SHA-256.

- H.264 MOV, 1920x1080, 24 fps, 225 decoded frames, 9.375 seconds (00:00:09:09).
- Stereo AAC at 48 kHz; decoded duration also 9.375 seconds.
- `contact-sheet.jpg`: sampled visual review of legs, badge, chin and doors.
- `last-picture-frame.png`: actual last visible picture at 9.291667 seconds
  (00:00:09:07). Riley faces camera, full body right of center beside closed
  train doors; this establishes the composition for the next-shot match cut.
- `final-frame.png`: one trailing black frame at 9.333333 seconds
  (00:00:09:08), lasting 1/24 second. Remove this tail in the edit before joining
  the next picture; no source or Final Cut edit was made here.

The end-frame images were inspected visually after a sampled-RGB black-frame
scan. See `inspection.json` for exact decoded timestamps and hashes. Initial
inspection of compressed sample timestamps reported the final PTS at the media
endpoint; the script was corrected to inspect decoded frames before extraction.

Audio decoding measured sample peak -0.95 dBFS, RMS -21.39 dBFS and zero samples
at or above full scale. These are technical checks only. No listening review,
speech verification, true-peak or perceptual continuity assessment was performed.
The temporary decoded WAV is not a new isolated ambience stem.

This is the current user-supplied edit for planning, not a replacement approval
for earlier archived cuts. Exact VO phrase alignment remains pending. First
video tests will use MiniMax H3; no generation has started.

Reproduction commands are in [scripts/README.md](../../../scripts/README.md).
