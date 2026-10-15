# Four-shot opening — video prompts

Motion-control research (2026-10-15): see the [evidence and proposed next tests](../../../research/video-motion-control-2026-10-15.md)
for motion-reference conditioning, chin stabilization, and speech-free audio.
Those were research recommendations; the later user-authorized motion-reference test
is now [shot 1 take 5](../videos/shot-01-take-05.mp4), using H3 Max Reference to Video.
The user approved take 5's picture despite the assistant's approximately seven-contact
count. Only audio needed changing. [Audio revision v01](../videos/shot-01-take-05-audio-v01.mp4)
adds shot-03 take 1's native soundtrack beneath the legs audio; its picture is unchanged.
The audio revision awaits user listening review.

Video generation now uses fal.ai. The first shot-3 test is complete using
`minimax/h3-max-turbo/image-to-video`, 480P, requested duration 3 seconds,
with prompt expansion disabled. [Watch take 1](../videos/shot-03-take-01.mp4)
and inspect its [generation record](../videos/shot-03-take-01.generation.json).
Take 1 was rejected: camera placement works but the chin moves against a stationary
background. [Take 2](../videos/shot-03-take-02.mp4) uses a shorter camera-lock prompt
and was also rejected, with worse motion and grainy windows.
[Take 3](../videos/shot-03-take-03.mp4) switches to Kling 3.0 Standard with a
short prompt, requested 3 seconds, and native audio enabled; rejected because
she starts running rather than already running. Take 4 restores take 1's exact
prompt on Kling with the same other settings. [Watch take 4](../videos/shot-03-take-04.mp4);
rejected for starting to run again. Stop Kling tests for this shot. H3 take 1
is the better running-motion baseline, but chin tracking remains unresolved.
Those early tests were not approved. The user subsequently expressed satisfaction
with the existing chin shot without identifying a take number; leave it alone.
Shots 1, 2 and 4 now also have completed first test takes using H3 Max Turbo,
480P, requested 3 seconds, prompt expansion disabled. The user rejected their
pace as too slow (roughly 4 steps/3 s versus shot 3 at roughly 9 steps/3 s).
The badge take also contains unwanted narration.

- [Shot 1: running legs](../videos/shot-01-take-01.mp4)
- [Shot 2: bouncing badge](../videos/shot-02-take-01.mp4)
- [Shot 4: closing doors](../videos/shot-04-take-01.mp4)

The user chose to continue with H3 Max Turbo. Shot 3 remains unresolved;
no additional shot-3 generation was made in this batch.
The interface directions below were originally prepared for ElevenCreative;
use the selected fal endpoint schema when submitting through fal.

## Shot order

| Shot | Prompt | Starting image | Working edit window |
|---|---|---|---|
| 01 | [Running legs](shot-01-running-legs.md) | [shot-01-v03](../images/shot-01-v03.png) | 0.00–0.65 s |
| 02 | [Bouncing badge](shot-02-bouncing-badge.md) | [shot-02-v02](../images/shot-02-v02.png) | 0.65–1.15 s |
| 03 | [Chin-following fisheye](shot-03-chin-fisheye.md) | [shot-03-v03](../images/shot-03-v03.png) | 1.15–2.00 s |
| 04 | [Closing doors](shot-04-closing-doors.md) | [shot-04a-v01](../images/shot-04a-v01.png) | 2.00–3.50 s |

The timing is an editing proposal carried over from the storyboard, not fixed
generation settings. Generate each shot separately at a duration supported by
the live UI, allowing enough action to choose the best short segment. Preserve
normal-speed motion; do not force a long clip into the cut by speeding it up.

## Folder organization

```text
06-shots/
  prompts/           # Still-image prompts and their revision history
  images/            # Generated stills and exact generation records
  video-prompts/     # This guide and four ready-to-paste motion prompts
  videos/            # Original video takes and generation records
```

Save future takes as `videos/shot-01-take-01.mp4`, etc. Keep the original export
and record the actual prompt, reference filenames, model shown in the UI,
duration, resolution, audio setting, and generation date in a sibling
`shot-01-take-01.generation.json`. The file extension should match the export.
Use the manifest's selected images; retain unsuccessful takes with clear notes
until selection, rather than silently replacing a selected version.

## How to run a shot

1. Attach the starting image in the appropriate input slot. For shot 3, use
   [the regenerated v03 still](../images/shot-03-v03.png); review its framing before the video test.
2. If the interface offers additional reference slots, attach only the supporting
   references listed for that shot and keep their roles clear. Filenames in text
   alone do not attach images.
3. Paste the complete fenced prompt. It includes the native sound direction.
4. Use 16:9 as the current presentation default. Choose the actual duration,
   resolution, and audio controls exposed by ElevenCreative; these files do not
   assume undocumented API parameters or legacy camera-command syntax.
5. Review the whole take for readable motion, object continuity, camera behavior,
   and synchronized sound before selecting its short edit segment.

Shot 4 has an optional [ending anchor](../images/shot-04b-v01.png). It contains
minor door-panel drift; begin with the starting image alone unless the end anchor
is corrected and the interface provides a suitable ending-frame control. The
prompt describes the end state even without an ending image.

## Shot 3 camera decision

The user confirmed strong fisheye distortion with the camera close beneath the
chin and moving with it, as if on a short invisible head-mounted rig. The chin
stays approximately anchored in frame while the station bobs and rolls behind
her. This is the updated brief; the old retreating camera and mild wide-angle
image are superseded as composition references. The generated v03 test frame
now establishes the close upward fisheye view; head-following motion remains untested.

The supplied [lens example](../../references/fisheye/user-inspiration-01.png)
illustrates distortion only. Its person, setting, overhead viewpoint, and
watermarks are not content for the generated shot. Keep the supplied reference
intact. A full-frame 16:9 fisheye is the working presentation; a circular black
border has not been selected by the user.

## Sound and edit continuity

Generate synchronized scene sound natively: heel contacts, clothing and badge
movement, Riley's breath, station ambience, a departure chime, and door closure.
Keep music, narration, and spoken dialogue out of these four source takes.
The competition jingle is added as one coherent arrangement across the edit.

Separate generations may produce different room tones or chimes. During editing,
carry one chosen station ambience beneath the cuts and bridge footsteps and
breathing across them. Choose one departure chime from the generated takes;
avoid restarting competing chimes on every cut. If available, a selected earlier
take's audio can serve as a reference for later takes, with permission to retain
the performance and ambience rather than invent a different speaker.

Keep the sound sequence legible: heel urgency → badge rattle and breath →
departure warning → door mechanism and last foot contacts → breath after stopping.
The timing of the jingle entrance remains a separate creative decision.

## Provider verification

Checked 2026-10-15. MiniMax describes H3 as accepting multimodal context and
producing video with native stereo audio, with reference relationships expressed
in natural language. The prompts use plain camera and sound descriptions.
[MiniMax H3 overview](https://www.minimax.io/blog/minimax-h3).

ElevenLabs lists H3 for image animation, reference-guided creation, natural-language
editing, and connecting opening and closing frames. Availability of particular
controls in the user's project still needs checking in the live interface.
[ElevenLabs H3 model page](https://elevenlabs.io/video/minimax-h3).

No generation lengths, reference-slot limits, pricing, or audio-toggle behavior
are assumed from third-party model pages.

## Cadence test and audio correction

[Shot 1 take 2](../videos/shot-01-take-02.mp4) is generated with an explicit nine-footfall/three-second target and already-running first frame. Review its pace before regenerating shots 2 and 4. For shot 4, match cadence until braking rather than forcing nine steps through the stop.

Plan a shared speech-free effects track for the cut to replace unwanted generated narration; this soundtrack has not yet been created. Prompt-only speech suppression is not a guarantee.

Update: the user rejected shot-01 take 2 as unchanged at roughly four steps,
and rejected the proposed speed adjustment. [Shot 1 take 3](../videos/shot-01-take-03.mp4)
uses an already-sprinting prompt with quick short steps and immediate push-offs.
It is generated and awaiting cadence review. No retimed preview was created.

Latest legs review: take 3 rejected for slow start, acceleration and passing the
train. [Take 4](../videos/shot-01-take-04.mp4) uses constant cadence/short-stride
direction. Assistant reviewed sampled frames of both: take 4 fixes the train
end reveal and has more even motion, but still fails the cadence target.
Contact sheets and their extraction script are in `../reviews/`. No usable
legs take had been selected at that stage; badge and doors still awaited pace resolution.

Latest selections supersede those historical review notes: shot 1 take 5's
picture is approved, the user is satisfied with the chin shot, and shot 2 take 3
is approved after using the 1.5× badge reference. Only the closing-door visual
remains unresolved. The legs audio revision and final cross-shot mix remain
separate editing work.
