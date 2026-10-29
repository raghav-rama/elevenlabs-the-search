# Continuous departure and transformation — Seedance 480p v01

[Watch the native clip](../../videos/shot-04-05-continuous-seedance-480p-v01.mp4) ·
[ElevenLabs Flow](https://elevenlabs.io/app/flows/A3IyZdzDXLKJFfEAS3R0) ·
[Exact prompt](../../video-prompts/shot-04-05-continuous-seedance-480p-v01.txt) ·
[Generation record](../../videos/shot-04-05-continuous-seedance-480p-v01.generation.json)

Status: **user-approved, selected and locked** on October 29, 2026.
The user accepted this continuous departure-to-transformation take as rendered.
Use it in place of separate shots 04 and 05 in the next assembly. The prior
assistant observations below remain historical review evidence; they do not
override the user's acceptance or authorize further generation.

The user requested replacing the choppy boundary between
[departure v02](../../videos/shot-04-train-departure-minimax-v02.mp4) and
[transformation v02](../../videos/shot-05-transformation-departure-minimax-v02.mp4)
with one continuous generation. Both completed clips were wired as ordered video references.
Existing source footage and the assembled v02 preview are unchanged.

## Result and cost

One Seedance 2.5 generation, requested 12 seconds, 480p, 16:9, audio enabled.
Native file is 854×480, 24 fps, 289 picture frames / approximately 12.042 seconds.
Audio is stereo AAC, 32 kHz / 12.064 seconds.
No upscale, crop, retime, replacement narration or additional take.

Estimate and final provider charge agree: **18,578.0052864 credits / INR 269.75263675852802**.
No retries, variants or paid QA. Generation `IADlmr2zGOc0HC4A4WL7`,
session `YS7RXjSdp0iXSC4BWeyM`.

## Assistant review

- The complete action is present: arrival, doors closing, leftward departure, disappointment, traveling transformation, hand inspection, then raised gaze.
- Dense sampled frames through the former join show stable Riley placement and station geometry while the train keeps receding. The old pose/background reset is not obvious in these samples.
- Adjacent decoded-frame measurements support that observation: no isolated scene-change spike around the former join. This is not a guarantee of perceptual smoothness.
- Head haze remains before the ripple. Gold transformation appears around local 6.75s, roughly 0.45s later than requested.
- Riley starts inspecting her hands before the boots finish changing. Facial/hardware detail is soft at 480p, and the cab-like lit train rear remains.
- All 289 frames decoded; no near-black frames detected. Native audio decoded with sample peak −5.20 dBFS. Complete listening/playback review and unwanted-speech checking remain pending.

The existing original VO's UPGRADE would fall at local 6.2917s if the clip were dropped in at the current shot-four start. Aligning it to the observed gold onset would require approximately 0.46s later VO placement; this is an editing proposal, not an applied edit. Keep “So” in the existing narration.

## Review evidence

- [Overall contact sheet](contact-sheet.jpg), sampled every 0.5s.
- [Former join detail](join-detail.jpg), 4.5–6.5s every 0.125s.
- [Consecutive join frames](join-frames.jpg), approximately 4.9167–5.4167s at 24fps.
- [Transformation onset detail](upgrade-detail.jpg), 6.0–7.5s every 0.125s.
- [Format and frame inspection](inspection.json).
- [Adjacent-frame measurements](frame-continuity.json) and [summary](continuity-summary.json).
- [Native decoded audio](native-audio.wav), unchanged content in a review WAV.
- [Structured review and price](review.json).

Reproducible commands are in the [script guide](../../../../scripts/README.md).
