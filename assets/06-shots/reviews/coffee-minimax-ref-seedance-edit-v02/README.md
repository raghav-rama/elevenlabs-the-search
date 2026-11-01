# MiniMax-reference Seedance Video Edit comparison

Updated 2026-11-02T00:02:52+05:30. One authorized corrected-input retry completed; **pending user review**. Original MiniMax remains the preferred take.

[Compare native videos](index.html) · [New Seedance edit](../../videos/shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v02.mp4) · [Original MiniMax](../../videos/shot-09-coffee-tpp-orbit-minimax-v04.mp4) · [Generation record](../../videos/shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v02.generation.json) · [Detailed review](../shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v02/review.json) · [Overview](../shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v02/contact-sheet.jpg) · [Catch detail](../shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v02/catch-detail.jpg)

The edit closely follows the source action and camera arc in sampled frames, with stronger cyan eye/cheek treatment. Exact portrait likeness is not established; facial and neck hardware remain simplified. The slow reach and suspended-cup appearance persist. Contact is around1.75–2.0s; handback around5.1–6.1s; cyan-wake exit around6.4s onward. These are sampled estimates, not frame-accurate action marks.

Output is842×486,24fps,185 picture frames/7.709s, AAC stereo32kHz. The source is192 frames/eight seconds. The provider returned seven fewer frames despite the duration-preservation instruction; cause unverified. No local retiming, FPP replacement or accepted-ad edit. Comparison uses each native file at its original speed.

Successful generation `rRtNqFee9BOE2Gxzcltu`, session `xvOhIpV2ffsgD4cY9lsW`, model `bytedance-seedance-v2.5-edit`. One480p run cost12,502.0224 credits /₹181.53, matching the quote. The prior pixel-count failure was refunded according to the user's explicit confirmation; billing was not independently verified. No further generation or upscale.

[Input preparation](../../references/coffee-minimax-seedance-edit-v01/README.md) preserves the original192 frames and8s, with uniform884×510 scaling to pass the provider minimum. Approved face/wardrobe and exact prompt, inputs, settings, identifiers, output hashes and price are preserved in the generation record.

Full-frame decode passed with no near-black frames. Native audio decoded and measured at RMS−33.356dBFS, peak−11.443dBFS. Audio content/synchronization and continuous perceptual identity still require playback/listening review. No independent listening approval is claimed.

Reproduce local review from repository root (no provider call):

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/coffee-minimax-ref-seedance-edit-batch-v02.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/videos/shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v02.mp4 /private/tmp/coffee-edit-catch-review-new.jpg 1.5 0.125 9 3 640 370
python3 scripts/build-startframe-gallery.py assets/06-shots/reviews/coffee-minimax-ref-seedance-edit-v02/gallery-batch.json /private/tmp/coffee-seedance-edit-gallery-new
```

Use fresh output paths for the contact sheet/gallery helpers. The inspection helper preserves existing artifacts. [Verification](verification.json) records hashes and checks.
