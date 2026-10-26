# Opening audio revisions

Shot 1 take 5's picture is user-approved. The user requested the train sound
heard in shot 3 take 1 because the legs take was too quiet.

[Preview audio v01](../videos/shot-01-take-05-audio-v01.mp4) blends the legs
soundtrack at unity with the full chin-take soundtrack at gain 0.8. The added
bed has 12 ms edge fades. A master gain of approximately 0.974 provides headroom.
The source includes any breathing and incidental sounds already in shot 3;
no source separation or new audio generation was performed.

The final decoded audio has RMS -21.64 dBFS and sample peak -1.48 dBFS, roughly
6.5 dB higher RMS than the original legs soundtrack. These are technical level
checks, not a perceptual listening verdict. User listening review is pending.

Video is passed through without re-encoding or retiming. Compressed sample
hashes and presentation timestamps match for all 73 video frames. Originals
are retained. [Exact edit record](../videos/shot-01-take-05-audio-v01.audio-edit.json).

`extract-audio.swift` decodes source tracks to stereo 48 kHz floating-point WAV.
`mix-train-ambience.swift` mixes the sources, encodes the audio to AAC, remuxes
the original picture, and verifies the picture payload/timestamps. The WAV and
M4A mix files are retained for further audio editing.

Exact commands to reproduce the edit in a new directory are in the
[production script guide](../../../scripts/README.md).

## Train-background cleanup draft v01

User requested just train ambience across the opening, excluding heel clacks.
The existing `shot-03-take-01-source.wav` is the full native soundtrack, not an
isolated ambience stem. Sources and the earlier mix remain unchanged.

Prepared local DSP candidates in `train-background-draft-v01/`:

- `train-background-cleanup-draft-v01.wav`: source-length cleanup, 3.0608 seconds.
- `train-background-bed-draft-v01.wav`: twelve-second bed with overlapping repeats.
- `train-background-draft-v01.processing.json`: provenance, exact settings and checks.

These are stereo 48 kHz, 24-bit PCM WAV files. A shared stereo spectral mask
suppresses variable energy relative to a persistent-background estimate. This
can reduce transient energy, but does not identify train, heel or breath sources
semantically. Train details may also be affected. The bed repeats the cleaned
source with 350 ms equal-power crossfades and short fades at its outer edges.

Numerical checks pass with no clipped samples. **Listening review is pending;
neither file is certified heel-free or selected for the edit.** No paid service,
model call, source retiming or Final Cut timeline modification was performed.
