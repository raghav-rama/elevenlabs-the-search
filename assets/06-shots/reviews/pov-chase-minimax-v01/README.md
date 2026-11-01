# POV chase — MiniMax prototype review

Five separate ElevenLabs MiniMax H3 takes, requested at 480p / five seconds each. One generation per shot, no paid retries. Provider-reported total: **7575 credits / INR 109.989**, or 1515 credits per take. All remain prototypes pending user review.

[ElevenLabs Flow](https://elevenlabs.io/app/flows/RvZqvPiEMwNzDR2Oc5LG) · [Production plan](../../video-prompts/pov-chase-minimax-prototypes-v01.md) · [Batch provenance](../../videos/pov-chase-minimax-batch-v01.json)

| Shot | Watch | Sampled review |
| --- | --- | --- |
| 08 — Intelligence | [HUD concept v02](shot-08-pov-intelligence-hud-preview-v02.mp4) · [Raw plate](../../videos/shot-08-pov-intelligence-minimax-v01.mp4) | First-person run and left turn read clearly. HUD supplies route solving; the plate alone does not establish competing routes clearly. |
| 09 — Reflexes | [Phone catch](../../videos/shot-09-pov-reflexes-minimax-v01.mp4) | Single phone is caught and held. Initial action looks like an upward toss rather than an accidental drop; timing needs playback review. |
| 10 — Strength | [Cart lift](../../videos/shot-10-pov-strength-minimax-v01.mp4) | One-handed lift/move reads in samples, with elevated wheels. Weight and continuous motion need review. |
| 11 — Speed | [Train-side sprint](../../videos/shot-11-pov-speed-minimax-v01.mp4) | **Needs direction correction:** train approaches/passes Riley rather than traveling ahead in the same direction. |
| 12 — Payoff | [Overhead race](../../videos/shot-12-overhead-overtake-minimax-v01.mp4) | **Needs geography correction:** train is perpendicular to rails and Riley moves laterally. Intended overtake is not demonstrated. |

The existing [launch v02](../../videos/shot-07-speed-launch-departure-minimax-v02.mp4) can bridge into this test sequence without another paid take. Its heavy trail bloom and rear outfit drift remain prototype flaws; it is not newly selected. Approved opening/departure/transformation remains unchanged. Separate eye close-up is omitted from the approved chase direction.

## Evidence and limits

Each new native clip decodes to **832×480, 24 fps, 124 frames / 5.166667 seconds**. Provider/container duration is 5.184 seconds. Requested 16:9 produced the native dimensions above; no crop or upscale was applied. No near-black frames were detected. Native audio is stereo AAC at 32 kHz, decoded into 48 kHz review WAVs.

Findings use 14-frame contact sheets and technical decoding, not full playback or listening. Native speech absence and sound continuity remain unverified. Every take has an adjacent generation record with exact prompt, input references/hashes, settings, request IDs and price. Each review folder contains inspection, frames, audio and explicit findings:

- shot-08-pov-intelligence-minimax-v01: [frames](../shot-08-pov-intelligence-minimax-v01/contact-sheet.jpg), [review](../shot-08-pov-intelligence-minimax-v01/review.json), [generation](../../videos/shot-08-pov-intelligence-minimax-v01.generation.json).
- shot-09-pov-reflexes-minimax-v01: [frames](../shot-09-pov-reflexes-minimax-v01/contact-sheet.jpg), [review](../shot-09-pov-reflexes-minimax-v01/review.json), [generation](../../videos/shot-09-pov-reflexes-minimax-v01.generation.json).
- shot-10-pov-strength-minimax-v01: [frames](../shot-10-pov-strength-minimax-v01/contact-sheet.jpg), [review](../shot-10-pov-strength-minimax-v01/review.json), [generation](../../videos/shot-10-pov-strength-minimax-v01.generation.json).
- shot-11-pov-speed-minimax-v01: [frames](../shot-11-pov-speed-minimax-v01/contact-sheet.jpg), [review](../shot-11-pov-speed-minimax-v01/review.json), [generation](../../videos/shot-11-pov-speed-minimax-v01.generation.json).
- shot-12-overhead-overtake-minimax-v01: [frames](../shot-12-overhead-overtake-minimax-v01/contact-sheet.jpg), [review](../shot-12-overhead-overtake-minimax-v01/review.json), [generation](../../videos/shot-12-overhead-overtake-minimax-v01.generation.json).

## Local HUD preview

HUD v02 adds provisional AFTERHUMAN neural-link text, route calculation, left-turn instruction and arrow. It is a screen-space concept, not tracked VFX or a final design. Source audio, playback speed and native dimensions are retained. [Edit record](shot-08-pov-intelligence-hud-preview-v02.edit.json), [frames](hud-inspection/contact-sheet-v02.jpg), [inspection](hud-inspection-v02/inspection.json).

Local v01 is retained as a failed export: panels/arrow appeared but text was absent, and the export added one frame. v02 rasterizes text and sets the export range explicitly. This local correction cost no generation credits. See the [scripts index](../../../../scripts/README.md) for reproduction.

## Next edit

Review clips individually, then correct the train direction/geography before using the race as the payoff. Locked David and Chrome Swagger remain unchanged. Narration spacing, instrumental breathing room, exact cuts, spiral/end card and final sound mix remain pending. These clips have not been assembled to the selected audio.

## User rejection — 2026-10-31T21:31:44+05:30

All five video prototypes rejected. HUD, phone handoff, wheeled-cart premise, slow movement and invalid race geography do not meet the brief. Rebuild as still-first scenes in different locations. Previous assistant observations above are historical, not user acceptance. Sources retained.
