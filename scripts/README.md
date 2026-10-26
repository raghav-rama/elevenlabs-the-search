# Local production scripts

## Prepare a compact identity reference

`sh scripts/prepare-identity-reference.sh SOURCE.png NEW_OUTPUT.jpg` reproduces
the 512px, JPEG quality 65 Riley reference used for H3 1080p tests (shot 2 take 4
and shot 4 take 7). It checks the 64 KiB inline-upload limit and refuses overwrite.
The original portrait remains unchanged. Upload and generation are separate fal
plugin operations; exact model inputs and results live beside the video takes.

These are the actual Swift scripts used to prepare the motion reference, inspect
generated frames, and mix the train audio. They live beside their assets. Run
from the repository root on macOS with Xcode Command Line Tools installed.
They use AVFoundation, AppKit, and CryptoKit; no API key, paid model call, Python
package, or FFmpeg installation is required. Media codecs may need execution
outside a restricted agent sandbox.

Use new output paths: scripts refuse to overwrite existing outputs. Exported
container bytes can vary between runs; the audio mixer explicitly verifies
that compressed picture samples and their presentation timestamps are unchanged.

## Reproduce the legs audio edit

```sh
edit_dir=$(mktemp -d /private/tmp/afterhuman-audio.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/audio/extract-audio.swift \
  assets/06-shots/videos/shot-01-take-05.mp4 "$edit_dir/legs.wav"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/audio/extract-audio.swift \
  assets/06-shots/videos/shot-03-take-01.mp4 "$edit_dir/chin.wav"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/audio/mix-train-ambience.swift \
  assets/06-shots/videos/shot-01-take-05.mp4 \
  "$edit_dir/legs.wav" "$edit_dir/chin.wav" "$edit_dir/mix.wav" \
  "$edit_dir/shot-01-audio.mp4"
```

The directory contains the two decoded sources, mixed WAV and AAC, preview MP4,
and `.audio-edit.json` verification record. Fixed v01 settings: original gain
1.0, full chin soundtrack gain 0.8, 12 ms edge fades, master reduction only as
needed for a -1.5 dBFS PCM sample-peak ceiling. This mixes the full chin soundtrack,
including breathing and incidental sounds; it does not isolate a train stem.
AAC peaks can differ slightly from the PCM ceiling. Listening review is separate
from sample-level verification. See [audio notes](../assets/06-shots/audio/README.md).

## Prepare a train-background cleanup draft

`prepare-train-ambience.py` requires Python with NumPy. It estimates persistent
spectral energy in the full shot-three soundtrack and suppresses variable energy
with a common stereo mask. This is a local DSP draft, not semantic source
separation or proof that heels and breathing have been removed. It also writes
a twelve-second bed using equal-power overlaps of the cleaned source, without
retiming. Both outputs are stereo 48 kHz, 24-bit PCM WAV; sources are unchanged.

Actual interpreter used: `/Users/ritz/miniconda3/envs/bio-lit-api-cleaned/bin/python`.
Reproduce with a Python environment containing NumPy and a new output directory:

```sh
ambience_dir=$(mktemp -d /private/tmp/afterhuman-ambience.XXXXXX)
python scripts/prepare-train-ambience.py \
  assets/06-shots/audio/shot-03-take-01-source.wav "$ambience_dir" --seconds 12
```

The processing JSON records settings, checksums, audio measurements and pending
listening status. Transient suppression may also affect train detail; do not
label the output an approved isolated ambience stem without listening review.

## Prepare the running reference

```sh
reference_dir=$(mktemp -d /private/tmp/afterhuman-reference.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/references/prepared-running/prepare-reference.swift \
  'assets/references/Slow motion running - side view (focus on legs).mp4' \
  "$reference_dir/running-rightward-3s-v02.mp4"
```

This reproduces v02's recipe: source 1.0–26.2 seconds, 8.4× speed, horizontal
mirror, 24 fps, silent, three seconds. Only the motion reference is retimed.
The downloaded original is **currently absent from its recorded path**; restore
that local file to run this command. Its SHA-256 is
`dc151696c8b1768dfe8cd01a3f61569a0e0dbe340e8e8537aa1811988b98c52c`.
The prepared v01/v02 files remain available; v01 used a 23.4-second excerpt at
7.8×. The script implements the accepted v02 recipe. Source provenance and
per-version settings are in [prepared-running](../assets/references/prepared-running/).

## Inspect motion frame by frame

### Trim an export's ending without re-encoding

`trim-video-end.swift INPUT OUTPUT.mov KEEP_FRAMES` uses AVFoundation Passthrough
to retain media from zero to the requested integer-frame endpoint. Audio follows
the same endpoint. This helper requires an integer source frame rate, refuses
existing output paths and records source/output hashes and settings. Verify the
result's decoded frame count with the inspection helper below.

The requested one-frame trim of the Final Cut opening keeps 224 of 225 frames:

```sh
trim_dir=$(mktemp -d /private/tmp/afterhuman-trim.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/trim-video-end.swift \
  assets/08-edit/fcp-opening-review-v01/fcp-opening-review-v01.mov \
  "$trim_dir/fcp-opening-trimmed-v01.mov" 224
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/inspect-review-video.swift "$trim_dir/fcp-opening-trimmed-v01.mov" \
  "$trim_dir/final-frame.png" "$trim_dir/inspection.json"
```

### Inspect the user-supplied Final Cut opening

`inspect-review-video.swift` decodes sample timestamps, records format metadata,
scans a 16-pixel RGB grid for near-black frames, and extracts full-resolution PNGs
of the final frame and the last frame above that threshold. Confirm the images
visually; a dark scene can also trigger the numerical threshold. It preserves
the source and refuses existing output paths. Compressed sample timestamps can
differ from displayed frame timestamps, so this script uses decoded frames.

```sh
review_dir=$(mktemp -d /private/tmp/afterhuman-fcp-review.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/inspect-review-video.swift \
  assets/08-edit/fcp-opening-review-v01/fcp-opening-review-v01.mov \
  "$review_dir/final-frame.png" "$review_dir/inspection.json"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  assets/08-edit/fcp-opening-review-v01/fcp-opening-review-v01.mov \
  "$review_dir/contact-sheet.jpg" 0 0.375 25 5 384 216
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/audio/extract-audio.swift \
  assets/08-edit/fcp-opening-review-v01/fcp-opening-review-v01.mov \
  "$review_dir/audio.wav"
```

Successful audio decoding and numerical levels do not establish listening
review, speech absence or perceptual continuity. The review export is archived
unchanged; generated frames are inspection aids and prospective match references.

### Verify the selected Seedance shot-four source

The imported source is `assets/06-shots/videos/shot-04-elevenlabs-seedance-v01.mp4`.
Its generation record contains the source/copy checksum, selection and review limits.
Reproduce the sampled review and audio decode with unused output paths:

```sh
review_dir=$(mktemp -d /private/tmp/afterhuman-seedance-review.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  assets/06-shots/videos/shot-04-elevenlabs-seedance-v01.mp4 \
  "$review_dir/contact-sheet.jpg" 0 0.25 20 4 480 270
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/audio/extract-audio.swift \
  assets/06-shots/videos/shot-04-elevenlabs-seedance-v01.mp4 \
  "$review_dir/native-audio.wav"
```

AVFoundation required execution outside the restricted sandbox for this source.
Frame sampling and successful audio decoding do not establish full playback or
listening approval. The user selected the original take; no source retime or
re-encode was performed.

For the newly supplied badge footage, the separate
[badge preparation script and commands](../assets/references/prepared-badge/README.md)
by default trim 3–6 seconds, crop and remove audio at original speed, with
no horizontal flip.
The optional speed argument `1.5` produces the latest v03 badge reference:
source 3–7.5 seconds compressed into three seconds, without looping. Omit the
argument to reproduce the previous original-speed v02 reference.
The user subsequently requested deletion of `card-wiggle.MP4`; reproducing the
crop from source requires restoring that file. Prepared badge references remain.

```sh
review_dir=$(mktemp -d /private/tmp/afterhuman-review.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  assets/06-shots/videos/shot-01-take-05.mp4 "$review_dir/contact-sheet.png"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  assets/06-shots/videos/shot-01-take-05.mp4 "$review_dir/native-frames.jpg" \
  0 0.0416666666667 72 6 320 180
```

Optional positional arguments after input/output are `START INTERVAL COUNT COLUMNS
WIDTH HEIGHT`, in seconds and pixels. Defaults are `0 0.125 24 4 416 240`.
Labels show actual decoded frame times. PNG or JPEG is selected by extension;
JPEG uses quality 0.8. AppKit backing scale can affect output pixel dimensions.
The generalized script replaces the temporary variants used for these reviews:

| Saved review | Input | Optional arguments |
|---|---|---|
| Running-source overview | Downloaded original | `0 1.3 24 4 416 240` |
| Running-source opening | Downloaded original | `0 0.3336667 24 4 416 240` |
| Prepared v01/v02 contact sheet | Corresponding prepared reference | defaults |
| Prepared v02 final second | Prepared v02 | `2 0.0416666666667 24 4 416 240` |
| Take 3/4/5 contact sheet | Corresponding generated take | defaults |
| Take 5 native-frame sheet | Take 5 | `0 0.0416666666667 72 6 320 180` |

These are visual sampling aids, not automated gait measurements. There is no
badge compositing script yet: that repair is a [proposed next test](../assets/06-shots/video-prompts/shot-02-bouncing-badge.md).

## Create a whole-clip speed preview

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/retime-video.swift \
  assets/06-shots/videos/shot-04-take-03.mp4 \
  assets/06-shots/videos/shot-04-take-03-speed-2x.mp4 2
```

This retimes the generated picture and native audio together at the requested
speed, using spectral pitch preservation for audio. It preserves source files,
refuses to overwrite outputs, and saves a `.retime.json` record with hashes and
verified metadata. No provider generation or optical-flow interpolation is used.
The 2x preview decodes at 48 fps, 832x480 with one audio track; its container
duration is 1.584 seconds, including audio/export padding. Listening review and
user approval remain separate from metadata verification.

## Pad a short motion reference with an ending hold

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/pad-motion-reference.swift \
  assets/06-shots/videos/shot-04-take-03-speed-2x.mp4 \
  assets/references/prepared-doors/door-motion-2s-v01.mp4 2
```

Preserves the decoded picture frames and their presentation timestamps, then
repeats the final frame to reach the requested duration. Removes audio for a
motion-only reference, preserves the source, and refuses existing output paths.
The `.preparation.json` records hashes, duration and frame counts. This prepares
the approved 2x door clip for H3's two-second reference minimum without slowing
the running action. The v01 output contains 73 source frames plus 23 held frames.

## Normalize reference frame rate without changing playback speed

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/normalize-motion-reference.swift \
  assets/06-shots/videos/shot-04-take-03-speed-2x.mp4 \
  assets/references/prepared-doors/door-motion-3s-24fps-v02.mp4 3 24
```

Samples source frames by their presentation timestamps at a constant 24 fps,
then holds the final pose to reach three seconds. It removes audio and keeps
source playback timing: converting from 48 to 24 fps does not slow the action.
The preparation record includes every output-to-source timestamp mapping,
source/output hashes, verified duration and rate. This script decodes the short
source into memory; use it for short motion references. Existing outputs are
refused. Frame-rate normalization is a precaution, not an established diagnosis
of earlier model pacing failures.

## Trim the door reference to reduce the held ending

Door reference v03 uses fal's `fal-ai/workflow-utilities/trim-video` with the
existing v02 public video URL, `start_time: 0` and `end_time: 2`. Exact submitted
input, request ID, output URL and checksum are saved in
`assets/references/prepared-doors/door-motion-2s-24fps-v03.preparation.json`.
This server operation preserves playback speed and removes the final second;
it is a reference preparation operation, not a generated-ad retime. Current
recorded rate is $0.001 per compute second; actual charge was not reported.

## Assemble the opening review cut

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/assemble-opening.swift \
  assets/08-edit/opening-v02/timeline.json \
  /private/tmp/afterhuman-opening-review.mp4
```

Run from the repository root with unused output paths. JSON specifies the
approved sources, source in-points, frame counts, canvas and audio mix settings.
The script preserves playback speed, uses hard picture cuts, aspect-fit
rendering, conservative RMS-based audio gains and short audio crossfades.
Optional `audio_bridges` reuse existing audio under a quiet section. No new
synthesis, optical flow, source deletion or source modification is performed.
Outputs are the MP4, `.mix.wav` and `.edit.json` with hashes and level checks.
Picture is re-encoded; audio and subjective pacing still need listening review.

Review the full five seconds with the existing contact-sheet script using
`0 0.2083333333 24 4 416 240` after the input/output arguments.
