# AFTERHUMAN — American bass voice auditions v01

Three user-authorized full-script reads of preferred announcer option A,
including “Missed your train? Still running on flesh and blood? So upgrade.”
**David full-v01 is user-approved and locked as of 2026-10-29T23:01:30+05:30.**
Use this exact take for the next edit. Desmond and K. V. Hagen remain unselected
alternatives; original opening audio is preserved. Final Cut integration and the
final mix remain pending.

| Voice | Original MP3 | Decoded duration |
| --- | --- | --- |
| Desmond — Trailer & Ad Voice | [Listen](afterhuman-vo-desmond-full-v01.mp3) | 17.006 s |
| **David — The Movie Trailer (SELECTED)** | [Listen](afterhuman-vo-david-full-v01.mp3) | 16.927 s |
| K. V. Hagen — Exceptionally Deep Bass | [Listen](afterhuman-vo-kv-hagen-full-v01.mp3) | 17.789 s |

[ElevenLabs Flow](https://elevenlabs.io/app/flows/0DSYP67LuQmAF93hhGaq)
contains all three takes. Native MP3s are mono, 44.1 kHz, approximately 128 kbps.
Provider durations differ slightly from decoded MP3 lengths due to packaging.

## Script and delivery

[Exact submitted text](afterhuman-vo-announcer-full-v01.txt) is identical for all
three voices. Eleven v4, one take each, default voice settings. The user-requested
phrase is `[matter of fact] So upgrade.` with no punctuation or tag between the
two words, normal capitalization and no emphasis instruction. Other script A
emotion tags are preserved. No music, equalization, pitch shift, gain adjustment
or timing edit was applied to these native outputs.

The current music direction remains an instrumental, upbeat fast heavy-metal
jingle beginning after the spoken upgrade ends. This batch generated speech
only, and has not changed Final Cut or the assembled video.

## Checks and limitations

- All MP3s downloaded, hashed and decoded successfully; no full-scale samples
  appeared in the 16-bit PCM inspection. See [audio checks](audio-checks.json).
- David's original export has a higher measured RMS level than the other two.
  Compare at comfortable similar playback loudness; originals are preserved.
- TTS-linked transcription returned the submitted text including emotion tags.
  This appears to reuse provider text/alignment and is **not independent ASR or
  listening approval**. Bracket tokens in that result are not evidence that
  directions were spoken.
- Provider word timing places a 0.08-second boundary between So and upgrade in
  each take. It indicates no long inserted pause, but does not establish the
  perceived stress or naturalness of the phrase. The user has approved David
  as rendered; independent assistant listening is not claimed.
- Source-relative upgrade ends at 4.36 s for Desmond and David, and 4.68 s for
  Hagen in provider alignment. These are provisional music-entry references,
  not locked edit cues; actual decoded durations and alignment do not match exactly.

## Provenance and cost

[Batch record](audition-batch.json) links voice IDs, nodes, sessions, live schema,
estimates and settings. Each MP3 has an adjacent `.generation.json`, `.timing.json`
and `.afinfo.txt`. Seeds were neither requested nor returned.

Actual synthesis: **320 credits / INR 4.6464 each; 960 credits / INR 13.9392 total**.
The three TTS-linked timing checks were estimated and reported at run time as
zero credits; their final status did not expose separate prices. No retries,
additional speech variants, jingle or video generations occurred.

## Reproduce local checks

Run from the repository root with an unused report destination:

```sh
python scripts/inspect-voiceover-auditions.py \
  assets/09-voiceover/auditions/american-bass-v01 \
  /private/tmp/afterhuman-voice-audio-checks.json
```

The script hashes originals, decodes into temporary PCM with macOS `afconvert`,
measures sample count/format/levels, then removes temporary audio. It refuses to
overwrite the report and never changes source media. Container metadata can be
rechecked with `afinfo INPUT.mp3`.
