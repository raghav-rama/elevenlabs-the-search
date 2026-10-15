# AFTERHUMAN project guidance

## Source and purpose

The primary objective is to win ElevenCreative's **The Search for the World's
Catchiest Ad** competition. Optimize creative and production decisions for that
objective. AFTERHUMAN is the current fictional brand: a company selling implants
that enhance vision, speed, cognition, and strength. Its working ad is a
30-second futuristic commuter story. Cyberpunk 2077 was an aesthetic reference
in the discussion; build an original world and identity for the entry.

Read [CONVERSATION.md](CONVERSATION.md) for the full project discussion.
Original source: <https://chatgpt.com/share/6acfb47c-7608-8320-b444-8826fc90dd02>.

Treat the latest user decisions as authoritative. Distinguish accepted decisions
from assistant proposals and older alternatives. This file summarizes the source;
it does not make every suggestion in that conversation an approved requirement.
Keep this file as the single source of agent instructions; `CLAUDE.md` links here.

## Current production state and next task

Updated 2026-10-15. This section supersedes historical rejection/pending-review
notes in older generation records. Thirteen test video takes have been generated;
the four-shot opening has not yet been assembled into a finished cut.

| Shot | Current selection and status |
|---|---|
| 1 — running legs | [Take 5](assets/06-shots/videos/shot-01-take-05.mp4): picture approved. The [train-audio revision](assets/06-shots/videos/shot-01-take-05-audio-v01.mp4) awaits explicit listening approval. |
| 2 — bouncing badge | [Take 3](assets/06-shots/videos/shot-02-take-03.mp4): approved and selected after using a 1.5× motion reference. |
| 3 — chin fisheye | The user is satisfied with the existing chin video; preserve it. They did not identify an exact take number when accepting it. Take 1 was explicitly named as the train-sound source, which does not separately establish the visual selection. |
| 4 — closing doors | [Take 1](assets/06-shots/videos/shot-04-take-01.mp4) is rejected for slow running. This is the remaining unresolved opening visual. |

The user agreed to work on shot 4 next:

1. Review the existing take for usable material.
2. Make Riley enter already running at a pace consistent with the accepted shots.
3. The train doors close before she reaches them; she brakes and misses the train.
4. Hold a brief breathless reaction so the missed commute registers.
5. If the existing timing fails, prepare a suitable motion reference before the
   next test. A reference for this wider running-and-stopping action is not yet
   selected; the legs and badge references do not establish that full action.

Once shot 4 works, assemble the four-shot hook and join train ambience, footsteps,
badge sounds and breathing across cuts. Exact cut durations remain provisional.
Preserve approved pictures and motion; do not reopen them simply to satisfy an
older numerical cadence target.

**Jingle work is deferred at the user's request.** Finish the opening work first
and revisit the jingle later. No lyric, melody, singer or arrangement is approved.
“Afterhuman… ahead of your day” was an assistant example only. The original
ElevenCreative-generated jingle remains required for the eventual competition
entry; deferring it does not make it optional.

## Competition brief and requirements

Checked on 2026-10-14. Recheck these sources before final delivery:
[competition brief](https://elevenlabs.io/creative/thesearch) and
[official rules](https://elevenlabs.io/creative/thesearch/terms).

From the brief:

- Feature the product's name, image, and logo.
- Make the original jingle central to the ad, rather than incidental background.
- Place the official contest watermark at bottom right, including social posts.
- The brief requests original jingle audio and a Studio project link. Preserve
  both alongside the formal submission materials below.

From the official rules:

- Judging weights: catchiness 35%, concept 25%, craft 25%, cohesion 15%.
- Deliver a 15–45-second ad with an original ElevenCreative-generated jingle.
  Other tools are allowed; effective additional ElevenCreative use helps craft.
- Submit by November 1, 2026, 11:59 pm Pacific Time.
- Provide a public ElevenCreative jingle share link, a viewable raw-video link
  on Drive or Frame.io, and a description of ElevenCreative's role.
- Publish on at least two of X, Instagram, TikTok, and YouTube. Include
  `#TheWorldsCatchiestAd`, `#ElevenCreativeCompetitionVol1`, and tag
  `@elevencreative` and `@elevenlabs` where supported. Submit the entry form.
- Keep posts and the jingle link public through November 10's judging end.
- Work must be new for this competition. Use English speech or subtitles where
  needed; entries without dialogue or subtitles are accepted.
- Use authorized assets; avoid third-party franchise content, unpermitted
  likenesses, children's voices, and prohibited content. Verify entrant eligibility.
- The rules also prohibit depictions of risky behavior; review the proposed
  rooftop chase against that restriction before committing to those shots.

The brief and rules differ on submission details. Prepare both sets of materials
and check the live entry form. The rules' explicit platform list above avoids
relying on an inconsistent earlier reference to LinkedIn.

## Strategy for winning

The current creative gap is the jingle: the shared conversation developed a story,
voiceover, and synth score, but did not settle an original sung brand hook.
Do not treat a cinematic cut with background music alone as competition-ready.

When jingle work resumes, develop and test a musical hook that makes AFTERHUMAN's
name and benefit easy to hear, sing, and remember. The user's current priority
is completing the opening; do not block that work on jingle development. Build the
action, mechanical clicks, sound design, dialogue pauses, and end card around
that hook. Test whether viewers can hum it and name the brand after one viewing
and the next day. Score draft cuts against all four judging criteria.

Preserve the user's settled opening while integrating the jingle. Propose changes
to settled creative decisions explicitly if testing suggests they would improve
the entry. Keep generation files, prompts, selected takes, original audio, and
project links so the production process can be demonstrated.

## Creative direction

- Tell one coherent story about one woman using extraordinary enhancements to
  solve an ordinary problem: missing her work commute.
- Aim for stylish, playful, aspirational corporate satire. Play the humor straight.
- Show a clear chain of cause and effect: ordinary frustration, upgrade,
  enhanced abilities solving obstacles, calm boarding, brand payoff.
- Make the benefit and brand memorable together. The desired takeaway is that
  AFTERHUMAN lets a woman outrun the train she missed.
- Working aesthetic: photorealistic premium sci-fi, rainy futuristic city,
  cyan and magenta neon, chrome, deep blacks, and a pristine white implant clinic.
  Keep anatomy believable and the procedure free of gore.

## Locked opening

Production choices: test stills with the built-in image generator; final still
assets through ElevenCreative; video generation through fal.ai. Use low-resolution
480P tests, usually three seconds, with prompt expansion disabled. The accepted
legs and badge takes use `minimax/h3-max/reference-to-video`, with separate
appearance images and prepared motion videos. Earlier tests used
`minimax/h3-max-turbo/image-to-video`. Do not confuse those endpoints: the latter
was not the reference-video workflow used for the accepted results.

The user rejected Kling tests for the chin shot as unsuitable and more expensive;
do not restart that model comparison. Preserve the accepted chin motion. Check
live endpoint schemas and pricing before new model work; generation records
capture actual settings, references, seeds and request IDs.

Official MiniMax and ElevenLabs capabilities were checked on 2026-10-15; source
links are in assets/06-shots/video-prompts/README.md. Use native video audio as
scene-effect material, then review and mix it for continuity. Prompt-only
suppression of speech is not a guarantee. The jingle is a separate deliverable.

Riley Brooks is 27, American, from Austin, Texas, slim, brunette, with a mole
under her anatomical left eye. Nationality does not specify ethnicity. Her
employer is the fictional KORVEX. Wardrobe: white long-sleeved shirt tucked into
a knee-length black skirt, sheer black tights, moderately chunky black heels,
and a bag. Use burgundy #8b1e2d for the lanyard as the current suggested color.
The supplied station image is inspiration, with the scene set at 8:30 a.m.
The current asset batch covers only the four-shot hook. See assets/README.md
for prompt order, reference dependencies, and explicitly provisional details.

The user explicitly settled this hook. Establish her as an ordinary commuter
before revealing superhuman abilities:

1. Side tracking close-up of her running legs.
2. Close-up of her ID badge bouncing as she runs, occupying roughly 80% of frame.
3. Strong fisheye view from close beneath her chin while she runs and pants.
4. Normal wider shot revealing the closing train doors; she misses the train.

The user confirmed the shot-3 camera on 2026-10-15: it moves with her head/chin,
as if mounted on a short invisible head rig below the chin. Keep the chin
approximately anchored while the station bobs and rolls behind her. Preserve
strong optical distortion. The previous mild fisheye and retreating camera are
superseded; the user accepted shot-03-v03 as the improved replacement test frame.
The user subsequently accepted the existing chin video; the earlier still and
motion rejections are historical. Full-frame 16:9 remains a working default;
a circular black border was not explicitly chosen.

Maintain separate still prompts in assets/06-shots/prompts/ and complete video
prompts in assets/06-shots/video-prompts/. Future takes belong in
assets/06-shots/videos/, with their actual generation settings and reference files.

The first three shots were discussed as taking 1–2 seconds total. The assistant
recommended approximately 2 seconds, followed by 1–1.5 seconds for the wider shot.
Those exact timings remain editing guidance rather than a separately approved cut.
Carry heel strikes, badge movement, breathing, departure chime, and door hiss
across the cuts. Give her reaction a brief pause after the doors close.

The wardrobe above is user-confirmed and represented in the current opening
assets. Technical jackets, charcoal shirts, utility trousers and sneakers from
earlier discussion are superseded; do not reintroduce them. Approval of opening
test takes does not settle every reference for the later full production batch.

## Story after the opening

The latest assistant proposal, not yet explicitly approved by the user, is:

- A passenger reacts as she catches her breath and the train departs.
- The departing train reveals an AFTERHUMAN billboard across the tracks:
  “STILL RUNNING ON HUMAN?”
- She looks at her aching feet, then the billboard, and quietly says “Fine.”
- Cut to the clinic: iris mechanism, temple implant, and calf actuator activate
  through three rhythmic mechanical clicks; her eyes open.
- Proposed voiceover: “AFTERHUMAN. Your body has an update.”

The earlier working continuation demonstrates enhanced vision, acceleration,
route calculation, and strength through an alley and rooftop shortcut. She boards
calmly, with “Morning” as the proposed comic payoff. The working end line is
“AFTERHUMAN. Your limits are optional.” An earlier proposed closing disclaimer
is “Please allow additional braking distance.”

Reconcile the full sequence with the revised opening before fixing shot durations.
Make the clinic time transition explicit: avoid implying that surgery happens
while the departing train travels one stop. The source suggests a subsequent
morning or a clear flashback; neither treatment is locked. During the enhanced
chase, viewers must recognize the train she pursues and boards as the same train.
Keep departure and destination geography understandable.

## Asset continuity

Build a small asset bible before producing many shots. Reuse approved references
instead of independently inventing recurring assets in each prompt.

- Protagonist: face, profile, three-quarter views, full-body proportions, hair,
  skin tone, outfit, shoes, ID badge, and any bag or accessories.
- Earlier image references used a South Asian woman with a short black bob and
  athletic build. Riley's latest description above supersedes that direction;
  do not carry over an unrequested ethnicity, black hair, or athletic build.
- Implants: exact location, geometry, material, and glow; define before-upgrade,
  upgraded-inactive, and activated states. Preserve natural eyes and no implant
  seams before the procedure.
- Train: exterior, doors, interior, distinctive identifying markings, lighting,
  and the recurring passenger's appearance.
- Locations: departure platform and billboard, clinic, alley, rooftop, barrier,
  maintenance ladder, destination station, and train interior. Sketch the route.
- Brand: consistent wordmark, typography, palette, billboard art, interface
  graphics, end card, and a signature activation sound repeated at the logo.

Prioritize character, wardrobe, implant, and train reference sheets. The shared
conversation contains one storyboard sheet and seven separate starting frames;
they are historical references, not files already present in this repository.
The separate frames were generated in train, clinic, vision, sprint, boarding,
rooftop, end-card order; narrative order places rooftop before boarding.

## Production workflow

- Each shot needs a starting image, action prompt, camera direction, intended
  duration, references, and an ending image when the final pose matters.
- Use standalone widescreen 16:9 starting frames for individual shots.
- Animate short, simple actions. Split complex rooftop movement into separate
  approach, grip, swing, and landing shots as needed.
- Reuse the same identity, wardrobe, implants, train, palette, weather, and
  geography throughout. Check continuity before selecting a generated take.
- Add exact logos, typography, billboard copy, and disclaimers during editing.
- Use one narrator voice and a continuous narration recording; cut phrases into
  the timeline. Generate character dialogue separately with a consistent voice.
- Use a continuous musical arrangement built around the original ElevenCreative
  jingle, with a build, a pause for the boarding line, and a final brand hook.
  Layer effects and location ambience separately.
- Finish through take selection, trimming, beat timing, audio mixing, color
  matching, and text composition. Native clip audio alone is insufficient to
  establish consistent music and narration across the whole ad.
- Treat old model recommendations, availability claims, contest details, and
  editing-time estimates in the transcript as historical advice. Verify current
  provider capabilities and any actual contest rules before relying on them.

## Review criteria

Review the full cut for story clarity, timeline, train identity, character and
wardrobe continuity, implant placement, route geography, readable opening badge,
audio continuity, humor timing, brand recognition, jingle recall, integration
of music with the action, and the competition requirements above.

When testing with viewers, ask what happened, what was advertised, the company
name, the remembered moment, and the product benefit, without prompting answers.
The source recommends immediate and next-day recall checks.

## Working in this repository

The repository initially contains no application code or established build/test
commands. Keep production materials understandable and record new approved
decisions as the project develops. Preserve the transcript as historical evidence;
update this guidance when the user changes direction. Report created assets and
checks honestly; distinguish proposals, generated outputs, and reviewed outputs.

## Motion references, audio and reproducibility

### Running legs

The user approved [prepared running reference v02](assets/references/prepared-running/running-rightward-3s-v02.mp4)
and then shot 1 take 5's picture (“looks perfect”). That reference uses source
seconds 1.0–26.2 at 8.4×, mirrored rightward, silent, to provide fast continuous
running motion. Its tracking lines, treadmill and stand are reference artifacts,
not intended final content. Source details and preparation settings are retained
in `assets/references/prepared-running/`.

Earlier legs takes were rejected for slow motion, accelerating from a slow start,
or passing the train. The older goal of roughly nine landings in three seconds
is historical guidance; the user approved take 5 despite an approximate assistant
count of seven new landings. Do not regenerate it to chase an exact count.

### Badge

The user recorded a badge motion reference. The original-speed v02 preparation
used seconds 3–6 and drove shot 2 take 2. They rejected that take as too slow,
reported six audible footsteps, and suggested speeding the reference.

[Prepared badge reference v03](assets/references/prepared-badge/badge-motion-3s-v03.mp4)
uses source seconds 3–7.5 at 1.5× into three seconds, silent, with the same crop.
It drove shot 2 take 3 using take 2's exact prompt, seed, appearance image and
output settings. The user approved take 3 (“Looks good now”). Earlier observed
print deformation remains a review note, not a reason to override that acceptance.

Use the reference video for motion and Riley's badge still for appearance.
The source's blue shirt, different holder and room must not replace her design.
Manual layered badge animation was an earlier fallback proposal; the accepted
result uses reference-to-video generation. No manual badge composite was made.

Do not infer visual footfall cadence from generated sound alone. The badge view
has no feet, and audible impacts may not match its movement. Judge visible motion
and soundtrack separately. The user authorized speed changes to reference clips;
that does not authorize retiming approved generated ad footage.

### Audio

The user wanted the train sound from shot 3 take 1 added to the approved legs
picture. `shot-01-take-05-audio-v01.mp4` layers that full native soundtrack under
the legs audio. Compressed video payloads and presentation timestamps match the
original across all 73 frames. The added source is not an isolated train stem;
it can include breathing and footsteps. The mix awaits explicit listening approval.

Badge take 1 contained unwanted narration reading Riley's name. Keep the opening
free of that voiceover. Badge take 3 is user-approved; assistant audio listening
was not performed, and this limitation does not override the user's acceptance.
The final continuous sound mix across all four shots is still unfinished.

### Scripts and source retention

Keep local editing and review scripts in the repo with exact reproduction commands;
see [scripts/README.md](scripts/README.md). This includes reference preparation,
contact sheets, audio extraction, mixing and picture-preservation verification.
Consolidate temporary script variants into maintained scripts. Preserve generated
takes, prepared reference versions, provenance records and review artifacts.

The original `assets/references/card-wiggle.MP4` was deleted at the user's request
after badge take 3 was approved. Prepared badge clips and source hashes remain.
The original downloaded running clip is also absent from its recorded path.
Reproducing either preparation from the source requires restoring that source;
the prepared references can be reused directly. Do not describe deleted originals
as present or silently substitute another source.
