# Corrected shared-city stills

[Open the six-image board](index.html) · [ElevenLabs Flow](https://elevenlabs.io/app/flows/3dGbKlj9VZitLDr91dyM) · [Generation records and costs](../../images/city-continuity-corrections-batch-v03.json)

The user acknowledged the three errors and requested fixes. One targeted edit corrected each source, followed by the already-planned matching overhead ending. All four new results passed native still inspection. The user subsequently said “Looks good now,” approving the six displayed still compositions as references for the next motion pass. Motion testing remains pending.

| Composition | Result |
|---|---|
| [Intelligence](../../images/shot-08-intelligence-city-start-v02.png) | Existing visible HUD and shared-city terrace retained. |
| [Coffee](../../images/shot-09-coffee-city-start-v03.png) | One mug, upright in the patron's hand; duplicate and airborne splash removed. Patron is a distinct man. Hands are lowered before the catch. |
| [Strength](../../images/shot-10-strength-city-start-v03.png) | Straight, intact door leaves with a narrow starting gap. Earlier bent metal removed; both hands grip near the center. |
| [Speed](../../images/shot-11-speed-city-start-v02.png) | Existing avenue and foreground parallax cues retained. Sprint arm cadence remains a motion requirement. |
| [Overhead start](../../images/shot-12-overtake-city-start-v03.png) | Train and Riley face upward. She is behind its nose in a separate parallel lane. |
| [Overhead end](../../images/shot-12-overtake-city-end-v03.png) | Same heading and lane geometry; Riley's entire body clears the nose, including the trailing boot, with a visible gap. |

The overhead camera is intended to advance with the faster Riley, allowing the train to fall back within the frame while still traveling forward in the world. The two images establish the intended endpoints; they do not prove a coherent animated pass. Keep Riley's head in frame and preserve train/rail alignment throughout eventual motion.

## Cost and scope

GPT Image 2 via ElevenLabs, native 1280×720, 16:9 / 1K / low, exactly one output per correction and one ending. Three corrections cost 756.353514 credits / ₹10.982253; the end costs 252.117838 credits / ₹3.660751. **Total new spend: 1,008.471351 credits / ₹14.643004.** Actual provider prices matched the estimates.

The board displays six compositions: four new images and two retained images. The complete city exploration has nine generated images including the three preserved erroneous originals. Cumulative spend is 4,234.465946 credits / approximately ₹61.48. No video generation, upscale, new voice/music, Final Cut change or modification to the approved cut.

## Provenance and review

- [Review selection/index](review-batch.json) identifies the six user-approved still references.
- Each new PNG has an adjacent `.generation.json` with exact prompt, input source/hash, effective settings, node/session/generation IDs, cost, output hash and review findings.
- [Previous board](../city-continuity-stills-v02/index.html) and all original images remain available for comparison.
- The intelligence HUD is baked into its concept still; plan the final graphic layers before animation. The coffee camera transition/catch and strength deformation remain untested in these new settings.

Rebuild this board from the repository root into an unused output directory:

```sh
python3 scripts/build-startframe-gallery.py assets/06-shots/reviews/city-continuity-stills-v03/review-batch.json NEW_REVIEW_DIRECTORY
```

Production Seedance remains deferred. The six stills are now approved references; starting paid video generation requires the next production instruction.
