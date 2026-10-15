# Shot 03 — Camera follows Riley's chin

Status: revised starting frame v03 generated and visually reviewed; ready for a
video test following user acceptance of v03. Earlier frames remain historical. The still
establishes perspective; chin anchoring must be checked in the generated motion.

Take 1 was rejected by the user for stationary background and moving chin.
[Take 2](../videos/shot-03-take-02.mp4) was also rejected: the same motion failure, worse than take 1, with grainy windows.
[Take 3](../videos/shot-03-take-03.mp4) used Kling 3.0 Standard and a short prompt; rejected because she starts running rather than already running.
[Take 2 generation record](../videos/shot-03-take-02.generation.json).

## Inputs

- Starting frame: [shot-03-v03.png](../images/shot-03-v03.png).
- [Image brief](../prompts/shot-03.md) and [exact generation record](../images/shot-03-v03.generation.json).
- Canonical identity: [riley-01-v01.png](../../01-riley/images/riley-01-v01.png).
- Wardrobe/strap: [badge-05-v01.png](../../03-badge/images/badge-05-v01.png).
- Ceiling/environment: [station-03-v01.png](../../04-station/images/station-03-v01.png).
- Lens inspiration only: [user fisheye example](../../references/fisheye/user-inspiration-01.png).
- Target edit segment: approximately 0.85 seconds of panting and background movement.
- First test: [shot-03-take-01.mp4](../videos/shot-03-take-01.mp4), generated with fal H3 Max Turbo, 480P, requested duration 3 seconds. Rejected for camera motion.
- [Exact video generation record](../videos/shot-03-take-01.generation.json).

Attach the revised still as the first frame. Attach identity/environment references
only if useful and supported by the selected interface. The stock example is a
design reference for the lens effect, not a required video input or source person.

## Ready-to-paste video prompt

```text
One continuous photorealistic 16:9 running shot with a pronounced ultra-wide fisheye lens. Riley is the same 27-year-old brunette woman in the reference, with the same brown bob, facial identity, natural skin, and mole beneath her anatomical LEFT eye. She is an ordinary breathless commuter before any upgrade, wearing the same white collared shirt, burgundy lanyard, and black bag strap over her right shoulder.

The tiny camera sits very close just BELOW AND SLIGHTLY IN FRONT OF HER CHIN, pointing steeply upward toward her face, as though carried on a short invisible rig fixed to her head. The camera translates and rotates with her head's running motion, keeping a nearly constant distance and angle to the chin. Her chin stays approximately anchored near the lower center of frame. It has small natural motion from her jaw and breathing; her face does not drift away from the lens. Her chin and lower face loom large, the forehead recedes, and the ceiling lines curve strongly around her. Preserve her recognizable facial features within the deliberate optical distortion.

As she runs, she pants through parted lips, her jaw moves naturally, her eyes remain focused ahead, and her bob flutters. Her shoulders bounce independently near the lower edges. Because the camera follows her head, the station ceiling, skylights, and cyan/magenta light strips bob and roll around the relatively anchored face. Forward motion carries the ceiling structure past overhead. This background movement is rhythmic and connected to real footfalls, not random camera shake.

Keep the lens distortion constant throughout and retain diffuse 8:30 a.m. daylight. Use a full-frame fisheye image filling the 16:9 canvas as the working presentation. The camera is not an external tracking camera, a selfie held at arm's length, a chest-mounted camera, or a view from above. No visible rig, circular black border, sunglasses, copied stock-photo person, grin, dialogue, implants, face morphing, cuts, zooms, or unrelated wobble effects.

Native sound: close, natural adult female panting and short exhales synchronized with her mouth and jaw, continued hurried heel impacts below frame, subtle collar and strap movement, and station ambience. A distant departure warning chime may begin near the end. No music, narration, or spoken words. Keep her running and panting through the end for a direct cut to the wider doorway shot.
```

## Selection and edit notes

- The decisive check: her chin stays anchored while the station moves around it.
- A stationary ceiling with a freely bobbing head means the camera relationship is wrong.
- Avoid stabilizing the background in post; that would undo the intended effect.
- The exaggerated proportions should come from a fixed lens, not changing facial anatomy.
- Full-frame presentation is a working default; the user confirmed strong distortion
  and chin-following motion, but did not specifically select a circular border.
- Choose a segment with an audible breath, then carry the departure chime into shot 4.

## Take 1 feedback and take 2 revision

User review: camera placement works, but the chin moves while the station stays stationary. Take 1 is rejected for camera motion. Take 2 uses the same starting image, model, resolution, duration and disabled prompt expansion, with a shorter prompt that prioritizes fixed chin coordinates and moving background. No returned seed was available from take 1, so this is not a controlled same-seed comparison.

## Take 3 — different model, simple prompt

Kling 3.0 Standard, requested 3 seconds, native audio enabled, same approved v03 input. No resolution parameter is exposed by this endpoint; Standard is the selected tier. Negative prompt is empty to avoid its default distortion exclusion conflicting with the intended fisheye.

[Exact take 3 record](../videos/shot-03-take-03.generation.json). The user suspects prompt complexity caused the window artifacts; that cause has not been established.

## Take 4 — exact take 1 prompt on Kling

At the user's request, the current fenced prompt is copied verbatim from take 1. Kling 3.0 Standard, same starting image, 3 seconds, native audio enabled, empty negative prompt.

[Exact take 4 record](../videos/shot-03-take-04.generation.json).

[Watch take 4](../videos/shot-03-take-04.mp4). Rejected by the user: again starts running instead of continuous running.

## Current decision after take 4

Stop Kling tests for this shot. Both Kling takes start running and cost more.
H3 take 1 is the better baseline for continuous running, but its chin tracking
failed. All four takes remain rejected; no successful video is selected.
The fenced prompt above preserves take 4's exact input, not a proven solution.
