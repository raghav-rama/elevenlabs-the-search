import Foundation
import AVFoundation
import CryptoKit

// Preserve the approved video stream; mix its audio with shot 3's native bed.
guard CommandLine.arguments.count == 6 else {
    fatalError("Usage: mix-train-ambience.swift VIDEO ORIGINAL.wav REFERENCE.wav MIX.wav OUTPUT.mp4")
}
let args = CommandLine.arguments
let videoURL = URL(fileURLWithPath: args[1])
let outputURL = URL(fileURLWithPath: args[5])
guard !FileManager.default.fileExists(atPath: outputURL.path) else { fatalError("Output exists") }
let requestedWave = URL(fileURLWithPath: args[4])
for url in [requestedWave, requestedWave.deletingPathExtension().appendingPathExtension("m4a"),
            outputURL.deletingPathExtension().appendingPathExtension("audio-edit.json")] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let asset = AVURLAsset(url: videoURL)
let sourceVideo = asset.tracks(withMediaType: .video).first!
let duration = sourceVideo.timeRange.duration
let sampleRate = 48000.0
let frameCount = Int((CMTimeGetSeconds(duration) * sampleRate).rounded())
let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 2)!
func read(_ path: String) throws -> AVAudioPCMBuffer {
    let file = try AVAudioFile(forReading: URL(fileURLWithPath: path))
    guard file.processingFormat.sampleRate == sampleRate,
          file.processingFormat.channelCount == 2 else { fatalError("Expected 48 kHz stereo") }
    let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat,
                                 frameCapacity: AVAudioFrameCount(file.length))!
    try file.read(into: buffer)
    return buffer
}
let original = try read(args[2])
let reference = try read(args[3])
guard original.frameLength >= frameCount, reference.frameLength >= frameCount else {
    fatalError("Source audio does not cover the video")
}
let mixed = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(frameCount))!
mixed.frameLength = AVAudioFrameCount(frameCount)
let referenceGain: Float = 0.8
let edgeFrames = 576 // 12 ms on the added bed only, to avoid hard boundaries.
var peak: Float = 0
for f in 0..<frameCount {
    let fade = Float(min(1.0, Double(f) / Double(edgeFrames),
                         Double(frameCount - 1 - f) / Double(edgeFrames)))
    for c in 0..<2 {
        let value = original.floatChannelData![c][f]
            + referenceGain * fade * reference.floatChannelData![c][f]
        mixed.floatChannelData![c][f] = value
        peak = max(peak, abs(value))
    }
}
let ceiling: Float = pow(10, -1.5 / 20.0)
let masterGain = min(1, ceiling / max(peak, 0.000001))
var squares = 0.0
for f in 0..<frameCount { for c in 0..<2 {
    mixed.floatChannelData![c][f] *= masterGain
    squares += pow(Double(mixed.floatChannelData![c][f]), 2)
} }
let waveURL = URL(fileURLWithPath: args[4])
do {
    var file: AVAudioFile? = try AVAudioFile(forWriting: waveURL, settings: format.settings)
    try file!.write(from: mixed)
    file = nil
}
func export(_ exporter: AVAssetExportSession, to url: URL, type: AVFileType) {
    exporter.outputURL = url
    exporter.outputFileType = type
    exporter.shouldOptimizeForNetworkUse = true
    let signal = DispatchSemaphore(value: 0)
    exporter.exportAsynchronously { signal.signal() }
    signal.wait()
    guard exporter.status == .completed else {
        fatalError("Export failed: \(String(describing: exporter.error))")
    }
}
let aacURL = waveURL.deletingPathExtension().appendingPathExtension("m4a")
let waveAsset = AVURLAsset(url: waveURL)
export(AVAssetExportSession(asset: waveAsset, presetName: AVAssetExportPresetAppleM4A)!,
       to: aacURL, type: .m4a)
let aacAsset = AVURLAsset(url: aacURL)
let aacTrack = aacAsset.tracks(withMediaType: .audio).first!
let composition = AVMutableComposition()
let picture = composition.addMutableTrack(withMediaType: .video,
                                          preferredTrackID: kCMPersistentTrackID_Invalid)!
try picture.insertTimeRange(sourceVideo.timeRange, of: sourceVideo, at: .zero)
picture.preferredTransform = sourceVideo.preferredTransform
let sound = composition.addMutableTrack(withMediaType: .audio,
                                        preferredTrackID: kCMPersistentTrackID_Invalid)!
try sound.insertTimeRange(CMTimeRange(start: .zero, duration: duration), of: aacTrack, at: .zero)
export(AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough)!,
       to: outputURL, type: .mp4)

func videoFingerprint(_ url: URL) throws -> [String: Any] {
    let source = AVURLAsset(url: url)
    let track = source.tracks(withMediaType: .video).first!
    let reader = try AVAssetReader(asset: source)
    let output = AVAssetReaderTrackOutput(track: track, outputSettings: nil)
    reader.add(output)
    guard reader.startReading() else { fatalError("Cannot read compressed video") }
    var hash = SHA256()
    var times = [Double]()
    while let sample = output.copyNextSampleBuffer() {
        guard let block = CMSampleBufferGetDataBuffer(sample) else {
            // AVFoundation may emit an empty marker sample after compressed frames.
            guard CMSampleBufferGetTotalSampleSize(sample) == 0 else {
                fatalError("Nonempty video sample has no accessible data buffer")
            }
            continue
        }
        let count = CMBlockBufferGetDataLength(block)
        var data = Data(count: count)
        data.withUnsafeMutableBytes { raw in
            _ = CMBlockBufferCopyDataBytes(block, atOffset: 0, dataLength: count, destination: raw.baseAddress!)
        }
        hash.update(data: data)
        times.append(CMTimeGetSeconds(CMSampleBufferGetPresentationTimeStamp(sample)))
    }
    guard reader.status == .completed else { fatalError("Compressed video verification failed") }
    return ["compressed_video_sha256": hash.finalize().map { String(format: "%02x", $0) }.joined(),
            "frame_count": times.count, "presentation_times_seconds": times,
            "duration_seconds": CMTimeGetSeconds(track.timeRange.duration),
            "fps": track.nominalFrameRate]
}
let before = try videoFingerprint(videoURL)
let after = try videoFingerprint(outputURL)
guard before["compressed_video_sha256"] as! String == after["compressed_video_sha256"] as! String,
      before["presentation_times_seconds"] as! [Double] == after["presentation_times_seconds"] as! [Double] else {
    fatalError("Video payload or timing changed")
}
let report: [String: Any] = [
    "picture_source": args[1], "original_audio": args[2], "reference_audio": args[3],
    "output": args[5], "mixed_wav": args[4], "reference_gain": referenceGain,
    "original_gain": 1.0, "master_gain": masterGain,
    "reference_edge_fade_ms": 12, "sample_rate": 48000, "channels": 2,
    "mixed_pcm_peak_dbfs": 20 * log10(Double(max(peak * masterGain, 1e-12))),
    "mixed_pcm_rms_dbfs": 20 * log10(sqrt(squares / Double(frameCount * 2))),
    "picture_bitstream_and_timestamps_unchanged": true,
    "source_video_fingerprint": before, "output_video_fingerprint": after,
    "audio_content_note": "Reference is the complete native shot-03 take-01 soundtrack, not an isolated train stem; it may also carry breathing and footsteps.",
    "review_status": "technical_checks_passed_pending_user_listening"
]
let reportURL = outputURL.deletingPathExtension().appendingPathExtension("audio-edit.json")
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys])
    .write(to: reportURL)
print("output=\(outputURL.path)")
print("video_payload_and_timestamps_unchanged=true; frames=\(before["frame_count"]!)")
print("reference_gain=\(referenceGain), master_gain=\(masterGain), pcm_peak_dbfs=\(report["mixed_pcm_peak_dbfs"]!), pcm_rms_dbfs=\(report["mixed_pcm_rms_dbfs"]!)")
