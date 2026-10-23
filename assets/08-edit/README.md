# Opening review cuts

Current review: [opening v03](opening-v03/opening-v03.mp4). Eight seconds, 24 fps,
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

Next: review the eight-second cut, adjust timing or sound if needed, then lock
the hook before planning the departing-train/billboard continuation. The jingle
remains deferred; the exploratory demo is not included.
