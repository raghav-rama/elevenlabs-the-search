# Shot 02 — Bouncing KORVEX badge

Status: **take 3 is user-approved and selected** (“Looks good now.”).
Takes 1 and 2 remain rejected historical tests.

## Inputs

- Starting frame: [shot-02-v02.png](../images/shot-02-v02.png).
- Optional exact print reference: [badge-02-v01.png](../../03-badge/images/badge-02-v01.png).
- Optional hardware reference: [badge-04-v01.png](../../03-badge/images/badge-04-v01.png).
- Target edit segment: approximately 0.5 seconds containing one readable swing.
- Generated test: [shot-02-take-01.mp4](../videos/shot-02-take-01.mp4).
- [Exact generation record](../videos/shot-02-take-01.generation.json): H3 Max Turbo, 480P, requested 3 seconds, prompt expansion disabled.

## Current approach: badge-specific motion reference

Latest feedback: take 2 still feels too slow; the user reports six audible
footsteps and suggested speeding the reference. Take 3 uses prepared v03 at
1.5× speed (source 3–7.5 seconds into three seconds), with take 2's exact prompt,
appearance image, seed and output settings. This changes the motion reference
only among model inputs. The source window is longer to avoid looping.
Audible impacts are not a measurement of visual gait; feet are outside frame.
[Take 3 generation record](../videos/shot-02-take-03.generation.json).

The user supplied `assets/references/card-wiggle.MP4`. Prepared v02 selects
3–6 seconds at original speed, crops with margin for the swing, and removes
audio. Use it only for the holder's movement, twist and timing; use the Riley
still for all appearance and scene details. The source has a blue shirt and a
different holder, strap and background, so appearance transfer needs checking.
The source does not show feet and cannot establish an exact running cadence.
Check generated audio for speech even though the motion reference is silent.

## Fallback proposal: controlled badge insert

Prepare a clean white-shirt background and separate masks for the rigid badge,
clear holder, swivel clip, and burgundy lanyard from the approved shot frame.
Animate the holder around its attachment point with small perspective changes;
deform the strap so it stays connected. Add subtle shirt motion and moving
plastic highlights. A whole-frame shake alone will not create relative badge motion.

Use approved shot 1 take 5 for timing: start already moving, keep the effort
consistent, and cut roughly half a second around one readable forward swing.
Badge inertia should lag torso impacts, with small twists and shirt taps;
it should not mechanically complete one full swing per footstep. The legs
reference supplies cadence, not a measured torso or badge trajectory.

Keep the printed portrait and lettering fixed to the card using a perspective
transform. Check clear-holder edges, attachment continuity, motion blur, and
parallax at full speed; flat cutout motion is the main risk of this approach.
If that test looks artificial, obtain a close-up motion reference of a real
lanyard during running before another reference-to-video attempt.

Mute the rejected take's soundtrack. Carry a reviewed station/train bed across
the opening, with aligned footsteps and a quiet badge tap. Shot 3 take 1's
soundtrack is an available source, but includes breathing and incidental sounds;
it is not an isolated train stem. Check for speech before using any audio.

## Historical submitted video prompt

```text
Animate the supplied extreme badge close-up as one continuous photorealistic 16:9 shot while Riley runs. The portrait-format employee card remains in its clear rigid holder on the same burgundy lanyard and metal swivel clip. The holder occupies roughly 80 percent of frame height. Preserve the exact printed portrait and exact text: KORVEX, Riley Brooks, EMPLOYEE. The portrait is a static printed photograph throughout.

The close camera moves with her torso, keeping the badge centered while her running produces a small natural pendulum swing. Let the badge swing outward from the white shirt, tilt slightly toward the lens for one clearly readable beat, and settle back toward the fabric. The clip remains connected and the lanyard carries its weight continuously. Small secondary shirt ripples and plastic reflections follow the motion. Use the same physical badge size; achieve the tight framing through camera proximity. Keep the face, waist, hands, and whole bag out of frame.

Maintain soft 8:30 a.m. station daylight and subtle cyan/magenta reflections on the plastic. No independent motion inside the portrait, changing letters, duplicated cards, detached clip, tangled strap, exaggerated spinning, abrupt zoom, cuts, or added graphics. Keep enough sharpness during the forward swing to register her portrait and employer immediately.

Native sound: a light plastic-and-metal badge rattle, a soft tap against cotton, shirt rustle, continuing hurried heel strikes beneath the frame, and the same adult woman's running breath within spacious station ambience. Match the tempo of an ordinary hurried run. No music, narration, speech, or added announcement. Continue the motion naturally through the end.
```

## Selection and edit notes

- Cut into the outward swing and leave after its readable beat.
- A small perspective change is useful; a full rotation would hide the employer.
- Check the portrait remains still on the card and the lettering never morphs.
- Keep footsteps and breathing continuous across shots 1–3 in the edit.

## Take 2 — approved motion-reference test

Endpoint: `minimax/h3-max/reference-to-video`. Requested 3 seconds, 480P,
16:9, seed 20261015, prompt expansion disabled. Appearance and motion are
reference inputs; no fixed first-frame image. Estimated cost $0.15.
[Exact generation record](../videos/shot-02-take-02.generation.json).

```text
Use Image 1 for the exact KORVEX employee badge, Riley Brooks printed portrait, white shirt, burgundy lanyard, metal swivel clip, clear rigid holder, tight framing and cyan/magenta morning reflections. Use Video 1 only for the badge's continuous bouncing motion, small twists and timing at its supplied playback speed. Transfer that ongoing motion from the opening frame through the end while Riley is already running.

The camera moves with her torso in one uninterrupted close-up. The holder fills roughly 80 percent of frame height, with room for its swing; the shirt stays relatively anchored behind it. The badge bounces against the shirt and tilts naturally on its connected clip, following the rhythm in Video 1 without slowing down or starting from rest. Preserve Image 1's appearance throughout; exclude the blue shirt, plain card, different holder and room from Video 1. Keep the printed portrait still and the printed text unchanged: KORVEX, Riley Brooks, EMPLOYEE. No zoom or cuts.

Audio: quiet train rumble and station air, light plastic badge taps and fabric rustle only. No speech, reading of the badge, narration, announcements or music.
```

Take 2 review: user rejected its pace and reported six audible footsteps.
Sampled frames retain Riley's white shirt and badge design,
with repeated motion. Lettering shows transient distortion/softness in some
frames. Audio has not been listened to; absence of speech is unverified.

## Take 3 result

[Preview take 3](../videos/shot-02-take-03.mp4). Generation completed at 24 fps,
3.042 seconds. Frame review shows more frequent badge motion than take 2, with
some remaining print/portrait deformation. The user approved this take: “Looks
good now.” Assistant audio listening was not performed.
The submitted prompt is identical to take 2 above; only the motion-reference
URL changes. Exact inputs are saved in the take 3 generation record.
