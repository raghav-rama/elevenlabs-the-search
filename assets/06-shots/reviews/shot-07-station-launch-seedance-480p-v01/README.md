# Station launch from the approved upgrade ending

Updated 2026-11-02T00:46:20+05:30. **Pending user review; launch timing only partially meets the prompt.**

[Watch diagnostic → launch](context-review-v01/diagnostic-to-launch-v01.mp4) · [Native take](../../videos/shot-07-station-launch-seedance-480p-v01.mp4) · [Review player](index.html) · [Native overview](contact-sheet.jpg) · [Join detail](context-review-v01/join-detail.jpg) · [Review](review.json) · [Generation record](../../videos/shot-07-station-launch-seedance-480p-v01.generation.json) · [Verification](verification.json)

The existing final frame from the approved continuous Seedance transformation supplies the starting pose, character and empty-track station. It closely matches the diagnostic return endpoint. No new still generated and no use of the older MiniMax station background.

One five-second Seedance2.5 take at480p: native854×480,24fps,121 picture frames/5.042s. Riley turns and runs screen left and away along the platform, with a narrow cyan/magenta wake. Train remains absent. Appearance and broad geography match the starting frame in sampled views.

**Timing limitation:** running starts around2.2–2.5s, much later than the requested0.5s. She is still visible in the distance at the ending. The prompt's1.8s exit and empty-platform hold were not achieved. The existing launch slot is1.25s; a final timing/trim decision is needed. No local speed change or extra generation was applied to hide this.

The context clip joins the final24 diagnostic frames (103–126) to all121 new frames,145 total/6.0417s, original speed. First second is intentionally silent context; native launch audio follows at0dB with short edge fades. The1080p diagnostic is fitted to854×480 for this review. The accepted45s ad, David VO and Chrome Swagger mix remain unchanged.

Generation `V4MVm01Dprm02tEwE8AP`, session `T3nBw6ue3LlWhg7pkTkm`, node `XwPL8xZX94fJf91vnq2e` in [city flow](https://elevenlabs.io/app/flows/3dGbKlj9VZitLDr91dyM). Reported cost6,511.470 credits /₹94.55 matches the live quote. One generation, no retry, variant, new image or upscale.

Native and context decode checks found no near-black frames. Native audio RMS−25.553dBFS/peak−4.519dBFS; context AAC peak−4.532dBFS. Numeric checks only; no independent listening or dialogue-absence approval. Fine identity, foot contacts and full-speed impact require playback review.

Reproduce from repo root with fresh output paths (no provider call):

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/city-station-launch-seedance-batch-v01.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/06-shots/reviews/shot-07-station-launch-seedance-480p-v01/context-review-v01/timeline.json /private/tmp/diagnostic-to-launch-new.mp4
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift assets/06-shots/reviews/shot-07-station-launch-seedance-480p-v01/context-review-v01/diagnostic-to-launch-v01.mp4 /private/tmp/launch-join-detail-new.jpg 0.5 0.125 9 3 640 360
python3 scripts/build-startframe-gallery.py assets/06-shots/reviews/shot-07-station-launch-seedance-480p-v01/gallery-batch.json /private/tmp/station-launch-gallery-new
```

Native/provenance/verification files remain linked above; context timeline, edit record, inspection and decoded-audio analysis are in `context-review-v01/`. All planned replacement shot types have now been generated; pending take choices and final assembly remain.

## User comparison update

The user prefers the original MiniMax launch `shot-07-speed-launch-departure-minimax-v02.mp4`. This Seedance station-launch v01 remains preserved but is not selected. A new continuous diagnostic-and-launch test is authorized using the two actual reference videos; see `assets/06-shots/videos/diagnostic-launch-seedance-batch-v01.json`.
