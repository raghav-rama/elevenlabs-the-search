# Coffee starting reference — distance correction

[Open corrected still](../../images/shot-09-coffee-city-start-v04.png) · [Previous still](../../images/shot-09-coffee-city-start-v03.png) · [Player](index.html)

Two GPT Image 2 low-quality / 1K edits through ElevenLabs, **504.235676 credits / INR 7.32 total**. v04 corrects starting distance (252.117838 credits); the targeted v05 cup-hand edit (another 252.117838 credits) did not make the requested changes. Native 1280×720, no upscale. v04 remains the review candidate; no new video generated.

The patron is now a smaller full-body figure farther ahead on the left, with clear paving before Riley reaches him. This corrects the immediate-foreground staging that encouraged passing him too early. Nearby pedestrians have been removed from the approach. The first-person hands and established cyberpunk cafe remain recognizable.

The mug is still held near his chest on the cafe side of his body. Before motion, its fall must be staged beside Riley within a normal bent-arm reach; moving the man away at the start does not by itself fix that. A background cup remains on the far-left cafe table. Distances in the prompt are art-direction targets, not calibrated measurements.

## Follow-up result

The [v05 prop edit](../../images/shot-09-coffee-city-start-v05.png) retains the original cafe-side mug hand and table cup. It is assistant-rejected for missing those requested changes; no third image or video was started. [Exact follow-up record](../../images/shot-09-coffee-city-start-v05.generation.json).

## Intended motion after the reference is settled

1. Riley advances normally along the sidewalk; the man remains ahead until she draws level.
2. At his side, she glances left. The hero cup is already separated from his empty hand and descending beside her, within reach. She has not passed and turned back.
3. Time dilates. Shift to TPP and orbit around the catch. The cup follows one downward path; it never rises, drifts across the sidewalk or touches the paving.
4. Continue the retained handback and departure story once the rescue reads clearly.

This still establishes an approach, not successful animation. Do not mark it or a future video approved from generation success. The earlier MiniMax orbit is rejected; yesterday's original locked MiniMax and accepted ad remain preserved.

[Exact prompt](../../prompts/shot-09-coffee-city-start-v04.txt) · [Generation record](../../images/shot-09-coffee-city-start-v04.generation.json) · [Batch](../../images/coffee-blocking-correction-batch-v04.json)

Generation HvzY1rLX6vjf9Vtp17Rp; session oiBNnZPVxdDhwjlzzzMX. Exact inputs, hashes, schema, settings, quote and charged amount are in the generation record.

Rebuild the local gallery without provider calls, using a fresh destination:

```sh
python3 scripts/build-startframe-gallery.py assets/06-shots/images/coffee-blocking-correction-batch-v04.json /private/tmp/afterhuman-coffee-blocking-player-new
```

User liked the approach composition and requested one visible running hand. See the [v06 single-hand revision](../coffee-running-hand-v06/README.md); this two-hand source remains preserved.
