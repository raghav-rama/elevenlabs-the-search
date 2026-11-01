# Shared-city still review v02

**Historical exploration.** The user authorized the fixes after this review. [Corrected six-image board v03](../city-continuity-stills-v03/index.html) now includes the coffee, strength and overhead repairs plus the matching end. The pending-choice wording below describes this earlier review state; the correction was subsequently authorized and completed.

[Open the image board](index.html) · [ElevenLabs Flow](https://elevenlabs.io/app/flows/3dGbKlj9VZitLDr91dyM) · [Batch, costs and provenance](../../images/city-continuity-stills-batch-v02.json)

The user approved six economical stills before production video: four ability starts plus an overhead start/end pair. Five images have been generated so far. The first overhead has reversed train direction, so the matching end is held rather than inheriting that error. A single targeted direction correction is prepared and quoted at 252.117838 credits / ₹3.660751, pending the user's answer because it adds an image beyond the six planned outputs.

| Image | Review |
|---|---|
| [Intelligence](../../images/shot-08-intelligence-city-start-v02.png) | Visible HUD, route and train target; station-city architecture carries through. Pending user review. |
| [Coffee](../../images/shot-09-coffee-city-start-v02.png) | Café now fits the city, but it has two mugs and a stranger resembling Riley. Mid-drop rather than pre-slip. Needs correction before motion. |
| [Strength](../../images/shot-10-strength-city-start-v02.png) | Clear first-person metal deformation, but doors are already bent. Useful action concept; not the requested nearly-closed start. |
| [Speed](../../images/shot-11-speed-city-start-v02.png) | Shared-city avenue, rail and foreground parallax cues. Hands need a better sprint pose; motion still untested. |
| [Overhead start](../../images/shot-12-overtake-city-start-v02.png) | Rails are aligned and Riley has a separate lane, but train nose points down while she runs up. Not suitable for animation. |

Native PNGs are 1280×720, GPT Image 2 via ElevenLabs, 16:9 / 1K / low, one take per node. Provider-reported total for the five completed images: **3,225.994595 credits / ₹46.841442**. No charge for the unrun correction or absent end frame. No paid retries, video generation, upscales or changes to the accepted edit.

The world reference is the actual ending frame of the approved continuous transformation, with linked approved gold wardrobe/body styling, portrait and train livery where relevant. Original station/train reference files and accepted footage remain intact. These are new concepts pending review, not replacements already inserted into the ad.

## Records

Each PNG has an adjacent `.generation.json` containing exact prompt, reference IDs/hashes, model settings, flow/node/session/generation IDs, cost, output hash and honest visual findings. Executed prompts end in `-run.txt`; the prepared design drafts remain unchanged. The unused correction prompt is `shot-12-overtake-city-start-v03.txt`.

The first intelligence still includes a generated HUD to make the capability visible during review. Before production animation, plan a clean scene plate plus separately controlled HUD lettering/tracking. A still does not establish motion speed, a successful catch or a completed train pass.

Rebuild the board from the batch into a new directory:

```sh
python3 scripts/build-startframe-gallery.py assets/06-shots/images/city-continuity-stills-batch-v02.json NEW_REVIEW_DIRECTORY
```

Seedance remains deferred. The next decision is the pending overhead correction; coffee and strength state fixes also need to be resolved before spending on their motion generations.
