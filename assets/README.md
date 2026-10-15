# Opening-hook assets

**All 24 test assets have been generated with the built-in image generator.**
There are 31 generated images including earlier attempts, plus the supplied
station and fisheye inspiration references. Each category's `images/` folder contains its images and
exact `.generation.json` records. Final production in ElevenCreative remains
separate. The user accepted shot-03-v03; other selections remain pending review.

Open [GALLERY.md](GALLERY.md) to review the selected images.
The [four video prompts](06-shots/video-prompts/README.md) now include action,
camera, native sound, and edit notes. Shot 3 now uses v03 for the confirmed
under-chin fisheye framing. The user is satisfied with the chin video and approved
shot 1 take 5's picture. Badge and door motion still need improvement.
[manifest.json](manifest.json) records selected versions, dimensions, hashes,
reference dependencies, and review notes.

Scope: running legs → bouncing ID badge → breathless face → closing train doors.
The reaction, passenger, billboard reveal, clinic, and later chase are outside
this batch. The closed-door anchor ends the fourth shot; it is not a fifth shot.

## Confirmed brief

| Item | User direction |
|---|---|
| Test stills | Built-in image generation |
| Final assets | ElevenCreative |
| Video | MiniMax H3 via fal; shot 1 take 5 uses H3 Max reference-to-video |
| Scene audio | Native video audio; check continuity across clips in the edit |
| Competition music | Separate original ElevenCreative jingle for the finished ad |
| Character | Riley Brooks, 27, American, from Austin, Texas, slim, brunette |
| Distinctive feature | Mole beneath her anatomical **left** eye |
| Shirt | White, long-sleeved, tucked in |
| Skirt | Black, knee-length |
| Tights | Sheer black; skin visible underneath |
| Shoes | Black, moderately chunky heels |
| Bag | Required |
| Employer | KORVEX, a fictional company distinct from AFTERHUMAN |
| Lanyard | Burgundy `#8b1e2d`, the user's suggested color adopted for this draft |
| Station | Inspired by the supplied image; original design at **8:30 a.m.** |
| Character state | Before upgrade; natural eyes and skin, no visible implants |

Austin describes Riley's background, not her ethnicity. Eye color, skin tone,
and facial geometry will be established by the selected portrait rather than
inferred from her nationality. In a frontal unmirrored image, her anatomical-left
mole appears on the viewer's right. Keep it on the same anatomical side in every
view; profile framing must not relocate it to make it visible.

## Provisional choices in these prompts

These are editable working defaults, not additional user decisions:

- Chin-length dark-brown bob with a subtle side part, worn loose.
- Straight tailored skirt with a modest back walking vent.
- Plain closed-toe leather pumps with approximately 5 cm block heels.
- Compact structured black leather shoulder bag with a short strap, worn on
  the right shoulder under the right arm. It remains clear of the badge.
- No added jewelry or other accessories.
- Portrait-format employee card in a clear holder; approximately 54 × 86 mm,
  on a plain 15 mm lanyard. Badge front: KORVEX, Riley Brooks, EMPLOYEE.
- Sheltered station with subtly damp reflective flooring and diffuse morning
  daylight, rather than rain falling directly on Riley.
- Original graphite train with cyan markings; carriage 07 and a double-line
  identifier beside the target doorway.
- Left-to-right platform travel with the camera on the same side of the action.
- 16:9 shot frames, carried over from the prior production plan.
- Badge close-up interprets “80% of frame” as approximately 80% of frame height.
- The earlier approximately 0.65 / 0.5 / 0.85 / 1–1.5-second timing is a rough
  editing target, not a provider generation setting or an approved final cut.

If one of these changes, update the affected prompt files before generation.

## Folder map

```text
assets/
  README.md
  manifest.json
  references/station/
    SOURCE.md
    user-inspiration-01.png
  01-riley/
    prompts/                 # Identity, angles, expressions
    images/                  # Generated versions go here
  02-wardrobe/
    prompts/                 # Complete outfit, shoes, bag
    images/
  03-badge/
    prompts/                 # Headshot, front/back, holder, worn badge
    images/
  04-station/
    prompts/                 # Master, ground, ceiling, target door plate
    images/
  05-train/
    prompts/                 # Side/door design and door states
    images/
  06-shots/
    prompts/                 # Four starting frames and optional ending anchor
    images/
    video-prompts/           # Four video prompts and production guide
    videos/                  # Future original takes
```

## Prompt index and generation order

Follow this order, which accounts for references shared between categories.
The same order is recorded in [manifest.json](manifest.json).

| Order | Prompt | Output |
|---|---|---|
| 1 | [riley-01](01-riley/prompts/riley-01.md) | Canonical identity portrait |
| 2 | [riley-02](01-riley/prompts/riley-02.md) | Three-quarter view |
| 3 | [riley-03](01-riley/prompts/riley-03.md) | Anatomical-left profile |
| 4 | [riley-04](01-riley/prompts/riley-04.md) | Low-angle face reference |
| 5 | [riley-05](01-riley/prompts/riley-05.md) | Expression sheet |
| 6 | [wardrobe-01](02-wardrobe/prompts/wardrobe-01.md) | Full outfit and bag turnaround |
| 7 | [wardrobe-02](02-wardrobe/prompts/wardrobe-02.md) | Shoes and lower-body detail |
| 8 | [wardrobe-03](02-wardrobe/prompts/wardrobe-03.md) | Bag construction reference |
| 9 | [badge-01](03-badge/prompts/badge-01.md) | Riley's employee headshot |
| 10 | [badge-02](03-badge/prompts/badge-02.md) | Flat badge front artwork |
| 11 | [badge-03](03-badge/prompts/badge-03.md) | Flat badge reverse artwork |
| 12 | [badge-04](03-badge/prompts/badge-04.md) | Physical badge, holder, lanyard |
| 13 | [badge-05](03-badge/prompts/badge-05.md) | Badge and bag strap worn on shirt |
| 14 | [station-01](04-station/prompts/station-01.md) | Master station and train environment |
| 15 | [train-01](05-train/prompts/train-01.md) | Train side and target door |
| 16 | [train-02](05-train/prompts/train-02.md) | Door states and interior glimpse |
| 17 | [station-02](04-station/prompts/station-02.md) | Ground-level running lane |
| 18 | [station-03](04-station/prompts/station-03.md) | Ceiling for the face shot |
| 19 | [station-04](04-station/prompts/station-04.md) | Door-area environment plate |
| 20 | [shot-01](06-shots/prompts/shot-01.md) | Running legs starting frame |
| 21 | [shot-02](06-shots/prompts/shot-02.md) | Bouncing badge starting frame |
| 22 | [shot-03](06-shots/prompts/shot-03.md) | Breathless face starting frame |
| 23 | [shot-04a](06-shots/prompts/shot-04a.md) | Closing-door shot starting frame |
| 24 | [shot-04b](06-shots/prompts/shot-04b.md) | Optional closed-door ending anchor |

## How to use the prompts

Each file includes the selected test destination, required reference images, a complete
image prompt, and review notes. The still prompts link to the separate
video-prompts/ folder for motion direction and native scene sound notes. There are no separate audio
generation prompts in this batch.

1. Generate the canonical portrait first, then select a consistent reference.
2. Generate later assets using their actual selected reference images. Merely
   mentioning an image filename in a prompt does not attach that image.
3. Save output images in the matching category's `images/` folder. Begin with
   `<asset-id>-v01.png`, then preserve revisions as `-v02.png`, etc. Use the actual
   file extension if the tool returns another image format.
4. Update manifest paths and dependent reference lists to the selected version;
   record the generation tool, final prompt, and selected/rejected status.
5. When combining references, follow the listed order and roles. Character
   references define Riley, wardrobe references define clothing and props, and
   environment references define the station and train.
6. Reference sheets may contain several views. Each actual video starting frame
   must be one standalone scene with no panel borders or collage layout.
7. Check badge text, identity, anatomical-left mole, sheer tights, bag side,
   8:30 a.m. light, train-door geometry, and travel direction before animation.
8. Reuse the design references when producing the final assets in ElevenCreative;
   retain generation provenance for the competition entry.

The supplied square station image is inspiration only. It does not determine
the final aspect ratio, exact layout, signage, or time of day. Its original
billboards and portraits are not part of the four-shot hook.

Exact badge graphics may need clean typesetting after visual exploration. Add
the official competition watermark in final editing, rather than asking the
image model to invent it. Preserve usable space at the bottom-right of the cut.

## Batch review notes

- The first train-side result introduced an unwanted runner; v02 removes her.
- The badge reverse was corrected to flat artwork in v02.
- The running-legs shot uses v03 for a tighter crop and more visible sheer-black
  tights. The skirt hem still rides above the knee in that pose; review it
  against the knee-length outfit before final production.
- The badge uses v02 for tight framing. The face v02 improved the crop but is
  now superseded for camera composition: the user confirmed a strong fisheye
  camera fixed close beneath the chin. The generated v03 replacement has
  upward close framing and stronger ceiling curvature. Its mole is subtle at
  this angle; review identity continuity and chin anchoring in the video test.
- The door ending frame has minor panel-detail drift from the starting frame.
  Check the pair in the video workflow before relying on it for interpolation.
- The worn-badge reference is wider than requested and the ground-level station
  reference remains relatively wide. Both are retained as test references;
  composed shot frames provide the tighter crops.

Eleven generated test takes are in `06-shots/videos/`. Shot 1 take 5's picture is
user-approved; its [audio revision](06-shots/audio/README.md) awaits listening
review. The user is satisfied with the chin shot, superseding earlier rejection
notes; badge and doors remain unresolved. The full edit remains unfinished.
See the [production scripts and reproduction commands](../scripts/README.md)
for reference preparation, contact sheets, and local audio mixing.

These are generated test assets, not final competition assets,
or a submitted entry. User acceptance of shot-03-v03 covers the test still.
