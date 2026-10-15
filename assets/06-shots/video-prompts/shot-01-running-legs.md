# Shot 01 — Running legs

Status: takes 1–3 rejected for pace; take 4 tests constant quick short strides. Review the skirt hem against the wardrobe;
the current image shows it riding above the knee during the stride.

## Inputs

- Starting frame: [shot-01-v03.png](../images/shot-01-v03.png).
- Optional wardrobe reference: [wardrobe-01-v01.png](../../02-wardrobe/images/wardrobe-01-v01.png).
- Optional shoe/tights reference: [wardrobe-02-v01.png](../../02-wardrobe/images/wardrobe-02-v01.png).
- Target edit segment: approximately 0.65 seconds of clear ordinary running.
- Generated test: [shot-01-take-01.mp4](../videos/shot-01-take-01.mp4).
- [Exact generation record](../videos/shot-01-take-01.generation.json): H3 Max Turbo, 480P, requested 3 seconds, prompt expansion disabled. Motion and audio review pending.

## Ready-to-paste video prompt

```text
Side-on tracking close-up of the legs in the supplied image, already in a fast, steady run. This is a three-second excerpt from the middle of a longer run. The opening stride continues immediately with a quick push-off, and the same brisk tempo repeats evenly from beginning to end. Short, quick alternating steps; brief ground contact, immediate toe-off and rapid leg recovery. Keep a high step frequency with a short stride length, so the feet work quickly without the runner covering a huge distance. No slow opening, build-up, acceleration, speed ramp or final burst.

The camera stays beside her at shin height, travelling at exactly her constant forward speed. Her hips and legs remain centered at a constant size. The long stationary train extends beyond both sides of the frame for the entire shot; its carriage windows drift past at a steady, moderate rate. Never reach or reveal the train's front or rear. Keep the same tight crop, black skirt, sheer black tights, black block heels, realistic grounded steps and morning station lighting. One uninterrupted shot.

Only brisk synchronized footfalls, soft breathing and station ambience. No speech, narration or music.
```

## Selection and edit notes

- Select a section with a clear contact and forward swing; avoid a frozen-pose opening.
- Carry the footstep rhythm under shot 2 instead of audibly restarting the run.
- Reject shoe deformation, opaque tights, an obvious miniskirt, or foot sliding.
- The model's generated duration is separate from the final 0.65-second trim.

## Cadence revision

Take 1 rejected for slow running, approximately four steps in three seconds by user count. Target is approximately nine alternating footfalls in three seconds, matching shot 3. Take 2 tests legs first; badge and doors wait for cadence review. Final scene audio will use a shared speech-free effects track, rather than trusting prompt-only speech suppression. Exact take 1 prompt is preserved in its generation record.

[Watch take 2](../videos/shot-01-take-02.mp4) · [Exact generation record](../videos/shot-01-take-02.generation.json). Target cadence is a prompt instruction; actual footfall count remains unverified.

## Take 3 — qualitative sprint direction

User reports take 2 still takes four steps and explicitly rejects speed adjustment. No retimed preview was created. The current prompt describes an already ongoing urgent sprint, quick short steps, and immediate push-offs. Model, starting image, resolution, duration and prompt expansion setting are unchanged.

[Exact take 3 record](../videos/shot-01-take-03.generation.json).

[Watch take 3](../videos/shot-01-take-03.mp4). Generated and downloaded without retiming; cadence and audio review pending.

## Take 4 — constant cadence and controlled travel

User rejected take 3 for a slow start, acceleration and passing the train. Assistant inspected [24 sampled frames](../reviews/shot-01-take-03-contact-sheet.png): early stance persists across several samples; train end appears around 2.4 seconds. Removed sprint/urgency escalation cues. Current prompt separates fast leg cadence from forward distance using short strides, uniform camera travel and a train extending across the entire background.

[Exact take 4 record](../videos/shot-01-take-04.generation.json).

[Watch take 4](../videos/shot-01-take-04.mp4) · [Contact sheet](../reviews/shot-01-take-04-contact-sheet.png). Assistant review: train stays alongside; pace is more even, but the sampled sequence shows only about five new foot landings after the opening stance. Fails the nine-contact target. Audio unreviewed; user selection pending.

## Take 5 — approved video motion reference

Endpoint: `minimax/h3-max/reference-to-video`; 480P, three seconds, 16:9,
seed 20261015, prompt expansion disabled. Image 1 is shot-01-v03; Video 1 is
the user-approved `assets/references/prepared-running/running-rightward-3s-v02.mp4`.
Use the image as an appearance reference, without constraining the exact first
frame, to allow the video's initial gait phase. This is a single trial, not a
controlled comparison with prior Turbo I2V takes.

Exact submitted prompt:

```text
Use Image 1 for the commuter's appearance, black skirt, sheer black tights, black block heels, futuristic train, morning lighting and tight side-on legs composition. Use Video 1 only for the running motion and its timing. Transfer its continuous alternating leg cycles and foot-contact rhythm at the reference's supplied playback speed: approximately nine footfalls across three seconds. She is already running in the opening frame and continues the same steady cadence through the end.

She runs to the right along the platform. The camera tracks beside her at shin height, keeping her legs centered at a constant size. The long stationary train remains alongside; its windows pass behind her at a uniform moderate rate. Preserve the train and platform from Image 1. Render clean photorealistic footage without the reference video's colored tracking lines, treadmill, stands or laboratory background. One uninterrupted shot, no start-up, acceleration or cuts.

Audio: heel impacts and quiet station ambience only; no speech, narration or music.
```

[Exact take 5 record](../videos/shot-01-take-05.generation.json).

[Watch take 5](../videos/shot-01-take-05.mp4) · [Native-frame review](../reviews/shot-01-take-05-native-frames.jpg).
Assistant review: approximately seven new landings after the opening stance.
The gait is quicker than take 4 but still below nine contacts; the opening stance
persists before the first new landing. Train remains alongside and no source
tracking lines, treadmill or stand appear in reviewed frames. Audio unreviewed;
user selection pending. Generated output was not retimed.

Latest user decision: **take 5's picture is approved**. Only the quiet audio needs
changing. [Audio revision v01](../videos/shot-01-take-05-audio-v01.mp4) blends the
native shot-03 take-01 soundtrack beneath the original legs audio. All 73
compressed video frames and presentation timestamps are verified unchanged.
The added bed is the full source soundtrack, not an isolated train stem.
[Mix settings and verification](../videos/shot-01-take-05-audio-v01.audio-edit.json).
