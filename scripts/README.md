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
