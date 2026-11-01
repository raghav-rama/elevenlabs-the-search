# AFTERHUMAN — Continuous narrated review v01

[Watch the 45-second review cut](afterhuman-continuous-with-david-v01.mp4) · [Listen to the exported full mix](afterhuman-continuous-with-david-v01.mix.wav)

**The user likes the assembled cut; production visual revisions remain pending.** Coffee reflex take remains locked. The latest feedback concerns product clarity, a consistent cyberpunk world and overhead quality. Seedance production is explicitly deferred due to cost. See [feedback and proposed next steps](production-feedback.md). Existing approved sources remain unchanged; no provider generation or credit spend in this review.

The cut retains the first three shots from the user's Final Cut opening, uses the locked continuous Seedance departure/transformation, omits the separate eye close-up, then proceeds through launch, intelligence, the complete coffee rescue, strength, speed, overhead race and a locally composed spiral/end card. Other prototype placements are not new source approvals.

## Picture timing

| Time | Picture |
|---|---|
| 0.000–6.083s | 01–03 — User FCP opening |
| 6.083–18.125s | 04–05 — Continuous Seedance departure and transformation |
| 18.125–19.375s | 07 — Station launch |
| 19.375–22.125s | 08 — Rooftop intelligence HUD |
| 22.125–32.250s | 09 — Coffee reflex rescue |
| 32.250–36.000s | 10 — Steel-door strength |
| 36.000–38.500s | 11 — Boulevard speed |
| 38.500–42.500s | 12 — Coastal train race |
| 42.500–45.000s | 13 — Spiral and AFTERHUMAN title |

All picture plays at original speed. The selected coffee take uses all 243 native picture frames. The source videos are preserved. The 1920×1080 / 24 fps review canvas includes native 480p footage scaled and center-filled; this does not create native HD detail.

## Voice and music

David's locked take supplies every line. Its complete decoded audio is used once across contiguous source sections, with quiet gaps added between whole phrases. “So upgrade” stays together with the original delivery and speed. Provider-linked timings and local low-energy checks guide cuts; no new voice synthesis or ASR was performed.

| Placed at | Line |
|---|---|
| 8.473s | Missed your train? Still running on flesh and blood? So upgrade. |
| 19.375s | Suddenly, everything clicks. |
| 23.750s | The world moves in slow motion. |
| 32.250s | Heavy lifting? Adorable. |
| 36.250s | And that train you missed? |
| 39.667s | It is trying to catch you now. |
| 42.375s | AFTERHUMAN. A step ahead. |

Chrome Swagger begins at **12.833s**, immediately after “upgrade,” aligned with the transformation onset. Existing music plays through the action gap, filters/quiets during the coffee slow motion, and its full 18-second cue restarts at **27.000s** around the catch, preserving its original ending at 45 seconds. This is a local arrangement of the selected track; no music generation or time stretching. Music rises between lines; native scene sound is crossfaded and ducked beneath narration.

## Checks and limits

- Exactly 45.000 seconds, 1,080 decoded frames, 24 fps; no near-black frames by the documented threshold.
- One stereo AAC track at 48 kHz; decoded sample peak approximately −1.50 dBFS. No full-scale samples in the arranged VO/music PCM.
- All scene, voice and music input hashes match saved provenance. Selected coffee and Seedance clips are preserved.
- Sampled-frame review confirms sequence and ending typography. No independent real-time playback/listening review; timing feel, source-audio speech content and the final mix remain listening-review items.
- The retained launch, HUD, steel doors, speed and overhead sources remain prototypes. The overhead lead is still visually weak; this assembly does not resolve that generation limitation.
- The local title/spiral treatment is an editorial proposal, not a separately approved final brand mark. Competition submission checks remain separate.

[Contact sheet](contact-sheet.jpg) · [Ending frame](last-picture-frame.png) · [Delivery/check record](delivery.json) · [Frame inspection](inspection.json)

## Reproduction

Run from repository root with unused output paths. These commands preserve sources and refuse to overwrite outputs:

```sh
python scripts/mix-ad-review.py assets/08-edit/continuous-ad-review-v01/soundtrack-config.json /private/tmp/afterhuman-review-soundtrack-new.wav
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/render-brand-outro.swift assets/06-shots/reviews/shot-12-overtake-coastal-minimax-startframe-v01/last-picture-frame.png /private/tmp/afterhuman-review-outro-new.mp4
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/08-edit/continuous-ad-review-v01/timeline.json /private/tmp/afterhuman-continuous-review-new.mp4
```

The last command uses the saved soundtrack/outro paths in the timeline. To rebuild all components into another directory, copy the timeline and update those paths to the newly generated files. Export bytes may vary with encoder metadata; timing and source ranges are recorded.

[Picture timeline](timeline.json) · [VO/music arrangement](soundtrack-config.json) · [Timing plan](timing-plan.json) · [Assembly report](afterhuman-continuous-with-david-v01.edit.json)
