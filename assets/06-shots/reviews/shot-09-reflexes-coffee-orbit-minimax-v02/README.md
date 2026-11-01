# Coffee reflexes — MiniMax circular-camera test

[Watch native video](../../videos/shot-09-reflexes-coffee-orbit-minimax-v02.mp4) · [Player](index.html) · [Contact sheet](contact-sheet.jpg)

**User rejected this prototype.** Passing order, upward cup motion and rescue distance need correction, beginning with the still reference.

One ten-second MiniMax H3 / 480p prototype, **3,030 credits / INR 44.00**. Output is 832×480, 24 fps, 243 frames / 10.125s; stereo AAC 32 kHz / 10.144s. No retries, upscale, re-edit or retime. User review pending; yesterday's locked MiniMax and accepted ad are preserved.

## What the test shows

The opening runs along the cyberpunk cafe sidewalk. A left-facing view reveals the airborne cup around 1.6s, followed by TPP around 2.6s. Camera travels around Riley and the city background through roughly 2.9–7.5s. Catch contact is visible around 3.5–3.75s; the orbit continues as she holds the cup. Handback occurs around 7.9–8.8s, then she runs away.

The circular effect is present, but the cup rises/floats before descending and is caught around waist height rather than near the pavement. Left-view and TPP changes read as angle cuts, not a continuous gaze-to-orbit move. Patron briefly appears holding the mug at the far left of the opening. Strongest orbit motion follows the catch. These are known prototype limitations, not accepted final choreography.

Approved wardrobe, Riley face and cafe v03 were connected as three image references. Yesterday's MiniMax was reviewed as a performance benchmark; its full video was not used as a provider input. No new stills were generated.

## Inspection and provenance

[Drop/transition](drop-transition-detail.jpg) · [Catch contact](catch-contact-detail.jpg) · [Review](review.json) · [Inspection](inspection.json) · [Native audio](native-audio.wav) · [Prompt](../../video-prompts/shot-09-reflexes-coffee-orbit-minimax-v02.txt) · [Generation record](../../videos/shot-09-reflexes-coffee-orbit-minimax-v02.generation.json)

Full decode found no near-black frames. Audio RMS -22.641 dBFS, peak -2.432 dBFS. Sampled frames and numerical audio checks do not establish full playback, independent listening or final mix approval. Generation ary0MpAozOyBi1tIWiKz, session D1ZLToBK3c6HzEAJhqWA. Exact schema, references/hashes, prompt, settings, quote and charged amount are saved in the generation record.

## Reproduce review outputs

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/reflexes-coffee-orbit-batch-v02.json
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/reflexes-coffee-orbit-batch-v02.json /private/tmp/afterhuman-coffee-orbit-player-new
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-reflexes-coffee-orbit-minimax-v02.mp4 /private/tmp/afterhuman-orbit-drop-new.jpg 1.25 0.125 13 3 640 360
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-reflexes-coffee-orbit-minimax-v02.mp4 /private/tmp/afterhuman-orbit-catch-new.jpg 3.25 0.125 9 3 640 360
```

Use unused output paths. These commands inspect existing media and make no generation calls.
