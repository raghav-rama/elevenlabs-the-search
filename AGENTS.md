# AFTERHUMAN agent guidance

## Purpose and sources

Help win ElevenCreative's **The Search for the World's Catchiest Ad** with
AFTERHUMAN, an original fictional implant brand. Aim for a coherent, memorable
ad with stylish, playful corporate satire and believable sci-fi visuals.

- Read [STATUS.md](STATUS.md) before starting work. It holds current priorities,
  approved assets, decisions, experiments, detailed creative context and open work.
- Read [CONVERSATION.md](CONVERSATION.md) when original discussion is needed;
  it is historical evidence, not a list of approved requirements.
- Latest user instructions take precedence. Distinguish approvals from assistant
  proposals and generated outputs from reviewed outputs. Preserve accepted work.
- Keep this file focused on standing instructions. Put progress, take selections,
  feedback and changing project state in STATUS.md. `CLAUDE.md` links here.

## Maintain the status ledger

- Append an entry to STATUS.md after meaningful user decisions, approvals or
  rejections, generation/editing work, checks, source deletions, commits/pushes,
  blockers or changes to next steps. Update it before handing work back.
- Use the actual current date and time in ISO 8601 with timezone offset, using
  `Asia/Kolkata`: `## YYYY-MM-DDTHH:MM:SS+05:30 — What happened`.
- Briefly record what happened, its outcome, affected files/takes or request IDs,
  and relevant remaining work. Record failures and pending reviews honestly.
- Append entries chronologically; preserve earlier entries. Correct or supersede
  old facts with a new dated entry rather than silently rewriting history.
- For imported history, record the current entry timestamp and label the earlier
  event time unknown unless verified. Do not invent precise historical times.
- Keep secrets and signed upload URLs out of the ledger and repository. Link
  generation records and scripts instead of duplicating full prompts or logs.

## Creative and production rules

- Preserve the approved four-shot opening and character/wardrobe continuity
  documented in STATUS.md. Propose changes to settled creative choices explicitly.
- Reuse approved references; keep identity, props, train, lighting and geography
  consistent. Keep anatomy believable and implant procedures free of gore.
- Follow the user's current priorities in the ledger, including deferred work.
- Check live provider schemas and pricing before new generation. Preserve exact
  prompts, inputs, settings, seeds, request IDs, outputs and review outcomes.
- Organize identity, hair and facial cyberware references/concepts under
  `assets/01-riley/`; organize outfit, accessories and body styling references
  under `assets/02-wardrobe/`. Keep each category's prompts in `prompts/`,
  generated images and generation records in `images/`, and supplied inspiration
  with provenance in `references/`. Link shared references instead of duplicating.
- Keep composed-shot still prompts in `assets/06-shots/prompts/`, video prompts
  in `assets/06-shots/video-prompts/`, and takes/records in `assets/06-shots/videos/`.
  Track pending, rejected and selected concepts explicitly; upscale only the
  user's selected look, then use its references to construct shot frames.
- Save editing and review scripts with reproducible commands; maintain
  [scripts/README.md](scripts/README.md). Preserve source/provenance records and
  prepared references unless the user requests deletion.
- Distinguish reference retiming from retiming accepted generated footage. Do not
  infer visible footfall cadence from generated audio alone.
- Review native audio for speech and continuity; finish with a coherent sound mix.
  Add exact branding/typography during editing when generation cannot preserve it.

## Competition delivery

The original ElevenCreative-generated jingle remains a central deliverable.
Review the cut for catchiness, concept, craft, cohesion and brand recall.
Before final delivery, recheck the [brief](https://elevenlabs.io/creative/thesearch),
[official rules](https://elevenlabs.io/creative/thesearch/terms) and live entry form.
Use the detailed previously checked requirements in STATUS.md as historical
context; verify eligibility, asset rights, content restrictions, watermark,
submission links, publishing requirements and deadlines against live sources.
