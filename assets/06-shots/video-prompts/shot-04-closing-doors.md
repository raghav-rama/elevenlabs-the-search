# Shot 04 — The wider reveal and missed train

Status: the user says take 1 looks fine, superseding its earlier rejection.
One additional variation, take 2, is generated for comparison. Optional ending-frame
use still needs review because the existing anchor has minor door-panel differences.

## Inputs

- Starting frame: [shot-04a-v01.png](../images/shot-04a-v01.png).
- Optional ending anchor: [shot-04b-v01.png](../images/shot-04b-v01.png).
- Optional door-design reference: [train-01-v02.png](../../05-train/images/train-01-v02.png).
- Target edit segment: approximately 1–1.5 seconds showing closure and her stop.
- Generated test: [shot-04-take-01.mp4](../videos/shot-04-take-01.mp4).
- [Exact generation record](../videos/shot-04-take-01.generation.json): H3 Max Turbo, 480P, requested 3 seconds, prompt expansion disabled. User accepts take 1; take 2 awaits review.

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

## Take 2 variation

[Take 2](../videos/shot-04-take-02.mp4) uses the same prompt and starting frame
as take 1, H3 Max Turbo, 480P, three seconds, expansion disabled, seed 20261016.
No ending image, motion reference, or target audio was added.
[Exact generation record](../videos/shot-04-take-02.generation.json).

Take 2 sampled review: doors close before she reaches them and she stops
outside. Approach becomes walking-like and overhead signs change to red;
full-speed pace, audio and user comparison remain pending.

## Take 3 — fast-paced prompt revision

User rejected take 2 as feeling like slow motion. Keep the same image, endpoint,
480P, three seconds, seed 20261016 and disabled expansion; revise only the prompt.
[Generation record](../videos/shot-04-take-03.generation.json).

```text
Play this shot at normal real-time speed with urgent, fast-paced running. Animate the supplied wide platform image as one continuous photorealistic 16:9 shot. The normal-perspective camera holds its position and framing. Riley approaches from the LEFT toward the selected train doorway on the RIGHT. Keep the same original graphite train, cyan stripes, yellow door-frame lights, carriage 07 identifier, platform geometry, and diffuse 8:30 a.m. daylight.

Riley is already running fast in the opening frame, with a forward lean, quick arm drive and rapid alternating foot contacts, roughly three contacts per second during the approach. She covers the distance to the doorway briskly in the first half of the shot. Keep her feet cycling quickly all the way to the final braking steps; no walking, slow motion, floating strides, gradual acceleration or prolonged easing into a stop. Meanwhile the paired doors slide inward promptly and seal just before she reaches the entrance. Only then does she plant her feet in a quick controlled stop outside the closed doorway. Her bag and lanyard follow through briefly as she catches her breath and looks at the shut doors. The action is a fast approach followed by a brief stationary reaction, not a slow approach stretched across the clip. The train stays stationary, and the doors retain their original geometry.

Preserve the same Riley identity, white long-sleeved shirt, knee-length black skirt, sheer black tights, black block heels, burgundy KORVEX badge, and black bag on her anatomical RIGHT shoulder. Keep her feet grounded, her body scale consistent, and the target door in the same place. No hand in the door gap, track crossing, jump, superhuman movement, teleporting, premature boarding, sliding feet, new people, train departure, billboard reveal, camera zoom, cuts, or extra text.

Native sound: continue one departure warning chime, then the synchronized sliding-door motor and closing seal, Riley's rapid, closely spaced running heel contacts ending with quick braking steps, slight bag and badge movement, and her breath in the same station ambience. After the doors shut, leave a short audible beat of breath and room tone. No music, narration, spoken line, or new announcement. Hold the closed-door state and her settled position briefly at the end.
```

Take 3 completed: [video](../videos/shot-04-take-03.mp4), [generation record](../videos/shot-04-take-03.generation.json). Initial frame review still shows several easing steps before stopping; user review pending. Native audio has not been listened to.

## Take 4 — approved 2x motion reference

Model: `minimax/h3-max/reference-to-video`; 480P, 16:9, two seconds, seed 20261016, prompt expansion disabled. Video 1 is the approved 2x edit, extended only with a final-frame hold to meet the two-second reference minimum; audio removed from the reference. Image 1 is the original shot-04a still.

```text
Use Video 1 as the motion and timing reference at its supplied playback speed. Match its brisk running approach, quick braking steps and doors closing just before Riley arrives. Use Image 1 for Riley's identity and wardrobe, the original graphite train with cyan stripes and carriage 07, the platform geometry and diffuse 8:30 a.m. light.

One continuous locked-off wide shot. Riley is already running from LEFT to RIGHT in the opening frame. Follow Video 1's rapid leg cycle and body travel without slowing down or stretching the approach across the whole clip. The doors close during her approach; by about 1.25 seconds she has stopped outside the shut doorway. Spend the remaining time on her small natural breathing reaction, looking at the closed doors. The train remains stationary. Keep the same framing, grounded feet and original door geometry, with no boarding, hand in the gap, camera movement or cuts.

Preserve Riley's white long-sleeved shirt, knee-length black skirt, sheer black tights, black block heels, burgundy KORVEX lanyard and black bag on her anatomical RIGHT shoulder. Keep station displays consistent with Image 1. The final still frames in Video 1 represent a settled pose, not a freeze effect: allow only subtle breathing there.

Audio: rapid synchronized heel contacts followed by a short braking shuffle, a brief door warning chime, sliding-door motor and seal, quiet train rumble and Riley's breath. No speech, narration, announcement, badge reading or music.
```

Take 4 completed: [video](../videos/shot-04-take-04.mp4), [generation record](../videos/shot-04-take-04.generation.json). Frame review shows the model stretched the approach despite the reference. Approval and listening review pending; the approved 2x edit remains selected.

## Take 5 — three seconds with approved fast approach timing

H3 Max reference-to-video, 480P, three seconds, 16:9, seed 20261016, prompt expansion disabled. Motion reference is a three-second, 24 fps copy of the approved 2x edit: original playback timing, final pose held for the remaining interval, silent.

```text
Recreate Video 1 as a three-second shot with the SAME real-time movement speed and event timing. Video 1 is the authoritative motion reference. Image 1 supplies Riley's appearance and the station design. The fast approach occupies only the opening portion; most of the shot is the stopped reaction.

Timing: 0.00-0.65 seconds: Riley is already running quickly from LEFT to RIGHT, matching Video 1's rapid leg cycle, arm drive and distance covered. The stationary train's doors slide shut just before she arrives. 0.65-1.25 seconds: match Video 1's quick final braking steps and settle outside the closed doorway. 1.25-3.00 seconds: her feet stay planted at the doorway. She catches her breath and looks at the shut doors, with a small natural shoulder movement and bag settling. Keep this reaction interval; do not spend it on more approach steps. No slow motion, speed ramp, slow start, or stretching the run over three seconds. Preserve Video 1's playback timing without halving the movement speed.

One continuous locked-off wide shot with the same framing. Preserve Riley's white long-sleeved shirt, knee-length black skirt, sheer black tights, black block heels, burgundy KORVEX lanyard, and black bag on her anatomical RIGHT shoulder. Preserve the graphite train, cyan stripes, carriage 07, yellow door lights, platform and 8:30 a.m. daylight. Train stays still, doors stay closed after sealing, Riley stays outside. Grounded feet, no camera movement, cuts, boarding, new people or changing displays. The reference's ending hold should become a natural stationary breathing reaction.

Audio: quick synchronized running heel contacts and braking steps in the opening 1.25 seconds, door warning chime, sliding motor and seal, then quiet station/train rumble and her breath. No speech, narration, announcements, badge reading or music.
```

Take 5 completed: [video](../videos/shot-04-take-05.mp4), [generation record](../videos/shot-04-take-05.generation.json). Three seconds requested, 3.042 seconds returned. Sampled frames closely match the approved fast reference, finishing the run/braking around 1.25 seconds. Ending is nearly still; user playback and audio review pending. No generated-output retiming.

## Take 6 — preserve fast approach, animate final reaction

H3 Max reference-to-video, 480P, three seconds, 16:9, seed 20261016, prompt expansion disabled. The reference is now its first two seconds at 24 fps; motion timing through the stop is unchanged. New direction explicitly overrides held frames with a recovery breath and continuing head turn.

```text
Create one continuous three-second shot. Match Video 1's fast approach and braking timing ONLY through 1.25 seconds; then continue into a clearly moving live-action reaction through the final frame. Image 1 supplies Riley's appearance and the station design. The still tail of Video 1 is reference padding: replace it with the moving reaction described below.

0.00-0.65 seconds: Riley is already running quickly from LEFT to RIGHT, matching Video 1's rapid leg cycle, arm drive and distance covered. The stationary train's doors slide shut just before she arrives. 0.65-1.25 seconds: match Video 1's quick final braking steps and stop outside the closed doorway. Preserve this pace without slowing down, starting from rest or stretching the run across the clip.

1.25-2.00 seconds: with her feet planted, Riley takes a visible recovery breath; her shoulders and upper chest rise, her elbows relax, and the bag swings once with the stopping momentum. 2.00-3.00 seconds: she exhales, visibly lowers her shoulders and slowly turns her head about fifteen degrees to her left, away from the shut door, with a small disappointed expression. Her hair and lanyard settle during this movement. The head turn is still finishing at the last frame. Her body and face continue moving throughout the final second. This is live action after stopping: no frozen frame, still-image hold, repeated-frame tail, pause or loop. Keep her feet in place after 1.25 seconds and generate new upper-body motion instead of further approach steps.

Locked-off wide camera, same framing. Preserve Riley's white long-sleeved shirt, knee-length black skirt, sheer black tights, black block heels, burgundy KORVEX lanyard, and black bag on her anatomical RIGHT shoulder. Preserve the graphite train, cyan stripes, carriage 07, yellow door lights, platform and 8:30 a.m. daylight. Train stays still, doors stay closed after sealing, Riley stays outside. No camera movement, cuts, boarding, new people or changing displays.

Audio: quick synchronized running heel contacts and braking steps in the opening 1.25 seconds, door warning chime, sliding motor and seal, then quiet station/train rumble, an audible recovery breath and soft bag/fabric movement. No speech, narration, announcements, badge reading or music.
```

Take 6 completed: [video](../videos/shot-04-take-06.mp4), [record](../videos/shot-04-take-06.generation.json). Frame review retains the fast approach and now shows a head/upper-body turn during the last second. Turn is larger than requested; near-static interval before it remains. User playback and audio review pending.
