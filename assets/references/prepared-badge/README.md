# User-recorded badge motion reference

Latest test reference: [badge-motion-3s-v03.mp4](badge-motion-3s-v03.mp4), at **1.5× speed**.
The user found take 2 too slow and suggested speeding the reference. Version 03
uses source seconds 3–7.5 in three seconds, with the same fixed crop, 720p/30 fps
output and no audio. The longer source window avoids looping or freezing the
shorter excerpt. Only the reference is retimed; generated takes are unchanged.
Reviewed the [90-frame sheet](native-frames-v03.jpg); the holder stays in frame.
The 1.5× multiplier is an assistant-selected trial, not a measured correction
from the reported six audible footsteps. Generated audio and visible badge
motion must be judged separately. Used for shot 2 take 3, which the user approved (“Looks good now.”).

Previous reference: [badge-motion-3s-v02.mp4](badge-motion-3s-v02.mp4).
User-approved before take 2. Used as the motion reference for completed shot 2 take 2; see
[the generation record](../../06-shots/videos/shot-02-take-02.generation.json).

Version 02 settings:

- Source: `../card-wiggle.MP4`, recorded and supplied by the user.
- Measured source: 20.1 seconds, 3840×2160, nominal 30 fps, one audio track.
- Selected range: **3.0–6.0 seconds**, already moving throughout.
- Output: three seconds, 1280×720, nominal 30 fps, silent, original playback speed.
- Fixed crop: top-left 80% of the displayed source width and height. No mirroring,
  stabilization, time scaling, or motion interpolation.
- The original `card-wiggle.MP4` was deleted at the user's request after take 3
  was approved. Prepared clips, review sheets, source hashes and settings remain.

The reviewed frames show recurring vertical badge movement, small rotations,
changing perspective and shirt folds. The blank card face and attachment are
visible. Some room background and torso/camera movement remain. This is useful
motion evidence, not proof of a particular footfall cadence: feet are outside
the frame. The blue shirt, holder, strap, room and body proportions differ from
Riley's shot and must not become appearance references.

Use this video for motion and the existing `shot-02-v02.png` for Riley's white
shirt, burgundy lanyard, clear holder, printed card, close framing and station
light. Take 2 was rejected for feeling too slow. Source audio has been
removed; that does not prevent a video model from inventing speech. Generated
audio must be reviewed or replaced with the shared opening sound bed.

The first preparation, v01, cropped too tightly: the holder's bottom reaches
the image boundary around output 2.3 seconds. It is retained as a rejected crop.
Version 02 adds margin. The preparation script reproduces v02 at its default
speed of 1.0, or v03 with the optional speed argument `1.5`.

Review artifacts: [source overview](source-overview.jpg),
[source 3–6 seconds](source-03-06-seconds.jpg), and
[v02 frame-midpoint contact sheet](native-frames-v02.jpg). Sampling at frame
midpoints avoids duplicate selections at timestamp boundaries. Frame inspection
is not a full-speed playback or audio-listening review.

## Reproduce

These commands require restoring the original source to its recorded path;
it is intentionally absent from the repository. Expected source SHA-256:
`6797bfc228c7e48c39ab7ad9df48167444aba1ba07daf3e397865d3d3ccc1d0b`.
The prepared clips can be reused directly without that original.

From the repository root, choose a new output directory:

```sh
badge_dir=$(mktemp -d /private/tmp/afterhuman-badge.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/references/prepared-badge/prepare-reference.swift \
  assets/references/card-wiggle.MP4 "$badge_dir/badge-motion-3s-v02.mp4"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  "$badge_dir/badge-motion-3s-v02.mp4" "$badge_dir/native-frames.jpg" \
  0.0166666666667 0.0333333333333 90 6 320 180
```

Source review commands use the same contact-sheet script with arguments
`0 0.8 24 4 416 240` (overview) and `3 0.1 30 5 416 240` (selected range).

To reproduce v03 in the same new directory:

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/references/prepared-badge/prepare-reference.swift \
  assets/references/card-wiggle.MP4 "$badge_dir/badge-motion-3s-v03.mp4" 1.5
```
