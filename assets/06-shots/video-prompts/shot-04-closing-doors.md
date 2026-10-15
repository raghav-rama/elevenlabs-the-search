# Shot 04 — The wider reveal and missed train

Status: prompt ready for a first-frame test take. Optional ending-frame use needs
review because the existing anchor has minor door-panel differences.

## Inputs

- Starting frame: [shot-04a-v01.png](../images/shot-04a-v01.png).
- Optional ending anchor: [shot-04b-v01.png](../images/shot-04b-v01.png).
- Optional door-design reference: [train-01-v02.png](../../05-train/images/train-01-v02.png).
- Target edit segment: approximately 1–1.5 seconds showing closure and her stop.
- Generated test: [shot-04-take-01.mp4](../videos/shot-04-take-01.mp4).
- [Exact generation record](../videos/shot-04-take-01.generation.json): H3 Max Turbo, 480P, requested 3 seconds, prompt expansion disabled. Motion and audio review pending.

Use the starting image alone initially. Add the ending anchor only after resolving
its door-detail drift and checking the available first/last-frame controls. If an
ending image is supplied, treat it as the final pose and closed-door state, not a
reason to morph train geometry during closure.

## Ready-to-paste video prompt

```text
Animate the supplied wide platform image as one continuous photorealistic 16:9 shot. The normal-perspective camera holds its position and framing. Riley approaches from the LEFT toward the selected train doorway on the RIGHT. Keep the same original graphite train, cyan stripes, yellow door-frame lights, carriage 07 identifier, platform geometry, and diffuse 8:30 a.m. daylight.

As Riley takes her last hurried steps, the paired train doors slide inward toward their shared center seam. The two leaves move evenly and mechanically, retaining their exact windows, seals, materials, and width. They meet and close completely just before she can reach the entrance. Riley notices, shortens her stride, and stops on the platform short of the doorway. Her momentum settles naturally through her shoulders, bag, skirt, and lanyard. She catches her breath with restrained disappointment, looking at the shut doors. The train stays stationary during this shot.

Preserve the same Riley identity, white long-sleeved shirt, knee-length black skirt, sheer black tights, black block heels, burgundy KORVEX badge, and black bag on her anatomical RIGHT shoulder. Keep her feet grounded, her body scale consistent, and the target door in the same place. No hand in the door gap, track crossing, jump, superhuman movement, teleporting, premature boarding, sliding feet, new people, train departure, billboard reveal, camera zoom, cuts, or extra text.

Native sound: continue one departure warning chime, then the synchronized sliding-door motor and closing seal, Riley's final heel contacts slowing to a stop, slight bag and badge movement, and her breath in the same station ambience. After the doors shut, leave a short audible beat of breath and room tone. No music, narration, spoken line, or new announcement. Hold the closed-door state and her settled position briefly at the end.
```

## Selection and edit notes

- The edit must show a causal sequence: she approaches → doors close → she stops.
- Select enough of the actual closure to explain why she missed the train.
- Keep the last footfall and door contact distinct so the abrupt end of the run reads.
- Use the end anchor as a guide to the closing state, not proof of perfect geometry.
- The passenger reaction, departure, billboard, and “Fine” line belong to a later
  sequence and are not part of this four-shot batch.
