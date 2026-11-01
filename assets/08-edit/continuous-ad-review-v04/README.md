# AFTERHUMAN — Latest visuals review v04

[Watch the full cut](afterhuman-latest-visuals-v04.mp4) · [Player and chapter buttons](index.html) · [Overview](contact-sheet.jpg) · [Delivery/checks](delivery.json)

46.125 seconds,1107 frames at24fps,1920×1080 review canvas, stereo48kHz AAC. This combines the latest approved diagnostic/launch, HUD, strength, speed and overhead with the user-preferred MiniMax coffee action, locked David narration and Chrome Swagger. It is a new review export awaiting user playback/listening; previous45-second versions and all source files remain unchanged. No provider generation or credit spend.

## Picture and timing

| Review time | Scene | Native source frames, inclusive |
|---|---|---|
| 0.000–6.083s | 01–03 — Preserved user FCP opening | 0–145 |
| 6.083–12.833s | 04–05 — Missed train, departure and upgrade cue | 0–161 |
| 12.833–20.875s | 06–07 — Approved continuous diagnostic and launch | 0–192 |
| 20.875–23.625s | 08 — Approved tactical intelligence HUD | 6–71 |
| 23.625–25.667s | 09A — Fast FPP coffee approach | 23–71 |
| 25.667–33.625s | 09B — Preferred MiniMax airborne cup and orbit catch | 0–190 |
| 33.625–38.125s | 10 — Seedance steel-door strength | 12–119 |
| 38.125–40.625s | 11 — Seedance boulevard speed | 18–77 |
| 40.625–43.625s | 12 — Approved overhead overtake | 24–95 |
| 43.625–46.125s | 13 — Matching city spiral and product end card | 0–59 |

The first308 picture frames preserve the accepted opening through the upgrade cue. The full193-frame diagnostic/launch is used without removing its short pause. HUD frames6–71 and overhead24–95 are the exact approved ranges. Coffee keeps the existing49-frame FPP plus191-frame TPP sequence, including catch, handback and exit. The later Seedance coffee edit was not explicitly selected, so this uses the preferred MiniMax version.

Strength is a proposed original-speed0.5–5.0s excerpt retaining bent doors, hand release and forward travel. Boulevard speed uses a proposed0.75–3.25s excerpt. No source is sped up, slowed down or interpolated. The longer complete diagnostic sequence and retained door action result in a cut1.125s longer than v03. The existing spiral/title design was rendered from the approved city-overhead ending frame, replacing the old coastal image at the transition. [Overhead-to-outro check](overhead-outro-join.jpg).

The canvas scales mixed source resolutions, including480p. It is not an AI upscale or a claim of native1080p detail. Center-fill framing crops the small aspect-ratio differences as in previous reviews.

## Sound

David's source words, phrase boundaries, voice and speed are unchanged. Only pauses between intact phrases move to follow the new picture. The opening sentence and uninterrupted “So upgrade” stay at their previous times. Chrome Swagger enters immediately after upgrade at12.833s. Its full18-second section restarts at28.125s just after the visible coffee contact, ending with the brand card. The established music ducking and slow-motion low-pass effect are retained.

Native clip audio has conservative explicit gains and40ms half-crossfades, plus further−6dB ducking during narration. The generated diagnostic contributes its own native effects; the old local diagnostic-effects stem is not layered again. No new music, speech or sound effect generation. The final assembler peak guard applies about−0.925dB overall gain; decoded AAC sample peak is−1.434dBFS. These are numeric checks, not perceptual loudness certification or independent listening approval.

## Verification and remaining review

All1107 picture frames decode; no near-black frames. Duration,24fps,1080p canvas and one stereo audio track verified. Source hashes, exact approved ranges, whole diagnostic usage, narration source coverage and quote-free local work are recorded in [delivery.json](delivery.json). Sampled overview and the new overhead-to-spiral join visually checked. Browser loads and decodes the video with correct duration/dimensions and no media error. The temporary basic HTTP server did not support seeking, so chapter-seek playback was not certified there; direct local files or a range-capable media server are needed for that check.

User review should judge overall pace and sound balance, the diagnostic pause, small HUD/diagnostic text, coffee glance/slow reach, door material deformation and the relative sharpness of480p sources. This assembly does not imply final-master approval or approval of every previously noted source limitation.

## Reproduction

Run from the repo root with fresh output paths; helpers refuse overwrites. Re-rendering to a new folder requires copying `timeline.json` and `soundtrack-config.json`, then updating only paths of the derived mix/outro and preserving source ranges. No command below makes a provider request.

```sh
python3 scripts/mix-ad-review.py assets/08-edit/continuous-ad-review-v04/soundtrack-config.json /private/tmp/afterhuman-v04-mix-new.wav
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/render-brand-outro.swift assets/06-shots/reviews/shot-12-overtake-city-seedance-480p-v01/usable-range-v01/last-picture-frame.png /private/tmp/afterhuman-v04-outro-new.mp4 'CYBERNETIC IMPLANTS'
# This uses the already-created derived mix/outro at the paths in timeline.json.
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/assemble-continuation.swift assets/08-edit/continuous-ad-review-v04/timeline.json /private/tmp/afterhuman-v04-review-new.mp4
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache scripts/inspect-review-video.swift /private/tmp/afterhuman-v04-review-new.mp4 /private/tmp/afterhuman-v04-last-new.png /private/tmp/afterhuman-v04-inspection-new.json
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift /private/tmp/afterhuman-v04-review-new.mp4 /private/tmp/afterhuman-v04-overview-new.jpg 0 2 24 4 480 270
swift -suppress-warnings -module-cache-path /private/tmp/afterhuman-swift-cache assets/06-shots/reviews/extract-contact-sheet.swift /private/tmp/afterhuman-v04-review-new.mp4 /private/tmp/afterhuman-v04-outro-join-new.jpg 43.375 0.08333333333333333 12 4 480 270
```

[Timeline](timeline.json) · [Timing plan](timing-plan.json) · [Audio arrangement](soundtrack-config.json) · [Audio mix report](david-chrome-swagger-arranged-v04.mix.json) · [Export provenance](afterhuman-latest-visuals-v04.edit.json) · [Preserved assets](preserved-files.json)
