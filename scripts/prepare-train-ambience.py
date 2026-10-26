#!/usr/bin/env python
"""Make a stationary-background draft; this is not semantic source separation.

Requires NumPy. Reads the project's float32 WAV without a codec dependency.
Preserves stereo phase with a common spectral mask, suppresses time-varying
energy, and crossfades repeats into a longer bed. Listening approval is required.
"""

import argparse
import hashlib
import json
import struct
import wave
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

import numpy as np


def read_float_wav(path):
    raw = path.read_bytes()
    if raw[:4] != b"RIFF" or raw[8:12] != b"WAVE":
        raise ValueError("Expected RIFF/WAVE")
    pos, fmt, data = 12, None, None
    while pos + 8 <= len(raw):
        tag, size = struct.unpack_from("<4sI", raw, pos)
        pos += 8
        chunk = raw[pos:pos + size]
        if tag == b"fmt ":
            fmt = struct.unpack_from("<HHIIHH", chunk)
        elif tag == b"data":
            data = chunk
        pos += size + size % 2
    if fmt is None or data is None or fmt[0] != 3 or fmt[5] != 32:
        raise ValueError("Expected IEEE float32 audio from extract-audio.swift")
    samples = np.frombuffer(data, dtype="<f4").reshape(-1, fmt[1]).astype(float)
    if not np.isfinite(samples).all():
        raise ValueError("Non-finite source samples")
    return fmt[2], samples


def db(value):
    return float(20 * np.log10(max(float(value), 1e-12)))


def stats(samples, rate):
    return {
        "duration_seconds": len(samples) / rate,
        "sample_rate": rate,
        "channels": samples.shape[1],
        "rms_dbfs": db(np.sqrt(np.mean(samples ** 2))),
        "sample_peak_dbfs": db(np.max(np.abs(samples))),
        "clipped_samples": int(np.count_nonzero(np.abs(samples) >= 1)),
    }


def write_pcm24(path, samples, rate):
    if not np.isfinite(samples).all() or np.max(np.abs(samples)) >= 1:
        raise ValueError("Invalid or clipping output")
    signed = np.rint(samples * 8388607).astype(np.int32).reshape(-1)
    unsigned = signed.astype(np.uint32)
    packed = np.stack([unsigned & 255, (unsigned >> 8) & 255,
                       (unsigned >> 16) & 255], axis=1).astype(np.uint8)
    with wave.open(str(path), "wb") as out:
        out.setnchannels(samples.shape[1])
        out.setsampwidth(3)
        out.setframerate(rate)
        out.writeframes(packed.tobytes())
    with wave.open(str(path), "rb") as check:
        assert check.getnframes() == len(samples)
        assert check.getframerate() == rate and check.getsampwidth() == 3


def suppress_variable_energy(samples, rate):
    nfft, hop = 2048, 256
    window = np.hanning(nfft)
    padded = np.pad(samples, ((nfft, nfft), (0, 0)), mode="reflect")
    starts = np.arange(0, len(padded) - nfft + 1, hop)
    frames = np.stack([padded[s:s + nfft] for s in starts])
    spectra = np.fft.rfft(frames * window[None, :, None], axis=1)
    magnitude = np.sqrt(np.mean(np.abs(spectra) ** 2, axis=2))
    # Estimate persistent energy from interior frames; impacts/breaths can
    # overlap this estimate, so it cannot certify an isolated train stem.
    interior = (starts >= nfft) & (starts + nfft <= nfft + len(samples))
    floor = np.quantile(magnitude[interior], 0.25, axis=0)
    excess = np.maximum(magnitude - 1.15 * floor[None, :], 0)
    mask = floor[None, :] ** 2 / (floor[None, :] ** 2 + 6 * excess ** 2 + 1e-18)
    # Smooth frequency-bin boundaries and suppress DC/subsonic content.
    mask = np.apply_along_axis(lambda x: np.convolve(x, [0.2, 0.6, 0.2], "same"), 1, mask)
    freqs = np.fft.rfftfreq(nfft, 1 / rate)
    mask *= np.minimum(1, (freqs / 45) ** 2)[None, :]
    recovered = np.fft.irfft(spectra * mask[:, :, None], nfft, axis=1)
    result = np.zeros_like(padded)
    weights = np.zeros(len(padded))
    for start, frame in zip(starts, recovered):
        result[start:start + nfft] += frame * window[:, None]
        weights[start:start + nfft] += window ** 2
    result /= np.maximum(weights[:, None], 1e-12)
    return result[nfft:nfft + len(samples)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output_dir", type=Path)
    parser.add_argument("--seconds", type=float, default=12)
    args = parser.parse_args()
    if not 3 <= args.seconds <= 60:
        parser.error("Choose a duration between 3 and 60 seconds")
    args.output_dir.mkdir(parents=True, exist_ok=True)
    names = ["train-background-cleanup-draft-v01.wav", "train-background-bed-draft-v01.wav",
             "train-background-draft-v01.processing.json"]
    paths = [args.output_dir / name for name in names]
    if any(p.exists() for p in paths):
        raise FileExistsError("Use a new output directory; originals are never overwritten")
    rate, source = read_float_wav(args.source)
    cleaned = suppress_variable_energy(source, rate)
    core = cleaned[int(0.15 * rate):-int(0.15 * rate)]
    overlap = int(0.35 * rate)
    if len(core) <= 2 * overlap:
        raise ValueError("Source too short for this recipe")
    wanted = round(args.seconds * rate)
    bed = core.copy()
    angle = np.linspace(0, np.pi / 2, overlap)[:, None]
    while len(bed) < wanted:
        bridge = bed[-overlap:] * np.cos(angle) + core[:overlap] * np.sin(angle)
        bed = np.concatenate([bed[:-overlap], bridge, core[overlap:]])
    bed = bed[:wanted]
    gain = min(1.0, 10 ** (-28 / 20) / np.sqrt(np.mean(bed ** 2)),
               10 ** (-6 / 20) / max(np.max(np.abs(bed)), np.max(np.abs(cleaned))))
    bed *= gain
    cleaned *= gain
    for array in [bed, cleaned]:
        count = min(int(0.04 * rate), len(array) // 2)
        ramp = np.sin(np.linspace(0, np.pi / 2, count)) ** 2
        array[:count] *= ramp[:, None]
        array[-count:] *= ramp[::-1, None]
    write_pcm24(paths[0], cleaned, rate)
    write_pcm24(paths[1], bed, rate)
    record = {
        "created_at": datetime.now(ZoneInfo("Asia/Kolkata")).isoformat(timespec="seconds"),
        "source": str(args.source),
        "source_sha256": hashlib.sha256(args.source.read_bytes()).hexdigest(),
        "script": "scripts/prepare-train-ambience.py",
        "numpy_version": np.__version__,
        "method": "Persistent spectral-energy estimate with shared stereo mask; source-phase reconstruction",
        "settings": {"nfft": 2048, "hop": 256, "noise_floor_quantile": 0.25,
                     "excess_penalty": 6, "core_trim_each_end_seconds": 0.15,
                     "repeat_crossfade_seconds": 0.35, "output_edge_fade_seconds": 0.04,
                     "gain": gain, "source_retimed": False},
        "source_stats": stats(source, rate),
        "outputs": [{"path": str(p), "sha256": hashlib.sha256(p.read_bytes()).hexdigest(),
                     **stats(x, rate)} for p, x in zip(paths[:2], [cleaned, bed])],
        "review_status": "draft_pending_listening_not_selected",
        "limitations": ["No semantic train/heel/breath source separation.",
                        "Transient suppression can affect train detail and leave residual heel/breath sounds.",
                        "No claim that the draft is heel-free; numerical checks are not listening approval.",
                        "Long bed repeats cleaned source with overlaps; it is not new generated ambience."],
        "provider_calls": 0,
    }
    paths[2].write_text(json.dumps(record, indent=2) + "\n")
    print(json.dumps({"source": record["source_stats"], "outputs": record["outputs"],
                      "review_status": record["review_status"]}, indent=2))


if __name__ == "__main__":
    main()
