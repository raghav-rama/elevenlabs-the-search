# Opening review cuts

Selected for the next assembly: [continuous Seedance shots 04–05](../06-shots/reviews/shot-04-05-continuous-seedance-480p-v01/README.md),
approved and locked by the user on October 29, 2026. It replaces the separate
departure/transformation clips. Existing assembled previews below have not yet
been updated to include it; later shots and final sound mixing remain open.

Current continuation prototype: [train-departure correction v02](transformation-sequence-v02/README.md).
It retains the first three FCP shots and original VO, with four new MiniMax
corrections from door closure through launch. The train departs and the later
shots maintain the cleared track. This version awaits user review.
The [original transformation prototype](transformation-sequence-v01/README.md)
and earlier opening exports below remain preserved.

Current working export: [trimmed FCP opening v01](fcp-opening-trimmed-v01/fcp-opening-trimmed-v01.mov).
The user requested removing the trailing black frame. This version is 224 frames,
9.333333 seconds at 24 fps, with audio trimmed to the same endpoint. Passthrough
export preserves the encoded media; the final decoded picture matches the
original's last visible frame. No Final Cut timeline changes were made.

Original user-supplied Final Cut review: [FCP opening v01](fcp-opening-review-v01/fcp-opening-review-v01.mov).
It is 9.375 seconds, 1920x1080/24 fps with stereo audio, archived without changes.
The [review notes](fcp-opening-review-v01/README.md) identify one trailing black
frame and link the actual last visible frame for the next-shot match cut.
This import does not change the previous approved cut's selection or files.

Previous approved review: [opening v03](opening-v03/opening-v03.mp4). Eight seconds, 24 fps,
832x480, native audio plus the existing train mix and an audio bridge. The user approved this eight-second cut. Preserve its timing and soundtrack
while testing upscales; the assistant has not independently listened to it.

| Timeline | Picture | Source range |
|---|---|---|
| 0.000–2.000 s | Legs take 5 | 0.500–2.500 s |
| 2.000–4.000 s | Badge take 3 | 0.500–2.500 s |
| 4.000–6.000 s | Chin take 1 | 0.500–2.500 s |
| 6.000–8.000 s | Doors take 6 | 0.500–2.500 s |

All picture runs at original speed. Hard cuts and aspect-fit framing; picture
is re-encoded for the assembled preview. Original approved files remain intact.
User found the prior five-second cut rushed and requested exactly two seconds
per shot. V03 uses the middle two seconds of each source, retaining the door
closure and the start of the moving reaction; its final half-second is trimmed.

## Working audio mix

Legs use the existing audio-v01 train mix; other shots use native sound.
Conservative RMS-based gain changes are limited to ±3 dB. Audio handles form
short crossfades around cuts; an 8 ms fade protects the outer edges. This is
technical level balancing, not perceptual loudness mastering.

The initial v01 exposed a quiet badge interval (about -32 dBFS RMS after gain).
V02 adds the first half-second of chin take 1 beneath that interval at -2 dB,
with 25 ms edge fades. It includes the full source soundtrack, potentially
breathing and steps as well as train ambience; no isolated train stem exists.
Badge taps stay underneath. No new audio generation or speech removal performed.

V02 measured PCM RMS -23.12 dBFS and decoded AAC sample peak -1.73 dBFS.
No sample clipping detected. Natural ambience, footstep rhythm, possible speech,
breathing repetition and cut continuity still require listening review.

## Reproduction and records

Each version includes `timeline.json`, MP4, mix WAV and `.edit.json` with
source ranges, gains, hashes, source provenance and metadata checks. V01 is
retained for audio comparison. See [script guide](../../scripts/README.md).

V03 extends the existing audio bridge across the two-second badge interval.
Verified duration: 8.000 seconds, 24 fps, one audio track; decoded AAC peak
-1.73 dBFS. V01/v02 remain for comparison. No source retiming or new generation.

The earlier departing-train/billboard continuation is superseded by the approved
instant station upgrade, eye HUD and superhuman montage. See the
[shot-five brief](../06-shots/video-prompts/shot-05-instant-upgrade-brief-v01.md).
The final original jingle remains open; the exploratory demo is not selected.
