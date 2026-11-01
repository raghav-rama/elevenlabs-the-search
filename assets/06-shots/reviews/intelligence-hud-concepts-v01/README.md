# Rich ocular HUD concepts

[Open comparison gallery](index.html) · [Original sparse HUD](../../images/shot-08-intelligence-city-start-v02.png)

**C selected by the user.** A and B remain available as alternatives. User requests more items and an Iron Man-like ocular interface. Native 1280×720, GPT Image 2 via ElevenLabs, 16:9 / 1K / low, one image per direction.

**Actual total: 756.353514 credits / INR 10.98.** Each cost 252.117838 credits. No retry, video, upscale or audio generation. Supplied image was verified pixel-identical to the existing city still and reused without a duplicate upload.

## A — Predictive pursuit HUD

[Open native image](../../images/shot-08-hud-a-predictive-v01.png)

- Three route options with a highlighted cyan winner make the prediction decision easy to find.
- Train data, intercept timing/confidence, neural waveform and four power-readiness indicators add useful density.
- Central train and ramp remain readable; hand pose and scene composition visually follow the source.

Polish/limits:
- Tiny bearing/range typography and some object-label anchors need cleanup.
- Peripheral treatment slightly darkens the source.
- The least dense option; weaker in the requested immersive helmet-HUD feel.

## B — Neural systems HUD

[Open native image](../../images/shot-08-hud-b-neural-v01.png)

- Circular wireframe brain plus neural load, latency and synapse readouts make enhanced intelligence visually explicit.
- Body telemetry, large route map, three-route comparison and subsystem bars provide rich peripheral information.
- Natural hand and city/train/route composition closely follow the source.

Polish/limits:
- Small NEURAL LINK/brain lettering is visibly garbled; exact text must be rebuilt after selection.
- Peripheral panels darken the edges and some traces overlap the hand.
- Static concept only: tracking, animation and short-shot legibility remain untested.

## C — Full tactical perception HUD

[Open native image](../../images/shot-08-hud-c-tactical-v01.png)

- Closest to the requested Iron Man-like density: neural-core ring, waveform, circular radar and segmented gauges.
- Body diagnostics, scene annotations, intercept readouts, processing log and four ability dials fill the periphery.
- Central train and cyan ramp stay readable; hand and scene geometry visually follow the original.

Polish/limits:
- Several tiny captions/status words are malformed; duplicate headers and lower-edge clutter need simplification.
- Busy peripheral framing darkens the scene slightly.
- Most demanding option for readable animation at 480p; selective emphasis and exact editorial labels will be needed.

## Selection and next step

User selected **C — Full tactical perception HUD** on 2026-11-01T20:32:38+05:30. This locks the HUD direction. Small labels, duplicate headings and object anchors still need cleanup before preparing the replacement intelligence video. No new generation was run for this selection.

Approved overhead trim and current 45-second cut are untouched. Generated backgrounds visually match the original composition but are not claimed pixel-identical.

[Batch and generation IDs](../../images/intelligence-hud-concepts-batch-v01.json). Exact prompts are in ../../prompts/ and adjacent generation records retain inputs, settings, hashes and prices.

## Reproduce gallery

Run from repository root with a fresh destination:

```sh
python3 scripts/build-startframe-gallery.py assets/06-shots/images/intelligence-hud-concepts-batch-v01.json /private/tmp/afterhuman-hud-concepts-new
```

## Selected C continuation

User authorized continuing. [Typography-polished derivative](../../images/shot-08-hud-c-tactical-v02.png) and [one Seedance replacement video](../shot-08-intelligence-city-seedance-480p-v02/index.html) are ready. C remains the selected direction; the new video is pending review. Details and limits are in the linked take notes.
