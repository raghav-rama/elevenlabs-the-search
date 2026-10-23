# Shot 2 — take 4: H3 1080p reference regeneration

Status: completed; pending user playback review.

Endpoint: `minimax/h3-max/reference-to-video`. Three seconds, 16:9, 1080P, seed 20261015, prompt expansion disabled. Provider describes 1080P as latent refinement from native 768P. This is regeneration, not deterministic upscaling.

Video 1: accepted shot 2 take 3, unchanged source speed. Image 1: clean shot still. Image 2: canonical Riley portrait, resized to 512px JPEG for reference transfer. Inputs and URLs are in [the exact request](../videos/shot-02-take-04.input.json).

## Exact prompt

Recreate Video 1 as a three-second high-resolution shot, closely matching its existing continuous fast badge bounce, small twists, framing and timing at the supplied playback speed. The running motion is already underway in the first frame and continues through the last frame; retain every bounce without a slow start or slow motion. The camera stays attached to the torso as in Video 1.

Image 1 is the clean badge and wardrobe appearance. Image 2 is Riley's face, to reproduce only as the flat printed photograph on this badge. Correct the distorted printed portrait in Video 1 using these images: the photograph remains a static, undistorted print fixed to the rigid card as it swings, with consistent eyes, nose, mouth and the small mole beneath her anatomical left eye. Keep the exact printed text 'KORVEX', 'Riley Brooks', 'EMPLOYEE', white shirt, burgundy lanyard, metal swivel clip, clear holder and cyan/magenta reflections from Image 1. Preserve Video 1's composition and moving lighting. No animated face inside the photograph, zoom, cuts or new objects.

Audio: soft train rumble, plastic badge taps and fabric movement only. No speech, narration, announcements, reading of names or music.

## Review requirements

Compare with the accepted source at equal playback speed; check motion timing, facial identity, frame-to-frame stability, badge text where applicable, and ending. Do not replace the selected source before user approval. Existing eight-second edit and soundtrack remain the production selection.

## Output

[Generated video](../videos/shot-02-take-04.mp4) — 1920×1080, 24 fps, 3.042 seconds.

- Printed portrait has recognizable facial detail in sampled frames.
- Printed name and EMPLOYEE lettering still warp in some samples, notably around 1.25 seconds.
- Badge continues bouncing and twisting; exact cadence preservation has not been established.

Frame sampling only; audio has not been listened to. Accepted source and edit remain selected.
