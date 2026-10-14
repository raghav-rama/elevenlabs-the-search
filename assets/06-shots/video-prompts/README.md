# Four-shot opening — video prompts

Prepared for MiniMax H3 in ElevenCreative. These files are production directions;
no videos have been generated or uploaded.

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
  videos/            # Future original video takes; currently empty
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
