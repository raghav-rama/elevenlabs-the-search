# Local production scripts

## Preview the jingle with the approved voiceover

```sh
python scripts/mix-voiceover-jingle.py \
  assets/07-jingle/reviews/afterhuman-instrumental-metal-v01-preview-config.json \
  /private/tmp/afterhuman-metal-with-david.wav
```

Decodes the configured voiceover and music with macOS `afconvert`, mixes at
48 kHz stereo with the recorded start time/gain envelope, and applies a shared
sample-peak ceiling. Optional `fixed_master_gain_db` preserves an earlier master
gain for music-only volume revisions and refuses a render if that gain would
exceed the configured ceiling. Optional `music_reference_rms_dbfs` matches the
decoded music source RMS before applying its envelope, for approximate comparison
between candidates; it is not perceptual LUFS matching. Any further music-only
peak adjustment is recorded in the preview configuration. Outputs a listening WAV and `.mix.json`
provenance/level report. Refuses existing outputs, verifies input hashes and
preserves originals.
The preview does not replace source audio or establish final picture alignment,
perceived loudness, true-peak compliance or listening approval.

For the three new surprise takes, substitute the matching configuration under
`assets/07-jingle/reviews/` (`afterhuman-instrumental-overclock-v01-preview-config.json`,
`afterhuman-instrumental-chrome-swagger-v01-preview-config.json`, or
`afterhuman-instrumental-redline-v01-preview-config.json`). The configurations
retain the same David gain and music entry; any additional music-only peak
adjustment is already included in the saved envelope gains. Listen via the
[jingle comparison index](../assets/07-jingle/README.md).

## Inspect voiceover auditions

```sh
python scripts/inspect-voiceover-auditions.py \
  assets/09-voiceover/auditions/american-bass-v01 \
  /private/tmp/afterhuman-voice-audio-checks.json
```

Hashes the original MP3 auditions and decodes them with macOS `afconvert` into
temporary 16-bit PCM at the source sample rate. Reports frame count, format,
sample peak, RMS and full-scale sample count. It removes temporary audio and
refuses an existing report path. No source edits or listening approval implied.
See the [audition notes](../assets/09-voiceover/auditions/american-bass-v01/README.md).

## Review the continuous Seedance departure and transformation

The [approved 480p take](../assets/06-shots/reviews/shot-04-05-continuous-seedance-480p-v01/README.md)
was generated once from both corrected MiniMax clips. The review tools preserve the native source.
Choose a fresh output directory:

```sh
continuous_review_dir=$(mktemp -d /private/tmp/afterhuman-continuous.XXXXXX)
continuous_input=assets/06-shots/videos/shot-04-05-continuous-seedance-480p-v01.mp4
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/inspect-review-video.swift "$continuous_input" \
  "$continuous_review_dir/last-frame.png" "$continuous_review_dir/inspection.json"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift "$continuous_input" \
  "$continuous_review_dir/contact-sheet.jpg" 0 0.5 25 5 427 240
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift "$continuous_input" \
  "$continuous_review_dir/join-detail.jpg" 4.5 0.125 17 4 427 240
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift "$continuous_input" \
  "$continuous_review_dir/join-frames.jpg" 4.9166666667 0.0416666667 13 3 640 360
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift "$continuous_input" \
  "$continuous_review_dir/upgrade-detail.jpg" 6.0 0.125 13 4 427 240
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/inspect-frame-continuity.swift "$continuous_input" \
  "$continuous_review_dir/frame-continuity.json"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/audio/extract-audio.swift "$continuous_input" \
  "$continuous_review_dir/native-audio.wav"
```

`inspect-frame-continuity.swift` measures normalized adjacent RGB differences
on an eight-pixel grid for the full image, upper background and subject region.
It refuses existing output paths and stores the input hash and every measured pair.
The measurements are not motion-compensated: natural motion can score highly,
and low scores do not establish smooth playback or correct anatomy.
No audio transcription or full listening review is implied.


## Review and assemble the train-departure correction

The v02 correction uses the existing review and assembly scripts. Original
Seedance/MiniMax sources remain intact; the corrected takes are new files.
Use fresh output directories when reproducing checks:

```sh
departure_review_dir=$(mktemp -d /private/tmp/afterhuman-departure.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/inspect-review-video.swift \
  assets/06-shots/videos/shot-04-train-departure-minimax-v02.mp4 \
  "$departure_review_dir/last-frame.png" "$departure_review_dir/inspection.json"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  assets/06-shots/videos/shot-04-train-departure-minimax-v02.mp4 \
  "$departure_review_dir/contact-sheet.jpg" 0 0.25 21 4 480 274
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  assets/06-shots/videos/shot-04-train-departure-minimax-v02.mp4 \
  "$departure_review_dir/closure-detail.jpg" 0.9166666667 0.0833333333 11 3 672 384
```

For shot 05 use 0 / 0.375 / 18 / 3 / 560 / 320 for contact-sheet arguments;
for shots 06 and 07 use 0 / 0.375 / 14 / 4 / 480 / 274. Actual sample times
are labeled in each sheet. Generated action timing may differ from the prompt.
The [correction brief](../assets/06-shots/video-prompts/shot-04-07-train-departure-correction-v02.md)
records continuity requirements and the actual endpoint adaptation.

To reproduce the v02 assembly, choose a new output path:

```sh
departure_edit_dir=$(mktemp -d /private/tmp/afterhuman-departure-edit.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/assemble-continuation.swift \
  assets/08-edit/transformation-sequence-v02/timeline.json \
  "$departure_edit_dir/afterhuman-transformation-preview-v02.mp4"
```

The original VO is read from the verified decoded WAV in the v01 folder; no
duplicate source or generated speech is needed. Native take files are untouched.

## Assemble the visible-transformation continuation

`assemble-continuation.swift` derives from the existing opening assembler and
adds optional per-clip audio gains, native-audio ducking under narration, and
explicit fit/fill framing. Sources are read-only; output paths must be new.
The timeline stores the exact cuts, source paths, VO placement and audio settings.

```sh
continuation_review_dir=$(mktemp -d /private/tmp/afterhuman-continuation.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/assemble-continuation.swift \
  assets/08-edit/transformation-sequence-v01/timeline.json \
  "$continuation_review_dir/afterhuman-transformation-preview-v01.mp4"
```

The saved prototype is [indexed here](../assets/08-edit/transformation-sequence-v01/README.md).
It keeps the first 146 frames of the Final Cut export, then full Seedance shot
four and the three new MiniMax shots. Original source speed is preserved.
Narration begins at 7.875s; its UPGRADE onset is 12.375s / 00:00:12:09 at 24fps.
Native 1344x768 clips are scaled to fill 1920x1080 with a small vertical crop;
this affects only the preview, not downloaded originals.

To reproduce native take reviews, use `inspect-review-video.swift` as above and
`assets/06-shots/reviews/extract-contact-sheet.swift` with these arguments:

| Input basename | Start | Interval | Count | Columns | Tile width | Tile height |
|---|---:|---:|---:|---:|---:|---:|
| shot-05-transformation-minimax-v01 | 0 | 0.375 | 18 | 3 | 560 | 320 |
| shot-06-eye-push-minimax-v01 | 0 | 0.375 | 14 | 4 | 480 | 274 |
| shot-07-speed-launch-minimax-v01 | 0 | 0.375 | 14 | 4 | 480 | 274 |

Inputs are in `assets/06-shots/videos/`; review evidence is in matching
subdirectories of `assets/06-shots/reviews/`. Sampling and automated speech
checks do not substitute for final playback/listening review.

## Review the station-upgrade MiniMax prototype

The original downloaded MP4 is preserved. Reproduce its frame inspection,
11-frame contact sheet and decoded native-audio copy in a new directory:

```sh
shot05_review_dir=$(mktemp -d /private/tmp/afterhuman-shot05-review.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/inspect-review-video.swift \
  assets/06-shots/videos/shot-05-station-upgrade-minimax-test-v01.mp4 \
  "$shot05_review_dir/last-frame.png" "$shot05_review_dir/inspection.json"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/reviews/extract-contact-sheet.swift \
  assets/06-shots/videos/shot-05-station-upgrade-minimax-test-v01.mp4 \
  "$shot05_review_dir/contact-sheet.jpg" 0 0.5 11 4 448 256
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  assets/06-shots/audio/extract-audio.swift \
  assets/06-shots/videos/shot-05-station-upgrade-minimax-test-v01.mp4 \
  "$shot05_review_dir/native-audio.wav"
```

Saved evidence is in [the shot-five review directory](../assets/06-shots/reviews/shot-05-station-upgrade-minimax-test-v01/).
Sampled frames and automated speech checks do not establish complete playback
or listening approval. The source is 1344x768, 24 fps, 124 picture frames despite
the five-second request. Keep the actual aspect ratio in mind when conforming
to the 1920x1080 edit; no crop, retime or transcode has been applied here.

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

## Review the POV chase prototype batch

`review-pov-chase-prototypes.py` invokes existing macOS Swift helpers for decoded frame inspection, 14 sampled frames and native-audio WAV/level extraction. It preserves inputs and skips existing review outputs. Run from the repository root:

```sh
python scripts/review-pov-chase-prototypes.py assets/06-shots/videos/pov-chase-minimax-batch-v01.json
```

Its successful output does not establish full playback, listening or user approval. Saved findings and individual links are in the [batch review](../assets/06-shots/reviews/pov-chase-minimax-v01/README.md).

The shared-city still board uses the existing gallery builder with per-image visual findings and batch-specific status copy:

```sh
python3 scripts/build-startframe-gallery.py assets/06-shots/images/city-continuity-stills-batch-v02.json NEW_CITY_REVIEW_DIRECTORY
```

See [shared-city still review](../assets/06-shots/reviews/city-continuity-stills-v02/README.md) for the current generation count, costs and pending corrections. This command only builds HTML from existing native images; it makes no provider calls.

For the subsequent [corrected six-image review](../assets/06-shots/reviews/city-continuity-stills-v03/README.md), use its curated review batch; the generation batch separately records the four newly charged images:

```sh
python3 scripts/build-startframe-gallery.py assets/06-shots/reviews/city-continuity-stills-v03/review-batch.json NEW_CORRECTED_CITY_REVIEW_DIRECTORY
```

## Add the intelligence HUD concept locally

`add-pov-hud-preview.swift INPUT.mp4 NEW_OUTPUT.mp4` uses AVFoundation/CoreAnimation and rasterized text. It adds screen-space panels and a timed arrow, preserves the native source, retains audio, and writes hashes/provenance in an adjacent `.edit.json`. This helper targets the current five-second, 24 fps landscape plate; it is not a general tracker. No provider/API call. Outputs must be unused paths.

```sh
hud_dir=$(mktemp -d /private/tmp/afterhuman-hud.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/add-pov-hud-preview.swift assets/06-shots/videos/shot-08-pov-intelligence-minimax-v01.mp4 "$hud_dir/hud-preview.mp4"
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/inspect-review-video.swift "$hud_dir/hud-preview.mp4" "$hud_dir/last-frame.png" "$hud_dir/inspection.json"
```

Current deliverable is `shot-08-pov-intelligence-hud-preview-v02.mp4` under the batch review folder. v01 had missing text and an extra export frame; v02 fixes both locally. Picture is re-encoded, native audio retained, no music/voice added. Exported byte hashes may vary between runs. Use a fresh directory for inspection because the inspector also writes a fixed `last-picture-frame.png` name.

## Build the starting-frame comparison gallery

`build-startframe-gallery.py` reads a batch and its adjacent generation/review records and writes a responsive local HTML page linking the native images. No image processing, provider calls or source changes. Run from repository root; use a fresh output folder because an existing index is refused:

```sh
python scripts/build-startframe-gallery.py assets/06-shots/images/powers-startframes-batch-v01.json /private/tmp/afterhuman-startframes-review
```

The saved [comparison gallery](../assets/06-shots/reviews/powers-startframes-v01/index.html) and [review notes](../assets/06-shots/reviews/powers-startframes-v01/README.md) contain the current five image concepts. Opening the HTML locally requires no server or network access.

The starting-frame gallery honors an optional latest_review_record on a batch shot, so it can show a revised still while retaining original batch output and cost provenance.

## Review individual videos from the redesigned stills

The same gallery builder supports native MP4/MOV/WebM players with source-image posters and optional batch `gallery_title`, `gallery_description`, `gallery_status` and `gallery_footer` fields. Native audio is retained; playback is manual. Existing still galleries and media files are unchanged.

```sh
python scripts/review-pov-chase-prototypes.py assets/06-shots/videos/powers-startframe-motion-batch-v01.json
python scripts/build-startframe-gallery.py assets/06-shots/videos/powers-startframe-motion-batch-v01.json /private/tmp/afterhuman-motion-review-new
```

Use a fresh gallery destination. [Five-video gallery](../assets/06-shots/reviews/powers-startframe-motion-v01/index.html) and [review notes](../assets/06-shots/reviews/powers-startframe-motion-v01/README.md) document the generated results and remaining motion issues. Audio decoding/level checks do not establish a listening review.

For longer clips, the review helper accepts optional batch fields `review_sample_count` and `review_interval_seconds`. The coffee-reflex ten-second test uses 24 samples spaced 0.4166666667 seconds apart so the handback and exit are included, instead of sampling only the first five seconds:

```sh
python scripts/review-pov-chase-prototypes.py assets/06-shots/videos/reflexes-coffee-test-batch-v01.json
```

Existing review derivatives are still preserved. If resampling an already inspected file, use a new review asset/destination or invoke the contact-sheet helper with a fresh output filename; do not overwrite prior review evidence.

## Assemble the 45-second narrated ad review

[Continuous review v01](../assets/08-edit/continuous-ad-review-v01/README.md) uses the selected coffee rescue, locked continuous Seedance shot, David and Chrome Swagger. Exact picture ranges, speech placements, music arrangement, native-audio gains and hashes are saved beside the output.

- `mix-ad-review.py CONFIG.json NEW_OUTPUT.wav` decodes existing voice/music with macOS `afconvert`, places contiguous voice phrases at original speed, arranges two placements of the existing jingle, ducks music around speech and filters the coffee slow-motion beat. It saves a stereo WAV plus a provenance/levels report with a sample-peak ceiling; no provider call, source overwrite or voice time stretching.
- `render-brand-outro.swift ENDING_FRAME.png NEW_OUTRO.mp4` creates 60 frames at 24 fps / 1920×1080: a rotating spiral from the ending frame and exact AFTERHUMAN / A STEP AHEAD typography. No audio or paid generation. Input/output hashes are recorded. The mark is a local editorial proposal awaiting review.
- Existing `assemble-continuation.swift` combines the saved picture clips and arranged soundtrack, ducks/crossfades native sound, retains source speed and exports the 45-second review with a full-mix WAV and `.edit.json`.

```sh
python scripts/mix-ad-review.py assets/08-edit/continuous-ad-review-v01/soundtrack-config.json /private/tmp/afterhuman-review-soundtrack-new.wav
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/render-brand-outro.swift assets/06-shots/reviews/shot-12-overtake-coastal-minimax-startframe-v01/last-picture-frame.png /private/tmp/afterhuman-review-outro-new.mp4
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/08-edit/continuous-ad-review-v01/timeline.json /private/tmp/afterhuman-continuous-review-new.mp4
```

Run from repository root with unused output paths. The assembly command reads the saved derivative paths in its timeline; to use newly rebuilt components elsewhere, copy the timeline and update those paths. The 1080p canvas includes scaled 480p footage. Decode, source-hash and sample-peak checks do not establish independent listening or final competition readiness.


## Product clarity edit and preserved audio

[Product clarity review v02](../assets/08-edit/continuous-ad-review-v02/README.md) introduces the product descriptor at the transformation and on the end card. `render-brand-outro.swift` accepts an optional product descriptor; omitting it retains the original layout.

`add-product-clarity.swift CONFIG.json` composites the transformation label and substitutes the new end card at frame 1020, preserving all other cut timings. It renders picture only, remuxes the source AAC with passthrough and verifies identical compressed audio payload. Zero-sample boundary markers are skipped; missing data for nonzero sample counts is an error. It refuses existing outputs. `--verify-existing` checks a completed export and writes absent provenance without rerendering.

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/render-brand-outro.swift assets/06-shots/reviews/shot-12-overtake-coastal-minimax-startframe-v01/last-picture-frame.png NEW_OUTRO.mp4 'CYBERNETIC IMPLANTS'
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/add-product-clarity.swift NEW_CONFIG.json
```

Copy `assets/08-edit/continuous-ad-review-v02/product-clarity-config.json`, set fresh `outro` and `output` paths, then run. Input SHA-256, frame boundaries and exact label text are recorded. Media verification uses the existing `inspect-review-video.swift` and `extract-contact-sheet.swift` commands. The [city design board](../assets/06-shots/reviews/city-continuity-v01/index.html) uses existing linked reference images and a local SVG/JavaScript staging diagram; it makes no provider calls.

## Floating-body diagnostic mock-up

[Review and limitations](../assets/08-edit/continuous-ad-review-v03/README.md). These local macOS helpers use AVFoundation, Vision, Core Image/Core Graphics and `afconvert`; no external generation. The scripts target this existing 1920×1080 / 24 fps cut and its 127-frame upgrade window, not arbitrary footage.

- `prepare-upgrade-mattes.swift SOURCE.mp4 START_FRAME COUNT NEW_DIRECTORY [person|foreground]` saves source-frame masks, 2D poses and source hash. Default `foreground` includes Riley's dark boots; the earlier `person` test did not. The renderer limits masks to her known screen region.
- `render-upgrade-diagnostic.swift CONFIG.json` verifies source/matte provenance, floats Riley to the center and back, composites the temporary background patch, scan/callouts and exact terminal text. Output MP4, `.edit.json` and sampled PNGs use fresh paths. The anatomical lines and manual ankle anchors are mock-up guides.
- `mix-upgrade-diagnostic-sfx.py CONFIG.json NEW_MIX.wav` adds deterministic low-level typing, module locks, confirmation and air accents to the existing 45-second mix only within the insert. Writes mix, effects-only stem and provenance; source audio is decoded and re-encoded, not AAC passthrough.

Run from the repo root. Create an unused temporary folder, copy the final config and assign its new matte/output paths:

```sh
diagnostic_work=$(mktemp -d /private/tmp/afterhuman-diagnostic.XXXXXX)
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/prepare-upgrade-mattes.swift assets/08-edit/continuous-ad-review-v01/afterhuman-continuous-with-david-v01.mp4 308 127 "$diagnostic_work/mattes" foreground
python3 - "$diagnostic_work" <<'PY'
import json, sys
from pathlib import Path
work = Path(sys.argv[1])
config = json.loads(Path('assets/08-edit/upgrade-diagnostic-v01/diagnostic-config-v02.json').read_text())
config['mattes'] = str(work / 'mattes/mattes.json')
config['output'] = str(work / 'diagnostic-picture.mp4')
(work / 'config.json').write_text(json.dumps(config, indent=2) + '\n')
PY
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/render-upgrade-diagnostic.swift "$diagnostic_work/config.json"
python3 scripts/mix-upgrade-diagnostic-sfx.py "$diagnostic_work/config.json" "$diagnostic_work/diagnostic-mix.wav"
```

To reassemble the saved final review directly from the retained components:

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/08-edit/continuous-ad-review-v03/timeline.json /private/tmp/afterhuman-diagnostic-review-new.mp4
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/08-edit/continuous-ad-review-v03/focused-timeline.json /private/tmp/afterhuman-diagnostic-focus-new.mp4
```

For newly rebuilt components, copy the timelines and substitute the new picture/mix paths first. The focused timeline reads full-cut 8.000–19.375s. Verify with `inspect-review-video.swift`, sampled frames and listening; technical decode/level checks alone do not establish final sound or production readiness.

## Review the city Seedance overhead take

[Take 1 and limitations](../assets/06-shots/reviews/shot-12-overtake-city-seedance-480p-v01/README.md). Uses the existing inspection/gallery helpers without modifying the native video:

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/city-overhead-seedance-batch-v01.json
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/city-overhead-seedance-batch-v01.json /private/tmp/afterhuman-overhead-player-new
```

This batch samples 21 frames across five seconds and extracts native audio. Use a fresh gallery destination; optional finer stride-sampling command is in the linked take README. Native audio decoding does not establish listening approval.

The overhead take now also has a [usable 00:01–00:04 review extraction](../assets/06-shots/reviews/shot-12-overtake-city-seedance-480p-v01/usable-range-v01/README.md). Its saved timeline uses source-in frame 24 and 72 frames at original 24 fps/native 854×480; reproduce with the existing assembler and unused output paths as documented there. This is a local re-encode, not a new generation or source retime.

## Review the city intelligence Seedance take

[Take 1, candidate edit and limitations](../assets/06-shots/reviews/shot-08-intelligence-city-seedance-480p-v01/README.md). Reuse the existing review/gallery helpers with assets/06-shots/videos/city-intelligence-seedance-batch-v01.json. Its 21 samples span five seconds.

The saved assets/06-shots/reviews/shot-08-intelligence-city-seedance-480p-v01/edit-preview-v01/timeline.json uses source frame 30 and 66 frames at original 24 fps/native 854×480. Reproduce with assemble-continuation.swift and a fresh output filename; exact commands and finer route-lock sampling are in the take README. This is a local review re-encode with normal 8 ms audio edge fades, not a source retime or selected final edit.

## Compare richer intelligence HUD stills

[Gallery](../assets/06-shots/reviews/intelligence-hud-concepts-v01/index.html) and [notes](../assets/06-shots/reviews/intelligence-hud-concepts-v01/README.md). Reuse build-startframe-gallery.py with assets/06-shots/images/intelligence-hud-concepts-batch-v01.json and a fresh destination. Original and generated PNGs are linked without image processing; prompts/costs remain in adjacent records.

## Review selected C HUD replacement

[Take 2 and candidate excerpt](../assets/06-shots/reviews/shot-08-intelligence-city-seedance-480p-v02/README.md) use the existing review/gallery helpers with assets/06-shots/videos/city-intelligence-seedance-batch-v02.json. The review samples 21 source frames and extracts native audio. The saved edit-preview-v01/timeline.json takes source frames 6–71 (00:00.25–00:03.00) at original speed for the 2.75-second slot. Reproduction commands and fresh-output instructions are in the linked README; no new script or accepted-cut change.

## Review the city Seedance coffee rescue

[Take and proposed 10.125-second excerpt](../assets/06-shots/reviews/shot-09-coffee-city-seedance-480p-v01/README.md) use existing helpers with assets/06-shots/videos/city-coffee-seedance-batch-v01.json. The review samples 23 frames, plus detailed drop/catch and exit sheets, and extracts native audio. Its saved edit-preview-v01/timeline.json takes the first 243 frames at original speed, excluding the late scene-side reversal. Exact catch contact remains obscured by a generated face insert. Commands and fresh-output instructions are in the take README; no new script or accepted-cut edit.

## Extract a native source frame for continuity

`extract-video-frame.swift INPUT SECONDS OUTPUT.png` writes one native-resolution PNG and an adjacent `.frame.json` containing requested/actual time, dimensions and source/output hashes. It refuses existing outputs and does not crop, label or modify the source. Example: `swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/extract-video-frame.swift assets/06-shots/videos/shot-09-coffee-city-seedance-480p-v01.mp4 4 /private/tmp/afterhuman-coffee-join-new.png`. The coffee-opening correction uses this frame to reference the existing third-person crouch without paying to ingest the full source video.

## Add a brief editorial whip-pan cue

`add-whip-pan-cue.swift CONFIG.json` uses AVFoundation/Core Image to translate the picture screen-right and add directional blur over a configured frame range, suggesting a leftward glance. It preserves duration and source speed, retains audio through export, refuses existing outputs and writes adjacent `.cue.json` provenance/hashes. Clamped edge pixels avoid black borders. This is a 2D editorial cue, not a generated camera rotation.

Config keys: `input`, `output`, `fps`, `start_frame`, `end_frame_exclusive`, `max_shift_fraction`, `max_blur_pixels`. Run with `swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/add-whip-pan-cue.swift NEW_CONFIG.json`. See the [coffee correction review](../assets/06-shots/reviews/shot-09-coffee-opening-correction-seedance-480p-v02/README.md) for full fresh-output assembly and verification commands. That review keeps the original handoff/sprint, replaces the hidden catch and records the remaining glance limitations.

## Review the MiniMax coffee orbit prototype

[Orbit test and limitations](../assets/06-shots/reviews/shot-09-reflexes-coffee-orbit-minimax-v02/README.md) use existing review/gallery helpers with `assets/06-shots/videos/reflexes-coffee-orbit-batch-v02.json`. The batch samples 25 frames across ten seconds; separate drop/transition and catch-contact sheets test the airborne reveal, catch and camera travel. Exact fresh-output commands are in the review README. No new editing script or accepted-cut modification.

## Review the corrected coffee approach still

[Starting-reference correction v04](../assets/06-shots/reviews/coffee-blocking-correction-v04/README.md) reuses `build-startframe-gallery.py` with `assets/06-shots/images/coffee-blocking-correction-batch-v04.json` and a fresh destination. It records corrected starting distance separately from the remaining mug-hand and motion constraints. No video or local image-editing script in this pass.

The [single-hand running reference v06](../assets/06-shots/reviews/coffee-running-hand-v06/README.md) uses the same gallery helper with `assets/06-shots/images/coffee-running-hand-batch-v06.json`. It is a targeted image edit; no new script or video.

## Review the fixed-start MiniMax coffee test

[Coffee v03 review](../assets/06-shots/reviews/shot-09-reflexes-coffee-orbit-minimax-v03/README.md) uses existing helpers with `assets/06-shots/videos/reflexes-coffee-orbit-batch-v03.json`. Native output, 25-frame overview and focused release/contact sheets distinguish improved approach from missing orbit/airborne-discovery and wardrobe drift. Commands and source-preserving inspection limits are in the review README.

## Review the two-part coffee prototype

[Coffee split v04](../assets/06-shots/reviews/coffee-split-minimax-v04/README.md) reuses the existing inspection, contact-sheet, gallery and original-speed assembly helpers. Its saved timeline joins 49 FPP frames to 191 TPP frames for exactly ten seconds at native 832×480/24 fps. Individual sources, image/video generation records, review limits and fresh-output reproduction commands are linked in that README. No new helper script or accepted-cut modification.

## Review the Seedance coffee orbit comparison

[Seedance coffee comparison v01](../assets/06-shots/reviews/coffee-split-seedance-v01/README.md) reuses the inspection, gallery, contact-sheet and original-speed assembly helpers. The timeline preserves the liked MiniMax FPP frames and substitutes the first191 Seedance frames for a ten-second review. One paid video only; native outputs and prior edit stay unchanged. Fresh-output reproduction commands and choreography limits are in the review README.

## Resize a video reference for provider input limits

`resize-video-reference.swift INPUT OUTPUT.mp4 WIDTH HEIGHT` uniformly enlarges integer-frame-rate video to even dimensions with the same aspect ratio, preserving duration and audio tracks without crop, padding, retiming or interpolation. It refuses existing outputs and writes source/output hashes and preparation metadata. The [coffee Seedance Edit reference](../assets/06-shots/references/coffee-minimax-seedance-edit-v01/README.md) uses884×510 to clear the reported407696-pixel minimum;192 frames/8s/24fps verified. This prepares input only, with no provider generation.

## Review an actual-video Seedance edit

[Coffee Video Edit comparison](../assets/06-shots/reviews/coffee-minimax-ref-seedance-edit-v02/README.md) reuses the inspection, contact-sheet and gallery helpers. It compares unchanged native files, records the provider output of185 frames versus192 input frames, and avoids local retiming. Exact local reproduction commands and audio/likeness limitations are in the review README.

## Review the city strength Seedance take

[Strength review](../assets/06-shots/reviews/shot-10-strength-city-seedance-480p-v01/README.md) reuses `review-pov-chase-prototypes.py` and `build-startframe-gallery.py` with `city-strength-seedance-batch-v01.json`. It retains the full native take, compares the approved intact-door still and records material-deformation and timing limitations before any edit. Reproduction commands are in the review README.

## Review the boulevard speed Seedance take

[Speed review](../assets/06-shots/reviews/shot-11-speed-city-seedance-480p-v01/README.md) reuses `review-pov-chase-prototypes.py` and `build-startframe-gallery.py` with `city-speed-seedance-batch-v01.json`. It retains the native five-second take and records actual foreground translation, hand alternation and playback limitations before choosing the final 2.5-second excerpt. Reproduction commands are in the review README.

## Review station launch after the diagnostic return

[Station launch review](../assets/06-shots/reviews/shot-07-station-launch-seedance-480p-v01/README.md) reuses inspection, contact-sheet, gallery and `assemble-continuation.swift`. Its saved context timeline joins the last24 diagnostic frames to the full121-frame new take, preserving original speed. The first second is silent context; native launch sound follows. Prompt timing misses and reproducible commands are documented in the review README.

## Review the continuous diagnostic and launch take

[Combined Seedance diagnostic/launch v01](../assets/06-shots/reviews/shot-06-07-diagnostic-launch-seedance-480p-v01/README.md) uses the existing inspection, contact-sheet, native-frame extraction and gallery helpers with `assets/06-shots/videos/diagnostic-launch-seedance-batch-v01.json`. Review includes32 overview samples,24 focused return samples, full-size terminal text and full native decode/audio levels. The README contains reproducible fresh-output commands. Both actual reference videos and three image references are tracked separately; no local assembly or retiming was used to create the returned shot.

## Assemble the latest approved visuals review v04

[Latest full-cut review](../assets/08-edit/continuous-ad-review-v04/README.md) reuses `mix-ad-review.py`, `render-brand-outro.swift`, `assemble-continuation.swift`, `inspect-review-video.swift` and the contact-sheet helper. Exact source ranges and narration/music spacing are in the v04 timeline, timing plan and soundtrack config.1107frames/46.125seconds, original source speeds, approved HUD/overhead ranges, full diagnostic/launch and preferred coffee. The README documents fresh-output reproduction. No new provider request or editing helper was introduced.

## Restore transformation and review the station upscale (v05)

Latest player: [continuity review v05](../assets/08-edit/continuous-ad-review-v05/index.html). Preserve original source motion and audio; timeline-upscaled.json swaps picture only to the289-frame Topaz2x derivative.

```sh
python3 scripts/mix-ad-review.py assets/08-edit/continuous-ad-review-v05/soundtrack-config.json /private/tmp/afterhuman-v05-reproduced.wav
# Copy timeline-upscaled.json to a fresh working file and point audio_bridges[0].source to that WAV.
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift /private/tmp/afterhuman-v05-timeline.json /private/tmp/afterhuman-v05-reproduced.mp4
```

Use a fresh directory for inspect-review-video.swift because its last-picture-frame.png is fixed within the output directory. Restoring the entire source adds127frames. The old overhead remains temporary until the new still is reviewed. Matched-world still gallery can be reproduced with build-startframe-gallery.py using assets/06-shots/images/boulevard-overhead-correction-batch-v01.json and a fresh directory.

## Merge the original transformation and float, without skeleton (v06)

The optional `person_style: "natural"` in `render-upgrade-diagnostic.swift` keeps the original person opaque and naturally colored, disabling the skeleton, hologram, blue outline and scan sweep. Existing configs retain diagnostic mode. Optional `picture_source`, `picture_source_sha256` and `picture_start_frame` allow the same validated source mattes to be paired with an enhanced copy of exactly those frames. The source is conformed to the1080p canvas with the same fill transform used by the assembler. It verifies both source hashes and exact frame timestamps.

```sh
# Use fresh output paths in copied configs; these recorded outputs already exist.
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/render-upgrade-diagnostic.swift assets/08-edit/floating-transformation-v02/config.json
python3 scripts/mix-ad-review.py assets/08-edit/continuous-ad-review-v06/soundtrack-config.json /private/tmp/afterhuman-v06-mix.wav
# Copy timeline.json, point picture and audio_bridges[0].source to the reproduced outputs.
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift /private/tmp/afterhuman-v06-timeline.json /private/tmp/afterhuman-v06-reproduced.mp4
```

Review duration is1077frames /24fps =44.875seconds. Transformation frames162–288 are preserved at original speed, displayed while floating in the existing127frame window. The approved combined take contributes only launch frames134–169; all skeletal footage is excluded. Preserve original native transformation sound using an aligned bridge from6.75s, and reuse the existing UI-effects stem quietly. No paid media generation.

## Refine the floating Riley mask and preserve the existing cut (v07)

[Arm-cleanup review](../assets/08-edit/continuous-ad-review-v07/index.html) corrects the missing forearm/hand in the approved merged transformation. It retains the original source motion, 44.875-second runtime and exact compressed audio.

- `refine-upgrade-mattes.swift CONFIG.json` uses local Apple Vision on a tightly framed crop of the verified higher-resolution source. It retains the old frame IDs/pose records, records the actual segmentation source separately, and saves new masks plus sampled before/after crops. Configurable morphology regions and bounded exclusion rectangles remove narrow background-light spill. Coordinates are relative to the crop with a bottom-left origin. The final configuration uses `foreground`; person/hybrid experiments are preserved but unselected.
- `render-upgrade-diagnostic.swift CONFIG.json` renders the same 127-frame natural-color float with the new masks, unchanged text and movement. No skeleton.
- `replace-picture-segment.swift CONFIG.json` inserts an equal-duration corrected picture segment using AVFoundation compressed passthrough. It preserves the source AAC and verifies its payload hash. Requires matching dimensions, fps and exact durations; refuses existing files.
- `verify-picture-replacement.swift SPLICE_CONFIG.json` decodes both full cuts and the inserted component. It compares every visible BGRA pixel outside/inside the replaced interval with the corresponding original/component and checks every 24 fps timestamp. It writes a verification record and three before/after crops.

Use copies of these configs with **fresh output paths**; never overwrite accepted files. Update the splice config's replacement SHA after reproducing the component, because encoder bytes can vary.

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/refine-upgrade-mattes.swift NEW_MATTE_CONFIG.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/render-upgrade-diagnostic.swift NEW_COMPONENT_CONFIG.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/replace-picture-segment.swift NEW_SPLICE_CONFIG.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache \
  scripts/verify-picture-replacement.swift NEW_SPLICE_CONFIG.json
```

Saved configs: `assets/08-edit/floating-transformation-v03/matte-config.json`, `assets/08-edit/floating-transformation-v03/config.json`, and `assets/08-edit/continuous-ad-review-v07/splice-config.json`. Final verification: all 950 unaffected frames pixel-identical, all 127 replacement frames match the component, all 1,077 timestamps exact, original AAC payload identical. The passthrough container's approximate nominal-rate field reads 23.911358; actual presentation timestamps remain exactly 24 fps throughout. No source retiming or new provider generation.

## Matched-boulevard overhead take 1 review

[Native and sprint-context player](../assets/06-shots/reviews/shot-12-overtake-boulevard-seedance-480p-v01/index.html) uses the exact user-supplied start image. One Seedance 2.5 five-second480p generation; geography matches, decisive overtake is not achieved, so it remains unselected.

Reproduce native checks with `python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/boulevard-overhead-seedance-batch-v01.json`. The context uses the existing `assemble-continuation.swift` with `assets/06-shots/reviews/shot-12-overtake-boulevard-seedance-480p-v01/context-review-v01/timeline.json` and a fresh output filename. It joins the approved2.5-second sprint to the new source[1,4) range with the existing ad mix excerpt, at original speed. The132-frame/5.5s context is a world-match test, not a selected replacement. The approved44.875s cut remains unchanged.

## Inspect the continuous POV-to-overhead race test

The one-take test and review live under `assets/06-shots/reviews/shot-11-12-fpp-overhead-seedance-480p-v01/`. It starts from native source frame0.75s of the approved speed take and uses `shot-12-boulevard-overtake-end-v01.png` as the finish. Source files and accepted full ad are unchanged.

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/fpp-overhead-seedance-batch-v01.json
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/fpp-overhead-seedance-batch-v01.json /private/tmp/afterhuman-fpp-overhead-review
```

Use a fresh gallery directory. Existing inspector outputs are preserved. Fine contact-sheet reproduction uses `assets/06-shots/reviews/extract-contact-sheet.swift`: camera-rise arguments `1.25 0.0833333333333333 13 4 427 240`; final-pass arguments `4 0.0833333333333333 13 4 427 240`. The native-frame helper extracts2s and4s. No retiming or accepted-cut replacement. Audio is decoded/measured, not independently listened to.

## Add the official contest watermark

```sh
python3 scripts/add-contest-watermark.py assets/10-submission/afterhuman-watermarked-v01/watermark-config.json --ffmpeg /path/to/ffmpeg
```

Uses FFmpeg 7.1 with libx264, the unmodified official PNG and selected v07. Verifies input hashes, refuses existing outputs, adds a 480px-wide bottom-right mark throughout, and stream-copies audio. Reproduction requires a copied config with a fresh output path. Original command is in render JSON. Verify with `scripts/inspect-review-video.swift` and compare stream-copy ADTS hashes; see submission records.

The stopped train-motion diagnostic is retained at `assets/06-shots/reviews/shot-11-12-train-forward-local-v03/inspect-train-world-motion.py`; its local README contains the command. It produced diagnostic images only, not a corrected video.
