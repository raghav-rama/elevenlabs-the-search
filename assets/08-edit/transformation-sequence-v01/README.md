# Transformation continuation — prototype v01

The train-departure correction is available as [prototype v02](../transformation-sequence-v02/README.md).
This original v01 preview remains preserved for comparison.

[Watch the assembled preview](afterhuman-transformation-preview-v01.mp4) · [Flow](https://elevenlabs.io/app/flows/1KlNu0Dsak5777WphodD)

24.708333 seconds, 593 frames, 1920x1080 / 24 fps, stereo 48 kHz.
Preserves the first three shots from the user's Final Cut opening, then uses the
full selected Seedance shot four and three new MiniMax tests. Original files
remain unchanged. No Final Cut project edit, source retime or production selection.

| Preview time | Picture / audio |
|---|---|
| 0–6.083s | First three opening shots, original timing |
| 6.083–11.125s | Full Seedance shot four |
| 7.875s | Existing VO file begins |
| 11.125–17.708s | Human continuation, traveling transformation, hand inspection |
| 11.595s | So begins (QA transcription: 11.60s) |
| 12.375s / 00:00:12:09 | UPGRADE begins with visible surface change (QA: 12.38s) |
| 17.708–22.208s | Confident smirk, push into eyes |
| 22.208–24.708s | Turn, planted push-off, fast platform exit |

The timing follows the actual generated change, five frames earlier than the
initial prompt target. [Timeline](timeline.json), [cue rationale](timing-plan.json),
[edit report](afterhuman-transformation-preview-v01.edit.json), [frame inspection](inspection.json)
and [contact sheet](contact-sheet.jpg) preserve the review evidence. Native
1344x768 clips use aspect-fill with a small vertical crop, without stretching.

The original VO was decoded to [WAV](voiceover-decoded-review.wav) for assembly;
[provenance](voiceover-decoded-review.provenance.json) records the unchanged MP3
and exact sample count. Two initial local assembly attempts stopped on a bridge
length mismatch before writing a preview; reading the prepared WAV resolved it.
No provider generation was repeated. Native audio is crossfaded at cuts and
ducked under the narration. Decoded AAC sample peak is -1.54 dBFS.

[Speech QA](preview-speech-check.json) returned exactly the intended 11 words
with no extra words. This checks the mixed preview, not isolated native tracks.
Full playback/listening and user approval remain pending.

## Original new takes

- [05: transformation and hands](../../06-shots/videos/shot-05-transformation-minimax-v01.mp4) — requested 6s; actual 158 picture frames, about 6.584s.
- [06: smirk and eye push](../../06-shots/videos/shot-06-eye-push-minimax-v01.mp4) — requested 5s; actual 124 frames, about 5.167s.
- [07: speed launch](../../06-shots/videos/shot-07-speed-launch-minimax-v01.mp4) — requested 5s; actual 124 frames, about 5.167s. Preview uses source 0.5–3.0s.

One take per beat, no extra variants or retries. The unused hands guide was
rejected for outward palms; the eye guide was used. Exact prompts, source hashes,
settings, run IDs and costs accompany each asset.

## Review limits

User correction: the train must start departing as the doors finish closing and
continue its departure across the following shots. The current stationary-train
prototype needs that correction; see the [updated brief](../../06-shots/video-prompts/shot-05-07-transform-sequence-v01.md).

The transformation reads as gold microtiles/pixels; boots finish relatively late.
The hand inspection is visible. The eye push shows the smirk before the mouth
leaves frame, but neck hardware and background numeral details drift. The launch
leaves a strongly blooming cyan/magenta trail and invents some rear outfit detail.
These are prototypes for user review, not final production masters. No new
jingle, montage abilities, train overtake or branding is included in this pass.

Reproduction commands are in [scripts/README.md](../../../scripts/README.md).
Current iteration cost: 6535.066521 credits / INR 94.889166 (approximately INR 94.89).
See [the cost record](costs.json), including actual transcription price above its estimate.
