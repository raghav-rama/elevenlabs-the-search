# AFTERHUMAN — Individual motion tests

[Play all five individually](index.html) · [ElevenLabs Flow](https://elevenlabs.io/app/flows/Po3Ew9qZ7xR4mOVZYC1Q)

Five new MiniMax H3 Max prototypes, one generation each. Requested 480p and 5 seconds; each native output is 832×480 at 24 fps, 124 video frames (5.167 seconds), with stereo AAC audio at 32 kHz. Audio track duration is 5.184 seconds. No black frames were found by the documented sampled-pixel check.

**Total reported cost: 7,575 credits / ₹109.989.** No retries, upscales, separate sound generations or edits to the native files. All five remain unselected pending your review.

| Shot | Native video | Main finding |
|---|---|---|
| 08 — Intelligence: route locked | [Play](../../videos/shot-08-intelligence-rooftop-minimax-startframe-v01.mp4) | A large cyan HUD stays visible. Amber routes fade and ROUTE LOCKED appears around 1.9 seconds, leaving one highlighted route. |
| 09 — Reflexes: phone catch | [Play](../../videos/shot-09-reflexes-cafe-minimax-startframe-v01.mp4) | One airborne phone ends in Riley's right hand; the stranger remains separate rather than directly handing it over. |
| 10 — Strength: steel doors | [Play](../../videos/shot-10-strength-steel-doors-minimax-startframe-v01.mp4) | Both hands grip the opposing door edges in first person. The panels visibly crease and buckle outward from roughly 1.9–3.0 seconds. |
| 11 — Speed: city sprint | [Play](../../videos/shot-11-speed-boulevard-minimax-startframe-v01.mp4) | Road markings, intersections and buildings move past the camera; the shot contains forward travel rather than only a static image with blur. |
| 12 — Overtake: coastal race | [Play](../../videos/shot-12-overtake-coastal-minimax-startframe-v01.mp4) | The train stays lengthwise on the rails. Riley and the train travel in the same direction while the coastline streams beneath them. |

## Review notes

### 08 — Intelligence: route locked

- A large cyan HUD stays visible. Amber routes fade and ROUTE LOCKED appears around 1.9 seconds, leaving one highlighted route.
- The rooftop view and natural hand remain stable through the sampled frames.
- Typography and thin HUD lines need production-resolution review. The lock pose holds for much of the ending, so the final edit may use a shorter range.

[Sampled frames](../shot-08-intelligence-rooftop-minimax-startframe-v01/contact-sheet.jpg) · [Review record](../shot-08-intelligence-rooftop-minimax-startframe-v01/review.json) · [Exact prompt](../../video-prompts/shot-08-intelligence-rooftop-minimax-startframe-v01.txt)

### 09 — Reflexes: phone catch

- One airborne phone ends in Riley's right hand; the stranger remains separate rather than directly handing it over.
- The phone initially rises on screen, then drifts toward the palm and is caught around 2.6–3.0 seconds.
- The initial rise reads more like a toss or float than a clean accidental drop.
- The hand and phone move too slowly together to clearly establish superhuman reflexes. The requested fast snap at 1–1.3 seconds did not land.
- This remains a motion test, not a solved reflex shot.

[Sampled frames](../shot-09-reflexes-cafe-minimax-startframe-v01/contact-sheet.jpg) · [Review record](../shot-09-reflexes-cafe-minimax-startframe-v01/review.json) · [Exact prompt](../../video-prompts/shot-09-reflexes-cafe-minimax-startframe-v01.txt)

### 10 — Strength: steel doors

- Both hands grip the opposing door edges in first person. The panels visibly crease and buckle outward from roughly 1.9–3.0 seconds.
- The deformed doors stay open; hands release near the end and the view advances into the corridor.
- The setup takes nearly two seconds before the major bend; final pacing should favor the decisive pull.
- Moving hand proportions and grip contact still need close playback review. No claim of frame-perfect anatomy.

[Sampled frames](../shot-10-strength-steel-doors-minimax-startframe-v01/contact-sheet.jpg) · [Review record](../shot-10-strength-steel-doors-minimax-startframe-v01/review.json) · [Exact prompt](../../video-prompts/shot-10-strength-steel-doors-minimax-startframe-v01.txt)

### 11 — Speed: city sprint

- Road markings, intersections and buildings move past the camera; the shot contains forward travel rather than only a static image with blur.
- Arms alternate in and out of frame, and cyan speed streaks build toward the end.
- The perceived speed and running rhythm need real-time playback against the music. Sampled frames do not establish a physical speed.
- Dense streaks dominate the ending; the final cut may need a shorter range and controlled effects.

[Sampled frames](../shot-11-speed-boulevard-minimax-startframe-v01/contact-sheet.jpg) · [Review record](../shot-11-speed-boulevard-minimax-startframe-v01/review.json) · [Exact prompt](../../video-prompts/shot-11-speed-boulevard-minimax-startframe-v01.txt)

### 12 — Overtake: coastal race

- The train stays lengthwise on the rails. Riley and the train travel in the same direction while the coastline streams beneath them.
- Riley gains relative to the train and reaches its nose near the end.
- The ending does not show a clear full-body pass with the requested three-body-length lead; only her upper body is marginally ahead of the nose.
- Riley drifts toward the rail-side boundary instead of keeping a consistent offset in the separate running lane.
- The tiny overhead figure cannot establish face, chrome detail or footfall quality.

[Sampled frames](../shot-12-overtake-coastal-minimax-startframe-v01/contact-sheet.jpg) · [Review record](../shot-12-overtake-coastal-minimax-startframe-v01/review.json) · [Exact prompt](../../video-prompts/shot-12-overtake-coastal-minimax-startframe-v01.txt)

## Sound and scope

The video prompts request HUD scan/lock sounds, filtered café ambience and a catch accent, metal strain/release/chime, sprint wind and a train pass. Audio decoded successfully and levels were measured; this does not establish that those requests were followed or that the tracks contain no speech. No independent listening review has been completed. The native sound is available in each player and as extracted WAVs in the per-shot review folders.

David narration, Chrome Swagger music, the accepted opening/transformation and the selected Riley/wardrobe references are unchanged. No final montage has been assembled from these prototypes. The earlier all-station videos and both boulder stills remain rejected.

## Reproduce the local review

Run from repository root. The media review helper preserves sources and skips existing derivatives. Give the gallery builder a fresh destination:

```sh
python scripts/review-pov-chase-prototypes.py assets/06-shots/videos/powers-startframe-motion-batch-v01.json
python scripts/build-startframe-gallery.py assets/06-shots/videos/powers-startframe-motion-batch-v01.json /private/tmp/afterhuman-motion-review-new
```

[Batch provenance and cost](../../videos/powers-startframe-motion-batch-v01.json). Exact inputs, settings, source/prompt hashes, request IDs and output hashes are saved in the adjacent generation records.
