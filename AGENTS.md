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

Develop and test the musical hook before committing to the full production batch.
Make AFTERHUMAN's name and benefit easy to hear, sing, and remember. Build the
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

Latest production decisions: test stills with the built-in image generator;
final still assets through ElevenCreative; video generation now uses fal.ai.
The first test uses MiniMax H3 Max Turbo at 480P with a requested 3-second
duration and prompt expansion disabled. Shot-03 take 1 was rejected because
the chin moved against a stationary background. Take 2 was also rejected, with
worse motion and grainy windows. The user requested a different model and a
simple prompt; take 3 tested Kling 3.0 Standard with audio for 3 seconds.
The user rejected take 3 because she starts running instead of already running.
Take 4 used take 1's exact prompt on Kling and was also rejected for starting
to run. Stop Kling tests for this shot: the user finds it unsuitable and more
expensive. H3 take 1 remains the better running-motion baseline, but its chin
tracking failed. The user chose to continue with H3 Max Turbo for the remaining
shots. Shots 1, 2 and 4 now have first test takes at 480P, requested 3 seconds,
with prompt expansion disabled; review is pending. No video take is approved.
Official MiniMax and ElevenLabs pages checked on 2026-10-15 confirm reference-led
video generation; MiniMax documents native stereo audio. Links and interface
limits are recorded in assets/06-shots/video-prompts/README.md. Use native
video audio for scene effects and ambience, then review continuity in the edit.
The competition jingle remains a separate ElevenCreative deliverable.

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
Video motion testing remains pending. Earlier versions remain historical. Full-frame
16:9 remains a working default; a circular black border was not explicitly chosen.

Maintain separate still prompts in assets/06-shots/prompts/ and complete video
prompts in assets/06-shots/video-prompts/. Future takes belong in
assets/06-shots/videos/, with their actual generation settings and reference files.

The first three shots were discussed as taking 1–2 seconds total. The assistant
recommended approximately 2 seconds, followed by 1–1.5 seconds for the wider shot.
Those exact timings remain editing guidance rather than a separately approved cut.
Carry heel strikes, badge movement, breathing, departure chime, and door hiss
across the cuts. Give her reaction a brief pause after the doors close.

The wardrobe above is now user-confirmed; approve its visual reference before
generating a full production batch.
Earlier generated references used a technical jacket, charcoal shirt, utility
trousers, and sneakers; those references need reconciliation with the new direction.

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

## Latest motion and audio feedback

The user reports shots 1, 2 and 4 are too slow: roughly 4 footfalls in 3 seconds
versus roughly 9 in shot 3. Match approximately 3 alternating footfalls per
second, already running from the first frame, until shot 4 brakes. Badge take 1
also contains unwanted narration saying Riley Brooks. Speech must be absent.
The accepted next workflow is to test running legs first, review the cadence,
then regenerate badge and doors and use a shared speech-free effects track in
the edit. Shot-01 take 2 was rejected as unchanged at four steps. The user
explicitly rejected speed adjustment and requested a different prompt. Take 3
used qualitative sprint direction and was rejected for starting slow,
accelerating and passing the train. Assistant inspected 24 sampled frames each
of takes 3 and 4. Take 4 keeps the train alongside and has more even motion, but
still fails the cadence target (about five new landings after the initial stance).
No legs video is selected; badge and door regeneration remain pending.
No generated ad take was retimed. The shared audio track has not been created.

The user subsequently confirmed satisfaction with the existing chin shot; do not
regenerate or stabilize it unless asked. They did not identify an exact take
number in that acceptance. Shots 1, 2 and 4 still need improvement.

The user supplied a slow-motion side-view running video and approved preparing
a separate reference copy: `assets/references/prepared-running/running-rightward-3s-v02.mp4`.
It uses a 1.0–26.2-second source excerpt at 8.4×, mirrored rightward, with no audio,
for approximately nine new alternating contacts in three seconds. The user
accepted this prepared reference and authorized a legs test with it. This
reference-only timing change does not authorize retiming generated ad takes.
Shot-01 take 5 tests `minimax/h3-max/reference-to-video` at 480P with the selected
legs appearance image and prepared motion video. Keep the supplied source and
preparation records; the reference's tracking lines and stand remain visible.
Take 5 is generated. Assistant native-frame review finds approximately seven new
landings after the opening stance, below nine; no source overlays or stand are
visible in the reviewed output. User review is pending. No additional paid test
or regeneration of the other shots has been submitted.

Latest decision: the user says shot-01 take 5 looks perfect and requests only
an audio fix, matching the train sound in shot-03 take 1. The picture is approved;
do not regenerate it or continue chasing an exact nine-contact count. A local
audio revision, `shot-01-take-05-audio-v01.mp4`, layers shot-03 take 1's full native
soundtrack under the legs audio. Its compressed video payload and timestamps
match the approved original. The source is not an isolated train stem and may
include breathing/footsteps; the new audio balance awaits user listening review.

Keep local editing and review scripts in the repository with reproduction
commands; see `scripts/README.md`. Temporary script variants must be captured
or consolidated into maintained scripts. The badge compositing approach in
its shot document is a proposal, not an approved generated or edited take.

The user subsequently chose to record badge motion for a reference-led test,
before attempting manual compositing, and supplied `assets/references/card-wiggle.MP4`.
The local candidate `assets/references/prepared-badge/badge-motion-3s-v02.mp4`
uses source seconds 3–6, cropped and silent at original speed. The user approved this reference and authorized shot 2 take 2, now generated
to `minimax/h3-max/reference-to-video` at 480P for three seconds. Use the source
for motion only; Riley's existing badge still defines appearance.

Shot 2 take 2 is saved with its exact input recipe and a sampled-frame review.
Appearance is retained, with some transient text distortion. The user rejected
its pace, reporting six audible footsteps, and suggested speeding the prepared
reference. Prepared badge v03 uses source 3–7.5 seconds at 1.5× into three seconds.
Shot 2 take 3 tests that reference with take 2's exact prompt, seed, appearance
image and output settings. This authorizes reference timing changes, not retiming
approved generated footage. Do not equate generated audio impacts with measured
visual steps; the badge view has no feet. Take 3 is generated. Frame inspection shows more frequent badge motion, with
some remaining print deformation. The user subsequently approved take 3: “Looks
good now.” Select it for the badge shot and preserve its motion. Assistant audio
listening was not performed; that limitation does not override user acceptance.

After approving badge take 3, the user requested deletion of the original
`assets/references/card-wiggle.MP4`. It has been deleted. Preserve the prepared
badge references, scripts, review sheets and provenance records.
