# MiniMax reference compatibility preparation

**Latest status (2026-11-02T00:02:52+05:30):** Corrected input accepted; generation `rRtNqFee9BOE2Gxzcltu` completed. [Result and comparison](../../reviews/coffee-minimax-ref-seedance-edit-v02/README.md). Earlier preparation-only notes below are historical. First failure refunded per explicit user confirmation; one retry cost12,502.0224 credits /₹181.53.

The first Seedance Video Edit request failed with: "Pixel count must be between 407696 and 8295044. Please adjust your input and try again." Its MiniMax source was832×480=399360 pixels.

[Prepared reference](shot-09-minimax-v04-reference-884x510.mp4) is884×510=450840 pixels, uniformly enlarged1.0625×. Same aspect, no crop/padding,192 frames,24fps,eight seconds, audio tracks retained. This is ordinary reference resizing, not generative enhancement or retiming. Original preferred footage unchanged. Source/output hashes and exact commands are in the preparation/verification records.

The failed attempt produced no output. Its provider record retains a12,502.0224-credit price; net charge/refund cannot be confirmed by the connector or visible failure panel. The corrected-input node is prepared and quoted at12,502.0224 credits / INR181.53 but **unrun**, pending explicit approval for an additional paid attempt. Its output remains480p. Face/wardrobe references and prompt are unchanged.

[Failed attempt](../../videos/shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v01.generation.json) · [Prepared attempt](../../videos/shot-09-coffee-tpp-minimax-ref-seedance-edit-480p-v02.generation.json) · [Verification](verification.json)

Reproduce from repository root, with a fresh output path:

```sh
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/resize-video-reference.swift assets/06-shots/videos/shot-09-coffee-tpp-orbit-minimax-v04.mp4 /private/tmp/coffee-reference-884x510-new.mp4 884 510
```
