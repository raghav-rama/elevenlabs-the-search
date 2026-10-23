# Shot 4 — take 7: H3 1080p reference regeneration

Status: rejected by user for facial likeness.

Endpoint: `minimax/h3-max/reference-to-video`. Three seconds, 16:9, 1080P, seed 20261016, prompt expansion disabled. Provider describes 1080P as latent refinement from native 768P. This is regeneration, not deterministic upscaling.

Video 1: accepted shot 4 take 6, unchanged source speed. Image 1: clean shot still. Image 2: canonical Riley portrait, resized to 512px JPEG for reference transfer. Inputs and URLs are in [the exact request](../videos/shot-04-take-07.input.json).

## Exact prompt

Recreate Video 1 as a three-second high-resolution shot, closely preserving its choreography, fast running pace, camera framing and event timing. Image 1 supplies the station and wardrobe design. Image 2 supplies Riley's exact facial identity: brunette bob, natural adult facial proportions and small mole beneath her anatomical left eye. Correct the distorted face in Video 1 using Image 2, keeping her identity consistent in profile and during the head turn, with natural skin and stable eyes, nose and mouth.

Follow Video 1's action at its original playback speed: Riley is already running quickly left to right at the first frame; the train doors close as she approaches. Preserve the rapid final steps and braking so she stops outside the closed door around 1.25 seconds. Then match the recovery breath and head/upper-body turn from Video 1 through the final frame. Keep the last second moving. Do not slow the run, start from rest, extend the approach or freeze the ending.

Keep the locked camera, white long-sleeved shirt, knee-length black skirt, sheer black tights, black block heels, burgundy KORVEX lanyard and black bag on her anatomical right shoulder. Preserve the graphite train, cyan stripes, carriage 07, yellow door lights and morning station lighting. Train remains stationary and Riley remains outside; no cuts or new people.

Audio: synchronized fast heel contacts, braking steps, closing-door motor and seal, train ambience and recovery breath. No speech, announcements, narration or music.

## Review requirements

Compare with the accepted source at equal playback speed; check motion timing, facial identity, frame-to-frame stability, badge text where applicable, and ending. Do not replace the selected source before user approval. Existing eight-second edit and soundtrack remain the production selection.

## Output

[Generated video](../videos/shot-04-take-07.mp4) — 1920×1080, 24 fps, 3.042 seconds.

- Sampled frames show approach, braking to a stop around 1.25 seconds and head turn around 2.0–2.375 seconds.
- Face is visible in profile and frontward at the ending; exact identity preservation needs playback review.
- Several ending poses are very similar; sampled frames alone do not establish whether the tail is frozen.

Frame sampling only; audio has not been listened to. Accepted source and edit remain selected.

## User feedback

Face still does not match Riley. Take rejected for facial likeness; no new pace verdict inferred. See the generation record for dated review history.
