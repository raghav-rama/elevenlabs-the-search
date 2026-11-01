# Coffee rescue — MiniMax fixed-start test v03

[Watch native take](../../videos/shot-09-reflexes-coffee-orbit-minimax-v03.mp4) · [Player](index.html) · [Overview](contact-sheet.jpg)

One ten-second MiniMax H3 / 480p generation, **3,030 credits / INR 44.00**. Native 832×480, 24 fps, 243 frames / 10.125s; stereo AAC 32 kHz / 10.144s. No retries, retime or upscale. Review candidate, not locked.

## What improved

The approved one-hand v06 image is the actual start_frame input. Riley approaches without first passing the man. Cup release around 2.3s is followed by a mainly downward path and a close low rescue, with catch contact around 6.5–6.75s. Handback and departure follow.

## What still misses the direction

- The man is visibly holding the mug when Riley looks toward him. TPP begins before the drop, so there is no FPP discovery of an already-airborne cup.
- Over-shoulder and low-side angle cuts replace the requested broad continuous orbit. Camera travel during the catch is limited.
- The third-person reveal changes the wardrobe to a longer gold dress and gold heeled sandals. Approved mini-dress, black-gold boots and exact facial cyberware are not preserved. MiniMax start-frame mode cannot combine identity reference images; textual description did not lock these details.
- The cup/slow-motion timing lingers and liquid drains out. Precise contact and empty-cup continuity need playback review.

This test improves approach and downward rescue but does not establish the full requested shot. The previous locked MiniMax and accepted ad remain unchanged.

## Evidence

[Glance/drop detail](glance-drop-detail.jpg) · [Catch contact](catch-contact-detail.jpg) · [Review criteria](review.json) · [Inspection](inspection.json) · [Native audio](native-audio.wav) · [Prompt](../../video-prompts/shot-09-reflexes-coffee-orbit-minimax-v03.txt) · [Generation record](../../videos/shot-09-reflexes-coffee-orbit-minimax-v03.generation.json)

Full decode: 243 frames, no near-black frames. Audio RMS -23.377 dBFS, peak -1.099 dBFS. Sampled visual inspection and numeric audio checks only; no independent listening or final sound approval. Generation NiVvrwfK6h9Vih4TJXmH / session 59azPRk7wO0kYlNqgywm. Exact input/settings/schema/guide, quote, charged amount and hashes are in the generation record.

## Reproduce review outputs

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/reflexes-coffee-orbit-batch-v03.json
python3 scripts/build-startframe-gallery.py assets/06-shots/videos/reflexes-coffee-orbit-batch-v03.json /private/tmp/afterhuman-coffee-fixed-start-new
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-reflexes-coffee-orbit-minimax-v03.mp4 /private/tmp/afterhuman-coffee-glance-new.jpg 1.5 0.125 13 3 640 360
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-reflexes-coffee-orbit-minimax-v03.mp4 /private/tmp/afterhuman-coffee-contact-new.jpg 5.75 0.125 9 3 640 360
```

Use fresh output paths. These inspect existing media without new provider calls.

Latest user feedback replaces the visible hold/release setup with a fast run, hidden accident, time dilation and TPP eye reaction before the orbit catch. See the [current direction](../../shot-09-coffee-hidden-drop-direction-v04.md).
