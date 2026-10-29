# Riley upgrades — transformation, eyes and launch

The train-departure requirement now has a [v02 correction pass](shot-04-07-train-departure-correction-v02.md)
and [assembled preview](../../08-edit/transformation-sequence-v02/README.md), pending user review.
The v01 generation history and cue rationale below remain preserved.

The user's latest direction replaces the earlier hard-cut-only reveal. Continue
from the **full** selected Seedance shot four, visibly transform Riley, let her
inspect her hands, push into her eyes as she smirks, then launch at superhuman
speed. MiniMax is the prototype model; no Seedance production pass is implied.

## Required train-departure correction — 2026-10-29

The user requires the train to start moving when the doors close. In the next
polish pass, the doors finish shutting, then the train immediately begins pulling
away and accelerates smoothly during Riley's reaction and the narration. Maintain
its travel direction and progress through the transformation, eye push and launch:
carriages keep passing until the tail clears, then the track/background stays
clear. Do not reset the same carriage beside Riley at a cut. Riley's later chase
must follow the train's established screen direction.

This correction starts in shot four and carries through shots 05–07. Preserve the
original Seedance source and existing prototypes as records; prepare corrected
shot coverage and reference frames for the next version. The old station stills
and endpoints cannot be reused unchanged if they would pin the train in place.
Departure motor/rail sound should rise with acceleration and recede with distance,
while narration stays clear.

The submitted v01 transformation and launch prompts explicitly requested a
stationary train; that direction is superseded. Keep those exact historical
prompts and generation records intact. The timings below describe the existing
v01 assembly, not a lock on the corrected edit. The subsequent v02 correction
pass is linked above; v01 itself is preserved unchanged.

## Source and cue placement

- Keep frames 0–145 of the user's Final Cut opening (first three shots).
- Follow with all 121 picture frames of `shot-04-elevenlabs-seedance-v01.mp4`.
  This is a new review assembly; both original files stay unchanged.
- The full source's final sample is at 5.000 seconds. The transformation starts
  from that extracted image, at preview frame 267 / 11.125 seconds.
- Start the existing narration at preview frame 189 / 7.875 seconds, equivalent
  to 1.791667 seconds into full shot four. “Missed” begins around source 1.972s.
- “So” starts at 11.595 seconds. **“UPGRADE” starts at frame 297 / 12.375 seconds
  (00:00:12:09 at 24 fps)**, 1.25 seconds into the transformation clip.
- This is five frames earlier than the initial placement because sampled output
  starts changing its facial surface around 1.2–1.3 seconds. No source retiming.
  The original VO is preserved; word timing is automated, with listening review
  still needed. The old 3.416667-second reaction-extension proposal is superseded.

## Three generated beats

| Beat | Requested generation | Purpose and continuity |
|---|---|---|
| 05: transformation and hands | MiniMax H3, 768p, 6 seconds | Full shot-four final frame → existing upgraded station frame. Traveling surface wave, then look at hands and lower them. |
| 06: smirk and eye push | MiniMax H3, 768p, 5 seconds | Actual shot-05 ending → selected-identity extreme-eye endpoint. Smirk reads before the mouth leaves frame. |
| 07: speed launch | MiniMax H3, 768p, 5 seconds | Return to station wide. Turn, load the rear foot, accelerate screen-left along the platform, leave frame. |

Exact prompts are in the three adjacent `shot-0*-*-minimax-v01.txt` files;
original videos and generation records are in `../videos/`. Flow:
https://elevenlabs.io/app/flows/1KlNu0Dsak5777WphodD

The hand endpoint image had outward palms and excessive surprise, so it was
archived as unsuitable and never used to guide a video. The neutral upgraded
frame instead anchors the finished body/outfit, while hand inspection is directed
inside shot 05. The eye endpoint is a new inexpensive Nano Banana image.

## Design and effect rules

Preserve Riley concept 3's face, cyan eye/hardware on viewer right and brown eye
on viewer left. Preserve wardrobe 05-v02: gold wrap dress, existing black/gold
boots, human limbs and sparse chrome inlays. No fully metal limbs or mirrored
implants. Bag and badge disappear as part of the transforming surface.

The supplied Mystique image guides a traveling surface change; it does not
introduce blue skin, a weapon, a different face or costume. The second user image
guides extreme eye framing. Both originals and provenance are archived in
`assets/06-shots/references/upgrade-transformation/`.

The prototype transformation produces gold microtiles/pixels rather than literal
biological scales. Boots finish relatively late. The launch trail blooms strongly
and rear dress details are newly invented. These are review limitations to assess
before production; the new takes are not user-selected masters.

## Preview assembly

Use `scripts/assemble-continuation.swift` and the timeline under
`assets/08-edit/transformation-sequence-v01/`. Preserve original playback speed,
trim unneeded holds, conform the native 1344x768 clips to the 1920x1080 canvas,
crossfade native sound at cuts, and duck it under the existing narration.
Original files remain untouched. No Final Cut project is edited.

The intelligence/HUD demonstration, reflexes, strength, train overtake, spiral,
branding and original jingle still follow this continuation. The eye glow in this
test does not itself demonstrate intelligence or settle the HUD design.
