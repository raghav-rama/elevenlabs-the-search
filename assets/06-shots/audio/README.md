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
