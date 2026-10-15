# Solving the opening's motion-control failures

Research checked 2026-10-15. Recommendations are proposals, not new creative approvals. No media generation, retiming, or purchases were performed for this research.

**Recommendation:** stop spending the next tests on adjectives in the same image-to-video prompt. Test a measured running-video reference through H3 Max Reference to Video; separately try face-relative stabilization of shot 3 take 1. Remove the badge's unwanted soundtrack in the edit. These address three different problems with three different controls.

This is a production recommendation, not evidence that a particular endpoint will reproduce nine footfalls. None of the reviewed hosted models documents a hard footfall-count guarantee.

## 1. What our own tests establish

The [generation records](../assets/06-shots/videos/) preserve the submitted inputs. All H3 attempts used 480P, a requested three seconds, and disabled prompt expansion. Seeds were omitted, so these were not controlled same-seed comparisons.

| Test | Result and evidence |
|---|---|
| Legs take 1 | User reported approximately four steps in three seconds. |
| Legs take 2: explicit nine contacts | User reported no meaningful improvement. A numeric instruction did not enforce the cadence. |
| Legs take 3: stronger sprint language | User reported slow start, acceleration, then passing the train. Prior sampled review shows the train end around 2.375–2.5 s. |
| Legs take 4: short strides, constant pace | Train stays alongside and motion is more even; sampled review estimates about five new landings after the initial stance. Still rejected. |
| Chin takes 1–2, H3 | Placement broadly works; head moves against insufficiently moving background. Take 2 also has user-reported window artifacts. |
| Chin takes 3–4, Kling standard I2V | Both initiate running rather than continuing an existing run, including the attempt using H3 take 1's exact prompt. |
| Badge take 1 | User reported slow motion and unwanted narration reading Riley's name. |
| Doors take 1 | User reported slow approach. |

For this research I re-inspected the [legs starting image](../assets/06-shots/images/shot-01-v03.png) and [take 4 contact sheet](../assets/06-shots/reviews/shot-01-take-04-contact-sheet.png). The still already depicts a stride, but its forward shoe is flat on the ground. It cannot specify the next footfall's time. The sheet samples every 0.125 seconds; its count is approximate, not a full-frame audit. Audio complaints above are user observations; I did not independently listen to the clips during this research.

Shot 3 does not show feet. Its apparent nine-step rhythm is a creative reference from user feedback, not a directly measured foot-contact benchmark. Measure the target in a reference that actually shows feet.

## 2. Why the current approach runs out of control

There are three independent quantities: **step frequency**, **distance traveled per step**, and **camera movement**. Forward speed equals step frequency multiplied by step length. Requesting more speed can produce longer strides or faster background travel without producing more contacts. That is consistent with our takes, though it does not prove the model's internal reasoning.

Runway's official I2V guide explains that the image establishes the initial scene and that implied motion cues can conflict with text. It recommends focusing text on motion and revisiting the image after repeated failures. This is evidence for checking our anchor, not proof that Runway advice transfers perfectly to H3. Our pose, heels, crop, and skirt may influence the sampled gait; blaming any one of them requires an isolated test. [Runway I2V guide](https://help.runwayml.com/hc/en-us/articles/48324313115155-Image-to-Video-Prompting-Guide)

Research also treats motion as an explicit conditioning problem. Motion Prompting uses trajectories because prose poorly specifies detailed dynamics and timing. MotionCtrl separates object motion from camera motion. These results support changing the control signal; they do not imply that trajectory fields can be added to H3's API. [Motion Prompting](https://arxiv.org/abs/2412.02700), [MotionCtrl](https://arxiv.org/abs/2312.03641)

At 24 fps, three alternating contacts per second means about eight frames between contacts and sixteen frames per same-foot cycle. Higher output FPS can represent motion more smoothly; it does not itself increase contacts per second. Similarly, upscaling cannot repair a slow gait. We have no evidence that 480P caused the cadence failure or that prompt length caused the window artifacts.

## 3. What the available controls actually do

Live fal schemas and account prices were checked through the plugin. A compact evidence snapshot is saved in [fal-motion-contracts-2026-10-15.json](sources/fal-motion-contracts-2026-10-15.json). Provider capability descriptions are not independent quality benchmarks.

| Route | Verified control | Fit for this project |
|---|---|---|
| `minimax/h3-max-turbo/image-to-video` | Start/end images, prompt, seed; no motion-video input | Current route. Cannot supply the missing gait sequence. |
| `minimax/h3-max/reference-to-video` | Motion clips, identity/style images, optional start/middle/end frames | First proposed running test; stays in the H3 family but changes endpoint. |
| `fal-ai/wan/v2.2-14b/animate/move` | Character image plus driving video | Fallback for explicit body-motion transfer. Prefer wider visible-body inputs. |
| `fal-ai/kling-video/v3/standard/motion-control` | Character image plus motion video, orientation control | Different task from our rejected Kling I2V tests; requires suitable body framing. Lower priority given user preference. |
| `fal-ai/bytedance/dreamactor/v2` | Image plus driving performance video | Another transfer option; documented opening transition needs handling. |
| `minimax/h3-max/camera-controls` | Timed azimuth, elevation and distance | Camera trajectory control, not a documented attachment to a moving chin. |

### H3 Max reference-to-video: the first useful change

The live contract accepts up to nine reference images, three motion videos (each 2–15 s, combined at most 15 s), and three audio references, within twelve total reference files. Media are identified in the prompt by type and order. It supports 480P testing, optional first/last frames, and one timed middle image at native 480P/768P with both endpoints supplied. The duration range is 0.92–15 s; output may run about 0.7 s longer. [H3 Max reference API](https://fal.ai/models/minimax/h3-max/reference-to-video/api)

A video demonstrates *when* the feet move, while the still supplies Riley's appearance and setting. Matching the reference's duration, direction and view should reduce ambiguity—our proposed test design, not a documented guarantee. A legs-only driver is not explicitly prohibited in this schema, but quality for that crop remains unverified. A single middle image cannot constrain every alternating contact.

### Dedicated motion transfer: useful, but input framing matters

Kling Motion Control asks for a realistic reference performer with the full or upper body, including the head, visible without obstruction. `character_orientation: "video"` follows the driver's orientation; `"image"` favors the image's orientation and camera following. Documented maximum durations are 30 s and 10 s respectively. A direct legs-only input does not meet that guidance. Generate wider, then crop, if using this route. This would be a new control method, not another retry of Kling I2V. [Kling Motion Control API](https://fal.ai/models/fal-ai/kling-video/v3/standard/motion-control/api)

Wan-Animate uses spatially aligned skeleton signals and a separate facial representation. Its authors evaluate motion/identity transfer, but not our nine-contact heels shot. The hosted Move endpoint accepts an image and video and exposes resolution/seed settings; it does not expose a prose prompt field in the checked schema. A wider image can improve observability of limbs, at the cost of pixels after cropping. [Wan-Animate paper](https://arxiv.org/abs/2509.14055), [Move API](https://fal.ai/models/fal-ai/wan/v2.2-14b/animate/move/api)

DreamActor v2 explicitly documents a one-second opening transition and defaults `trim_first_second` to true. This is concrete evidence that some systems manage startup through trimming. It does not show that trimming fixes H3 cadence, or establish DreamActor as better for this scene. [DreamActor API](https://fal.ai/models/fal-ai/bytedance/dreamactor/v2/api)

## 4. Recommended treatment for each shot

### Shot 1: demonstrate steady cadence

Prepare a three-second reference excerpt already in continuous running motion, with approximately nine alternating contacts and short strides. Prefer a side view with the runner staying a similar size and position, visible feet, and moderate constant translation. Choose the excerpt from a longer recording or authored animation; do not speed it up. Start-up and braking belong outside this reference segment.

A phone performance, licensed footage, or a simple 3D animation can provide the motion. Record a side-tracking run when possible. Running in place or on a treadmill provides a cycle but risks transferring an in-place gait or wrong foot/world relationship; it is a secondary proxy. Match footwear mechanics as closely as practical. An athletic sprint with long airborne strides is a poor guide to this ordinary commuter shot.

Shot 3 take 1 is not an adequate legs driver: its feet are absent. It can inform energy and breathing, not supply an observable gait sequence.

Proposed reference prompt, not submitted:

> Use Image 1 for the commuter's wardrobe, train and station appearance. Use Video 1 for the continuous running action and its timing. Preserve the driver's short alternating steps, brief contacts and steady cadence throughout. Side tracking at shin height keeps her legs centered at the same size; the stationary train remains alongside. The clip begins and ends during the same ongoing run. Station ambience and heel impacts only.

The reference must contain the timing. This paragraph cannot manufacture control absent from the input. If the exact first image conflicts with the driver's initial phase, first align that phase or test the still as an appearance reference without forcing it as the opening frame.

### Shot 3: separate optical distortion from camera attachment

The desired relationship is a camera moving with the head, with the face approximately fixed and the world moving around it. The Snorricam manufacturer describes that actor/world relationship for body-mounted rigs. Our head-mounted variant is more restrictive: a chest-mounted camera still permits head movement relative to the camera. [Snorricam](https://www.snorricam.com/)

First test a **spatial stabilization of take 1**, without changing playback time. Track stable facial landmarks, compensate position and modest roll, and keep the chin near its intended location. A moving head against a static background can then yield an anchored face and oppositely moving background. Adobe documents position, rotation and scale stabilization from tracked features. [Adobe tracking and stabilization](https://helpx.adobe.com/after-effects/desktop/animate-in-after-effects/track-motion/tracking-stabilizing-motion-cs5.html)

Limits: cropping may remove the desired extreme framing; strong yaw/pitch and changing face perspective cannot be corrected by a 2D transform; stabilization cannot invent the forward-travel parallax missing from the source. Avoid indiscriminate background stabilization, which would oppose the effect. Track the skull, not only the moving jaw during panting. This is a low-cost salvage experiment, not an assurance it will pass.

If that fails, use an actual head-relative motion reference, or author a proxy camera attached to a head rig. Blender's Child Of constraint can inherit a target object's/bone's transformations. The production proposal is to place a fisheye camera below the chin, attach it to the head, animate the run, and use the render as a guide. A controlled render preserves the attachment exactly; a subsequent generative pass may weaken it. [Blender Child Of](https://docs.blender.org/manual/en/latest/animation/constraints/relationship/child_of.html)

H3 Camera Controls exposes orbital angles and distance; its default prompt freezes the scene. There is no documented moving-head target, roll channel, or head-parent constraint in its checked schema. Do not assume an orbit preset solves this shot. [Camera Controls API](https://fal.ai/models/minimax/h3-max/camera-controls/api)

### Shot 2: control the badge and its soundtrack separately

Use the approved running rhythm to guide the body movement, but do not equate every badge swing with a footfall: the hanging card can lag, twist and oscillate. If generative text deforms, track the card and composite clean KORVEX/Riley artwork over it. This preserves exact typography while retaining motion; corners and occlusion require review. Corner-pin tracking is a standard documented mechanism. [Adobe tracking and stabilization](https://helpx.adobe.com/after-effects/desktop/animate-in-after-effects/track-motion/tracking-stabilizing-motion-cs5.html)

The reliable speech fix is to remove the unwanted source soundtrack and mix speech-free effects. For future Turbo I2V calls, `target_audio_url` replaces the output soundtrack with the supplied clip, trimming or padding without changing speed. The checked endpoint has no `generate_audio: false` switch. Supplying nine heel clicks is **not a documented way to force nine visual contacts**. Reference audio on H3 Reference to Video is a different feature, not this replacement field. [Turbo I2V API](https://fal.ai/models/minimax/h3-max-turbo/image-to-video/api)

Build heel sounds against approved visible contacts, with continuous station ambience across cuts. Native breathing/effects can be retained only where reviewed and useful; the separate ElevenCreative jingle remains necessary for the ad.

### Shot 4: fast approach, then a real stop

A closing-door shot contains a deliberate change of pace. Match the running cadence during the approach, then allow braking and the reaction. Do not demand nine continuous contacts across a stop. A reference should demonstrate that sequence. First/last frames help establish door and body endpoints, but do not determine the timing of all intermediate strides. Correct the existing end-anchor door geometry before using it.

Generating longer and selecting a steady segment can remove startup, at original speed. That only works if such a segment exists; it cannot repair a whole clip whose gait remains slow. This research does not recommend retiming, which the user rejected.

## 5. Controlled next experiment and stop conditions

**Prerequisite:** a suitable motion reference. Existing project stills do not replace it. No full batch until the legs test passes.

1. Annotate contacts in the driver at native timestamps. Confirm the cadence before paying for transfer.
2. Run H3 Max Reference to Video at 480P, 3 s, expansion disabled, with a recorded seed. Use the same appearance inputs and prompt in a control without the motion clip and a treatment with it; only the treatment instructs following Video 1. This tests adding motion guidance within the same endpoint. Comparing Turbo directly with Max Reference would confound endpoint and conditioning changes.
3. If the treatment improves materially, repeat the pair with a second seed. Same-seed pairs reduce randomness; they do not guarantee pixel-equivalent conditions or isolate all prompt/reference effects.
4. If neither treatment reproduces the cadence, stop prompt tweaks and test one dedicated transfer route with a suitable wider reference, or author the motion in 3D. Do not generate badge and doors around another failed legs take.
5. Independently review a stabilized copy of chin take 1. Preserve the original file and playback timing.

Proposed evaluation, not a published benchmark:

- Count **new alternating foot contacts** in a specified three-second interval. Mark any foot already planted at frame zero separately. Inspect every native frame near ambiguous events; do not infer count from soundtrack or head bobbing.
- Target roughly 0.333 s between contacts. At 24 fps, a provisional tolerance of about ±2 frames is useful for screening; inspect opening and closing intervals for systematic acceleration. Human judgment still decides believability.
- Record shoe/floor sliding, impossible joint motion, tights/skirt continuity, foot size changes and occlusions. Correct cadence with broken anatomy is a failure.
- Check runner screen position/scale and background landmark progression separately. Stable centering does not prove constant world speed; an unseen train end does not prove correct cadence.
- For shot 3, measure landmark drift and inspect background translation/roll. Small landmark error alone can describe a frozen face, so watch expression, breathing and perspective too.
- Compare at normal playback speed, then listen to the full output. Save settings, actual duration, seed and the review verdict.

### Cost envelope

Account-tool rates returned on 2026-10-15; these are estimates, not invoices. Recheck configuration-dependent pricing before execution.

| Endpoint | Returned USD / second | Illustrative 3 s arithmetic |
|---|---:|---:|
| H3 Max Turbo I2V | 0.015 | 0.045 |
| H3 Max Reference to Video | 0.050 | 0.150 |
| Wan 2.2 Animate Move | 0.080 | 0.240 |
| Kling v3 Standard Motion Control | 0.126 | 0.378 |
| DreamActor v2 | 0.050 | 0.150 |

The first H3 reference pair is approximately **$0.30**, or **$0.60** for two pairs. Other rows are rate illustrations, not promises that a three-second request is supported or billed identically: driving-clip duration, transition handling, minimums and configuration can matter. Reference capture/animation and human review are additional effort.

## 6. More advanced methods and why they are fallbacks

CameraCtrl demonstrates explicit camera-pose conditioning. UniMoCa jointly represents human motion and camera trajectories through rendered proxies; this is directly relevant to separating the actor from the moving view. These papers support an authored-control workflow but are not evidence that our hosted H3 endpoint exposes those mechanisms. No local implementation was installed or benchmarked here. [CameraCtrl project](https://hehao13.github.io/projects-CameraCtrl/), [UniMoCa](https://arxiv.org/abs/2608.01944)

Lightricks' LTX pipeline supports IC-LoRA reference conditioning for controls such as depth, pose and edges, with compatible model/adaptor requirements. This can make a rendered run cycle useful as structured guidance, but adds setup and compatibility work. Choosing an ordinary LTX I2V endpoint or higher FPS alone does not activate those controls. [LTX pipeline documentation](https://github.com/Lightricks/LTX-2/blob/main/packages/ltx-pipelines/docs/pipelines.md), [IC-LoRA implementation](https://github.com/Lightricks/LTX-2/blob/main/packages/ltx-pipelines/src/ltx_pipelines/ic_lora.py)

Wan-Animate-2's paper explicitly discusses failures from intermediate motion extraction and proposes direct driving-video conditioning plus viewpoint control. That is useful evidence that motion references themselves have limitations. The checked fal Animate endpoint is **Wan 2.2 Animate**, not a verified hosted Wan-Animate-2 service; their capabilities must not be conflated. [Wan-Animate-2](https://arxiv.org/abs/2608.06009)

For exact control, animate foot contacts and root travel in 3D, use a matching camera, and render the required timing. This is more production work but makes contact scheduling and camera attachment explicit. Photorealistic Riley/wardrobe rendering remains a separate challenge. Generative restyling of that render requires another fidelity check; if it alters timing, preserve the controlled render or use compositing for the critical elements.

## Research limits

The Tavily pro research request timed out without returning a report. Findings above come from direct primary-source reading, live fal contract/pricing inspection, project generation records, and the stated visual checks. No community prompt anecdote was treated as proof, no new endpoint was quality-tested, and no source demonstrated this exact combination of heels, crop, cadence and head-mounted fisheye.

The immediate recommendation is motion-reference testing for legs, spatial salvage testing for the chin, and editorial audio replacement for the badge. The remaining uncertainty is how well each generative route preserves those supplied controls in this particular scene.
