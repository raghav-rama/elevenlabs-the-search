# First-person boulevard speed — Seedance 480p

Updated 2026-11-02T00:34:40+05:30. **User approved this take at 2026-11-02T00:39:22+05:30: “Looks good, continue.”** Final excerpt/mix remain editing decisions.

[Watch native video](../../videos/shot-11-speed-city-seedance-480p-v01.mp4) · [Video and approved still](index.html) · [Contact sheet](contact-sheet.jpg) · [Review](review.json) · [Inspection](inspection.json) · [Generation record](../../videos/shot-11-speed-city-seedance-480p-v01.generation.json) · [Verification](verification.json)

One five-second Seedance 2.5 take through ElevenLabs, using the approved city speed image as its sole start frame. Native output 854×480, 24fps, 121 picture frames/5.042s, stereo AAC 32kHz. No new image or retry. Original source media and accepted cut unchanged.

Sampled frames show actual foreground travel, approaching/passing skybridges, alternating hands and sustained motion into the ending. The daylight cyan/gold city remains coherent, and the train stays aligned with the left elevated track. Exact perceived superhuman speed, cadence, camera smoothness and independent train movement still need playback judgment. Cyan trails become prominent and small finger details are blurred.

The current speed slot is 2.5s at ad time 36.0–38.5s. The full native take is supplied for review; no final trim, retime or accepted-ad replacement was made.

Generation `ozRVXJ1A6BM28QNaLiE6`, session `BblzD2mNvNYSuEFkGtw2`, node `qnHd7DPaivpKNC9qXmoG` in [city flow](https://elevenlabs.io/app/flows/3dGbKlj9VZitLDr91dyM). Reported cost **6,511.470 credits / ₹94.55**, matching the live quote. Prompt, schema/guide, settings, input hashes, IDs and cost are saved alongside the output.

Full decode: no near-black frames. Decoded native audio RMS −23.677dBFS, peak −7.312dBFS. Audio measured only; no independent listening or speech-absence claim.

Reproduce local review from the repository root, with no generation:

```sh
python3 scripts/review-pov-chase-prototypes.py assets/06-shots/videos/city-speed-seedance-batch-v01.json
python3 scripts/build-startframe-gallery.py assets/06-shots/reviews/shot-11-speed-city-seedance-480p-v01/gallery-batch.json /private/tmp/speed-seedance-gallery-new
```

The inspector preserves existing artifacts; use a fresh gallery destination. Strength is user-approved. The station-launch replacement remains unrun in this production pass.
