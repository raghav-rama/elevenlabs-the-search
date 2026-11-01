# AFTERHUMAN jingle

## Selected and locked — Chrome Swagger v01

The user explicitly selected Chrome Swagger: “Ok lock in chrome swagger.”
Use this exact existing take for the ad, paired with the locked David narration.

- [Original instrumental](afterhuman-instrumental-chrome-swagger-v01.mp3) — 18 seconds.
- [Listen with David](reviews/afterhuman-instrumental-chrome-swagger-v01-with-david.wav) — 22.36 seconds.
- [Generation and approval record](afterhuman-instrumental-chrome-swagger-v01.generation.json).

The current preview enters after “So upgrade,” at VO-relative 4.36 seconds.
Final picture placement and master mix remain to be aligned in the edit.
The original audio and preview are unchanged; the other takes remain available
as unselected alternatives, not rejected assets.

## Surprise-version comparison — selection complete

The user requested three more experiments after noting repetition beneath the
narration. Each is one new 18-second ElevenMusic v2 instrumental take, with a
prompt asking for changing phrases, a brief break and a stronger ending.
The directions below describe the briefs. Chrome Swagger is user-approved and
locked; Overclock and Redline are retained as unselected alternatives.

| Take | Requested direction | With David | Instrumental |
| --- | --- | --- | --- |
| Overclock | Cyberpunk drum and bass, 174 BPM | [Preview](reviews/afterhuman-instrumental-overclock-v01-with-david.wav) | [MP3](afterhuman-instrumental-overclock-v01.mp3) |
| **Chrome Swagger — selected** | Futuristic spy-funk with brass and guitar, 148 BPM | [Preview](reviews/afterhuman-instrumental-chrome-swagger-v01-with-david.wav) | [MP3](afterhuman-instrumental-chrome-swagger-v01.mp3) |
| Redline | Industrial rave-metal with acid synth, 160 BPM | [Preview](reviews/afterhuman-instrumental-redline-v01-with-david.wav) | [MP3](afterhuman-instrumental-redline-v01.mp3) |

All previews last 22.36 seconds and use the locked David narration, unchanged
voice/master gains and music starting at 4.36 seconds. Music source RMS is
approximately matched to the liked metal take. Chrome Swagger needed a further
2.4 dB music-only reduction to respect the fixed sample-peak ceiling; narration
stays unchanged. This is not perceptual loudness matching or final picture timing.
The standalone files preserve their original levels.

All three generations succeeded without retries. **Reported total: 810 credits /
INR 11.7612**, versus a 1636.363636-credit / INR 23.76 estimate.
[Batch record](surprise-batch-v01.json) and
[ElevenLabs Flow](https://elevenlabs.io/app/flows/1Wm2iEn6GL4TBWH62VVi).
Exact prompts, settings, individual IDs, prices and review checks are in the
[Overclock](afterhuman-instrumental-overclock-v01.generation.json),
[Chrome Swagger](afterhuman-instrumental-chrome-swagger-v01.generation.json), and
[Redline](afterhuman-instrumental-redline-v01.generation.json) records.

Reproduce any preview with its matching `reviews/*-preview-config.json` and an
unused WAV output path using `scripts/mix-voiceover-jingle.py`. The existing
metal and breakbeat takes below remain available unchanged.

## Retained alternative — instrumental metal v01

- [Original instrumental MP3](afterhuman-instrumental-metal-v01.mp3) — 18 seconds
  of valid audio, stereo 48 kHz / 192 kbps; container estimate 18.024 seconds.
- [Listen with the locked David voiceover](reviews/afterhuman-instrumental-metal-v01-with-david.wav)
  — a 22.36-second stereo 48 kHz WAV listening preview, not the final mix.
- [ElevenLabs Flow](https://elevenlabs.io/app/flows/C9qEH7lt72zAZFiw0Toa),
  [exact prompt](prompts/afterhuman-instrumental-metal-v01.txt), and
  [generation record](afterhuman-instrumental-metal-v01.generation.json).

User requested fast, upbeat heavy metal, entirely instrumental, entering after
the announcer finishes “So upgrade.” This take uses ElevenMusic v2 with both
instrumental controls enabled and no lyrics. One generation only, no retries.
An 18-second length, target 160 BPM, repeated four-note guitar/synth hook and a
resolved ending are assistant arrangement choices. The prompt describes original
music; no reference recording was uploaded or sampled.

**User liked the raised-volume metal preview, then selected Chrome Swagger.**
Metal is retained as an unselected alternative. This is user feedback, not an independent assistant
listening claim. The earlier sung electro-funk demo is preserved below as
unselected history.

### Listening preview

The preview uses David's approved full take unchanged as its input, with music
starting at VO-relative **4.36 seconds**, the provisional provider timing for
the end of upgrade. The user requested a small music-volume lift: all music
stages are now **1.5 dB higher**, with an -8.5 dB entrance, -15.5 dB under the
voice and -5.5 dB after the voice finishes. These are source gains, not loudness
targets. The previous shared gain is fixed at -0.608 dB so narration stays at
its prior level; the resulting sample peak is approximately -0.934 dBFS.
No speech was regenerated or retimed. The
[previous quieter preview](reviews/archive/afterhuman-metal-with-david-before-volume-lift-v01/afterhuman-instrumental-metal-v01-with-david.wav)
is preserved, with its configuration and report.

Both original files remain untouched. This is an audio audition, not a change
to Final Cut or the approved picture edit. Final narration placement, jingle
entry and mix need alignment with the revised montage. Listen to the separate
music file to assess its full sound without the preview's narration ducking.

[Preview configuration](reviews/afterhuman-instrumental-metal-v01-preview-config.json)
and [render/hash/level report](reviews/afterhuman-instrumental-metal-v01-with-david.mix.json)
record the exact sources, gains and timing. Reproduce from the repository root
using an unused output path:

```sh
python scripts/mix-voiceover-jingle.py \
  assets/07-jingle/reviews/afterhuman-instrumental-metal-v01-preview-config.json \
  /private/tmp/afterhuman-metal-with-david.wav
```

Estimate: 545.454545 credits / INR 7.92. **Actual: 270 credits / INR 3.9204.**
No stem separation, extra generation or paid transcription was used. A public
jingle share link and final competition deliverables remain pending.

## Retained alternative — surprise breakbeat v02

- [Listen with David](reviews/afterhuman-instrumental-breakbeat-v02-with-david.wav)
  — 22.36-second comparison preview.
- [Instrumental only](afterhuman-instrumental-breakbeat-v02.mp3)
  — 18 seconds of valid audio, stereo 48 kHz / 192 kbps.
- [Exact prompt](prompts/afterhuman-instrumental-breakbeat-v01.txt),
  [generation record](afterhuman-instrumental-breakbeat-v02.generation.json), and
  [ElevenLabs Flow](https://elevenlabs.io/app/flows/rk8VvcpYBfzPKDD2YeE8).

The user explicitly authorized one retry after the failed v01 attempt below.
It succeeded using ElevenMusic v2, with the same instrumental cyberpunk
big-beat/electro-funk brief: syncopated drums, distorted synth bass and a recurring
three-note hook, targeting 160 BPM. These describe the requested direction;
catchiness, genre, tempo and absence of vocal artifacts await listening review.
This alternative is not selected or approved, and the liked metal take remains
available above.

The preview keeps David at the same level and music entry at **4.36 seconds**.
Music source RMS is approximately matched to metal with a +0.437 dB correction;
its envelope is then lowered by 0.1 dB to stay below the fixed sample-peak ceiling.
The narration-only prefix is byte-identical to the liked metal preview. This
is an audition mix, not perceptual loudness matching or final picture alignment.

[Configuration](reviews/afterhuman-instrumental-breakbeat-v02-preview-config.json)
and [render report](reviews/afterhuman-instrumental-breakbeat-v02-with-david.mix.json)
record the sources and exact gains. Reproduce with an unused output path:

```sh
python scripts/mix-voiceover-jingle.py \
  assets/07-jingle/reviews/afterhuman-instrumental-breakbeat-v02-preview-config.json \
  /private/tmp/afterhuman-breakbeat-with-david.wav
```

Successful retry: **270 credits / INR 3.9204**, against an estimate of
545.454545 credits / INR 7.92. The failed attempt's debit/refund state remains
unconfirmed. No further take was generated.

## Surprise breakbeat experiment v01 — failed, no audio

User requested a surprise alternative after liking the raised-volume metal mix.
One 18-second instrumental cyberpunk big-beat/electro-funk take was attempted,
with a recurring synth hook and syncopated bass/drums. ElevenLabs returned an
unexpected processing error; the existing node confirms a failed generation
and exposes no recoverable audio. No comparison preview could be rendered.

[Exact prompt](prompts/afterhuman-instrumental-breakbeat-v01.txt),
[failure record](afterhuman-instrumental-breakbeat-v01.generation.json), and
[Flow](https://elevenlabs.io/app/flows/rk8VvcpYBfzPKDD2YeE8).
Generation `sermFfLv5UvFtQMjJzr1` was submitted once; no automatic retry occurred.
The failed response lists 270 credits / INR 3.9204, but does not confirm a net
debit or refund. A fresh estimate-only check quotes 545.454545 credits / INR 7.92
for a new take. Both original metal files and the locked David source remain
unchanged. The user subsequently authorized the separate successful v02 retry
above; this record preserves the original failure.

## Historical demo v01 — A step ahead (unselected)

This earlier low-credit exploration is not selected for the ad. Its sung
electro-funk direction and earlier medical-procedure placement were superseded
by the current instrumental metal direction and visible upgrade sequence.

Requested direction: 12 seconds of futuristic electro-funk at 120 BPM, clear
adult female singing, synth bass, claps, glassy plucks and metallic clicks.
Repeat the same short melody on the brand name for recall.

Submitted lyrics:

> Afterhuman, a step ahead.  
> Missed your train? Beat it there.  
> Afterhuman, a step ahead.

[ElevenLabs project](https://elevenlabs.io/app/flows/yEGTALXtr4AhdsV0DdYX)
and [exact generation record](afterhuman-demo-v01.generation.json).

Completed audio: [demo v01 MP3](afterhuman-demo-v01.mp3). Verified stereo MP3,
48 kHz, 192 kbps, 12 seconds of valid audio (12.024-second container estimate).

Credit estimate: 164.835; reported generation charge: 180 credits. Exactly one
generation was requested using ElevenLabs Music v2. No extra variations, stem
separation, voice generation or paid transcription were requested.

Listen for clear pronunciation of AFTERHUMAN, lyric accuracy, a memorable repeated
melody, and a clean ending. Intended genre/tempo/vocal qualities describe the
prompt and are not assistant listening findings. The user liked the exploration
but explicitly clarified that this exact demo will not be used.
This demo has not been mixed into the opening or published as a contest entry.
The final Studio project/public jingle share deliverables remain separate.

## Continuous picture review — 2026-10-31

[Watch the 45-second ad review](../08-edit/continuous-ad-review-v01/afterhuman-continuous-with-david-v01.mp4). The locked music source is unchanged. A derived arrangement enters immediately after So upgrade, filters down during the coffee catch setup, restarts the full 18-second cue on the catch, and keeps the signature ending. David's whole phrases are spaced around the action. [Exact timing/mix records](../08-edit/continuous-ad-review-v01/README.md). This edit awaits listening approval; the earlier selected source and audition preview remain intact.
