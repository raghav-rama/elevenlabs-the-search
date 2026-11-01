# Shot 09 — Coffee reflex test

[Play the native 10-second test](../../videos/shot-09-reflexes-coffee-fpp-tpp-minimax-v01.mp4) · [ElevenLabs Flow](https://elevenlabs.io/app/flows/J725xEy49QY4xa6L66pw)

MiniMax H3 via ElevenLabs; one 480p / 16:9 / 10-second request. Native 832×480, 24 fps, 243 frames / 10.125 seconds of picture, 10.144-second stereo AAC 32 kHz audio. Reported cost **3,030 credits / ₹43.9956**. No paid retries, variants, new stills or upscaling. **User-approved, selected and locked.** Earlier assistant observations below remain historical review evidence.

## What landed

- First-person sidewalk approach with pumping arms and visible forward parallax, followed by a third-person Riley reveal from the left around 1.4–1.8 seconds.
- A single mug becomes airborne and descends in slow motion. Riley crouches and catches it just above the pavement around 4.6–5.0 seconds, then raises it intact.
- She returns the mug around 6.3–7.8 seconds; the stranger visibly retains it when she turns and runs away.
- Third-person view stays near the stranger during her departure, with a cyan trail and real movement into the distance.

## What needs polish

- The initial mug release rises/flicks upward before descending, so it still reads partly as a toss rather than a clean slip-and-drop.
- The exit reads closer to a brisk run than an instantaneous super-speed launch. Trail alone does not solve the acceleration beat.
- The camera switches perspective, but Riley enters from the left rather than achieving a clearly demonstrated continuous orbit out of her eyes.
- The handback is legible, but the precise handle-first grip choreography differs from the prompt. Mug scale/perspective and hand contact need playback scrutiny.
- Gold dress, bob, boots and cyan body inlays are recognizable; facial chrome is less prominent and looks stylized at this resolution. Exact likeness is not approved.
- No independent real-time playback or listening review. Native sound decoded successfully; specific effects and absence of speech remain unverified.

[Full sampled sequence](contact-sheet.jpg) · [POV transition detail](pov-transition-detail.jpg) · [Review record](review.json) · [Native audio](native-audio.wav)

[Exact prompt](../../video-prompts/shot-09-reflexes-coffee-fpp-tpp-minimax-v01.txt) · [Generation provenance](../../videos/shot-09-reflexes-coffee-fpp-tpp-minimax-v01.generation.json) · [Single-shot batch](../../videos/reflexes-coffee-test-batch-v01.json)

Approved wardrobe is Image 1; approved Riley face/cyberware is Image 2. The earlier phone frame and station references were not used. Source images, previous videos and locked David/Chrome Swagger audio are preserved. This is an alternative reflex experiment, not a selected final shot.

## Reproduce local inspection

```sh
python scripts/review-pov-chase-prototypes.py assets/06-shots/videos/reflexes-coffee-test-batch-v01.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-reflexes-coffee-fpp-tpp-minimax-v01.mp4 /private/tmp/afterhuman-coffee-transition-new.jpg 1.125 0.0833333333 16 4 416 240
```

The batch requests 24 samples across ten seconds. Existing derivatives are preserved by the review helper; use a new filename for the detailed contact sheet. No source retiming or re-encoding.
