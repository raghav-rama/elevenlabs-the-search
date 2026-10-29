# Train-departure correction — v02

The user authorized this correction after confirming that the train must start
moving when its doors finish closing. Preserve the existing hook, Riley design,
transformation, hand inspection, eye push and launch while correcting train motion.

Flow: https://elevenlabs.io/app/flows/A3IyZdzDXLKJFfEAS3R0

## Approach

- MiniMax H3 reference-video generation at native 768p, one take per affected shot.
- Shot 04 references the full selected Seedance video. Keep its arrival/door
  action; immediately accelerate the train screen-left at complete closure.
- Shot 05 references its original performance plus the corrected shot-04 ending.
  The actual output clears the nearby track earlier than planned: the train is
  already small in the left distance at the endpoint. Continue its recession
  without bringing carriages back beside Riley; preserve the clear track while
  she transforms and inspects her hands.
- Shot 06 references its original smirk/eye push plus the actual corrected
  shot-05 endpoint. The departed train must not reappear behind her.
- Shot 07 references its original launch plus the corrected wide from shot 05.
  Riley accelerates screen-left after the train; maintain the cleared background.
- Use reference_videos/reference_images mode throughout. Do not combine those
  ports with start_frame/end_frame. Read back effective parameters before running.

## Review and assembly

Preserve all original files and exact submitted prompts. Check door closure
against first train motion, direction, rigid carriage translation, consistent
background after departure, Riley identity/wardrobe and continuity across cuts.
Reference-video generation is not guaranteed to preserve pixels or exact timings.
Inspect outputs before choosing the preview cuts. Keep the original narration;
align its distinct So and UPGRADE to the actual correction's transformation onset.
Use new versioned takes and a separate preview directory; no Final Cut project edit.

This is a correction pass, not permission to redesign Riley, alter the four-shot
story, generate later montage content or perform a Seedance production pass.
Live estimates and provider-reported costs belong in each generation record.
