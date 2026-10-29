# Train-departure correction — prototype v02

[Watch the corrected preview](afterhuman-transformation-preview-v02.mp4) ·
[ElevenLabs Flow](https://elevenlabs.io/app/flows/A3IyZdzDXLKJFfEAS3R0)

The train now pulls away at the door-closing beat, recedes during Riley's
transformation, and stays away through the eye push and launch. This is a new
review version following the user's explicit correction request. Original
Seedance/MiniMax videos and the previous assembled preview remain unchanged.

24.708333 seconds / 593 frames, 1920x1080 / 24fps, stereo 48kHz. Four new
MiniMax H3 reference-video takes, native 1344x768, one take each with no retries.
The preview uses aspect-fill with a small vertical crop; original downloads
retain their native dimensions. No source retiming or Final Cut project edit.

## Individual corrected takes

- [04 — Doors close and train departs](../../06-shots/videos/shot-04-train-departure-minimax-v02.mp4)
- [05 — Transformation and hand inspection](../../06-shots/videos/shot-05-transformation-departure-minimax-v02.mp4)
- [06 — Smirk and eye push](../../06-shots/videos/shot-06-eye-push-departure-minimax-v02.mp4)
- [07 — Speed launch after the train](../../06-shots/videos/shot-07-speed-launch-departure-minimax-v02.mp4)

Each take has an adjacent generation record with the exact submitted prompt,
inputs and hashes, effective settings, run IDs, cost and sampled review outcome.
MiniMax's provider-default prompt enhancement was enabled; its internal rewritten
prompt is not exposed. Reference-video generation does not guarantee identical
pixels or action timing.

## Edit and narration

| Preview time | Picture / audio |
|---|---|
| 0–6.083s | First three shots from the user's opening, original timing |
| 6.083–11.125s | Corrected shot 04, source 0–5.041667s / 121 frames |
| 7.875s | Existing original VO begins |
| 11.125–17.708s | Corrected transformation and hands, full 158 frames |
| 11.595s | So begins; mixed-audio QA reports 11.60s |
| 12.375s / 00:00:12:09 | UPGRADE at visible gold surface change; QA reports 12.38s |
| 17.708–22.208s | Corrected eye push, source 0.5–5.0s |
| 22.208–24.708s | Corrected launch, source 0.5–3.0s |

Shot 04 omits its final three generated frames to better match train distance
and Riley's pose at the next shot. The eye take reaches its tight framing later
than v01, so the first half-second is trimmed to keep the total duration.
[Timeline](timeline.json), [timing rationale](timing-plan.json),
[edit report](afterhuman-transformation-preview-v02.edit.json),
[frame inspection](inspection.json) and [contact sheet](contact-sheet.jpg)
preserve the assembly evidence. See [reproduction commands](../../../scripts/README.md).

Native audio is crossfaded at cuts and ducked under the original narration.
The narration uses the verified decoded WAV from v01; no replacement speech.
Decoded AAC sample peak is -1.50 dBFS. [Speech QA](preview-speech-check.json)
found exactly the intended 11 words and no additional words. This checks the
mixed preview, not isolated native tracks or perceptual sound quality.

## Review limits and cost

Sampled review shows the required leftward departure and no nearby train reset
in the later shots. Door closure and movement occur around source 1.4–1.6s,
earlier than the prompt's requested 2.5s; the exact overlap still needs playback
review. The receding train has a cab-like lit end. A brief haze before the
transformation, late boot completion, hardware variation, broad launch glow and
altered rear dress details remain cosmetic review issues. Full playback/listening
and user approval remain pending; these takes are not selected production masters.

Actual correction-pass cost: **7771.495896 credits / INR 112.842120** (about
**INR 112.84**), comprising four videos and one QA transcription. The transcription
actual price exceeded its estimate; both are preserved in [cost records](costs.json).
Earlier passes are excluded. No new images, jingle or later montage shots were generated.
