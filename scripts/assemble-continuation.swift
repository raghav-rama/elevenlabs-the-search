import Foundation
import AVFoundation
import CryptoKit

// Derived from assemble-opening.swift for VO-led continuation previews.
// Keeps source speed; allows explicit clip gains and ducks native audio under VO.
struct Clip: Decodable {
    let shot: String, picture: String, audio: String
    let source_in_frames: Int, duration_frames: Int
    let audio_gain_db: Double?
}
struct Bridge: Decodable {
    let source: String
    let source_in_seconds: Double, timeline_start_seconds: Double, duration_seconds: Double, gain_db: Double
}
struct Duck: Decodable {
    let start_seconds: Double, end_seconds: Double, gain_db: Double, fade_seconds: Double
}
struct Plan: Decodable {
    let title: String
    let fps: Int32, render_width: Int, render_height: Int
    let audio_target_rms_dbfs: Double, audio_gain_limit_db: Double, crossfade_half_seconds: Double
    let clips: [Clip]
    let audio_bridges: [Bridge]?
    let audio_ducks: [Duck]?
    let framing: String?
}
guard CommandLine.arguments.count == 3 else { fatalError("Usage: assemble-continuation.swift TIMELINE.json OUTPUT.mp4") }
let planURL = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let wave = output.deletingPathExtension().appendingPathExtension("mix.wav")
let record = output.deletingPathExtension().appendingPathExtension("edit.json")
for url in [output, wave, record] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let plan = try JSONDecoder().decode(Plan.self, from: Data(contentsOf: planURL))
guard plan.fps > 0, !plan.clips.isEmpty else { fatalError("Invalid timeline") }
let rate = 48000.0
let totalFrames = plan.clips.reduce(0) { $0 + $1.duration_frames }
let duration = CMTime(value: Int64(totalFrames), timescale: plan.fps)
let sampleCount = Int((duration.seconds * rate).rounded())
let halfFade = Int((plan.crossfade_half_seconds * rate).rounded())
guard halfFade > 0 else { fatalError("Crossfade must be positive") }
var mixed = [Float](repeating: 0, count: sampleCount * 2)
let composition = AVMutableComposition()
var instructions: [AVMutableVideoCompositionInstruction] = []
var reports: [[String: Any]] = []
var cursorFrames = 0
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url, options: .mappedIfSafe)).map { String(format: "%02x", $0) }.joined()
}
func decodeAudio(_ url: URL) throws -> [Float] {
    let asset = AVURLAsset(url: url)
    guard let track = asset.tracks(withMediaType: .audio).first else { fatalError("Missing audio: \(url.path)") }
    let reader = try AVAssetReader(asset: asset)
    let out = AVAssetReaderTrackOutput(track: track, outputSettings: [
        AVFormatIDKey: kAudioFormatLinearPCM, AVSampleRateKey: rate, AVNumberOfChannelsKey: 2,
        AVLinearPCMBitDepthKey: 32, AVLinearPCMIsFloatKey: true,
        AVLinearPCMIsBigEndianKey: false, AVLinearPCMIsNonInterleaved: false
    ])
    reader.add(out)
    guard reader.startReading() else { fatalError("Audio read failed") }
    var result = [Float]()
    while let sample = out.copyNextSampleBuffer() {
        guard let block = CMSampleBufferGetDataBuffer(sample) else { continue }
        let bytes = CMBlockBufferGetDataLength(block)
        var values = [Float](repeating: 0, count: bytes / MemoryLayout<Float>.size)
        values.withUnsafeMutableBytes { ptr in
            guard CMBlockBufferCopyDataBytes(block, atOffset: 0, dataLength: bytes, destination: ptr.baseAddress!) == noErr else { fatalError("Audio buffer read failed") }
        }
        result.append(contentsOf: values)
    }
    guard reader.status == .completed else { fatalError("Audio decode failed") }
    return result
}
for (index, clip) in plan.clips.enumerated() {
    guard clip.source_in_frames >= 0, clip.duration_frames > 0 else { fatalError("Invalid cut") }
    let pictureURL = URL(fileURLWithPath: clip.picture), audioURL = URL(fileURLWithPath: clip.audio)
    let asset = AVURLAsset(url: pictureURL)
    guard let source = asset.tracks(withMediaType: .video).first else { fatalError("Missing picture") }
    let start = CMTime(value: Int64(clip.source_in_frames), timescale: plan.fps)
    let length = CMTime(value: Int64(clip.duration_frames), timescale: plan.fps)
    let at = CMTime(value: Int64(cursorFrames), timescale: plan.fps)
    guard CMTimeCompare(CMTimeAdd(start, length), CMTimeRangeGetEnd(source.timeRange)) <= 0,
          abs(source.nominalFrameRate - Float(plan.fps)) < 0.1 else { fatalError("Source range or frame rate mismatch") }
    let track = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)!
    try track.insertTimeRange(CMTimeRange(start: start, duration: length), of: source, at: at)
    let bounds = CGRect(origin: .zero, size: source.naturalSize).applying(source.preferredTransform)
    let scaleX = Double(plan.render_width) / abs(bounds.width)
    let scaleY = Double(plan.render_height) / abs(bounds.height)
    let scale = plan.framing == "fill" ? max(scaleX, scaleY) : min(scaleX, scaleY)
    let transform = source.preferredTransform
        .concatenating(CGAffineTransform(translationX: -bounds.minX, y: -bounds.minY))
        .concatenating(CGAffineTransform(scaleX: scale, y: scale))
        .concatenating(CGAffineTransform(translationX: (Double(plan.render_width) - abs(bounds.width) * scale) / 2,
                                         y: (Double(plan.render_height) - abs(bounds.height) * scale) / 2))
    let layer = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
    layer.setTransform(transform, at: at)
    let instruction = AVMutableVideoCompositionInstruction()
    instruction.timeRange = CMTimeRange(start: at, duration: length)
    instruction.layerInstructions = [layer]
    instructions.append(instruction)

    let sound = try decodeAudio(audioURL)
    let sourceStart = Int((start.seconds * rate).rounded())
    let destStart = Int((at.seconds * rate).rounded())
    let samples = Int((length.seconds * rate).rounded())
    guard (sourceStart + samples) * 2 <= sound.count else { fatalError("Audio too short") }
    var sum = 0.0
    for f in sourceStart..<(sourceStart + samples) { for c in 0..<2 { sum += pow(Double(sound[f * 2 + c]), 2) } }
    let rms = sqrt(sum / Double(samples * 2))
    let sourceDb = 20 * log10(max(rms, 1e-12))
    let gainDb = clip.audio_gain_db ?? min(plan.audio_gain_limit_db, max(-plan.audio_gain_limit_db, plan.audio_target_rms_dbfs - sourceDb))
    let gain = pow(10, gainDb / 20)
    // Audio overlaps centered on picture cuts, using real source handles where available.
    // At source-in zero, the incoming sound begins exactly at the cut with an edge fade.
    let pre = index == 0 ? 0 : min(halfFade, sourceStart)
    let post = index == plan.clips.count - 1 ? 0 : min(halfFade, sound.count / 2 - sourceStart - samples)
    for local in (-pre)..<(samples + post) {
        let dest = destStart + local
        guard dest >= 0, dest < sampleCount else { continue }
        var weight = 1.0
        if index > 0 && local < halfFade {
            weight *= sin(max(0, min(1, Double(local + pre) / Double(halfFade + pre))) * .pi / 2)
        }
        if index < plan.clips.count - 1 && local >= samples - halfFade {
            weight *= cos(max(0, min(1, Double(local - samples + halfFade) / Double(halfFade + post))) * .pi / 2)
        }
        for c in 0..<2 { mixed[dest * 2 + c] += Float(gain * weight) * sound[(sourceStart + local) * 2 + c] }
    }
    reports.append(["shot": clip.shot, "picture": clip.picture, "picture_sha256": try hash(pictureURL),
                    "audio": clip.audio, "audio_sha256": try hash(audioURL),
                    "source_in_seconds": start.seconds, "duration_seconds": length.seconds,
                    "timeline_start_seconds": at.seconds, "source_audio_rms_dbfs": sourceDb,
                    "audio_gain_db": gainDb, "pre_handle_samples": pre, "post_handle_samples": post])
    cursorFrames += clip.duration_frames
}
// Duck the native mix before adding the separate narration bridges.
for duck in plan.audio_ducks ?? [] {
    guard duck.start_seconds >= 0, duck.end_seconds > duck.start_seconds,
          duck.fade_seconds > 0, duck.gain_db <= 0 else { fatalError("Invalid audio duck") }
    let target = pow(10, duck.gain_db / 20)
    for f in 0..<sampleCount {
        let t = Double(f) / rate
        let weight: Double
        if t < duck.start_seconds - duck.fade_seconds || t > duck.end_seconds + duck.fade_seconds { continue }
        else if t < duck.start_seconds { weight = (t - duck.start_seconds + duck.fade_seconds) / duck.fade_seconds }
        else if t > duck.end_seconds { weight = (duck.end_seconds + duck.fade_seconds - t) / duck.fade_seconds }
        else { weight = 1 }
        let gain = Float(1 + (target - 1) * max(0, min(1, weight)))
        mixed[f * 2] *= gain; mixed[f * 2 + 1] *= gain
    }
}
var bridgeReports: [[String: Any]] = []
for bridge in plan.audio_bridges ?? [] {
    let url = URL(fileURLWithPath: bridge.source)
    let sound = try decodeAudio(url)
    let sourceStart = Int((bridge.source_in_seconds * rate).rounded())
    let at = Int((bridge.timeline_start_seconds * rate).rounded())
    let count = Int((bridge.duration_seconds * rate).rounded())
    guard sourceStart >= 0, at >= 0, count > 0,
          (sourceStart + count) * 2 <= sound.count, at + count <= sampleCount else {
        print("Invalid audio bridge: source=\(bridge.source), requested_frames=\(count), decoded_frames=\(sound.count / 2), source_start=\(sourceStart), timeline_start=\(at), timeline_frames=\(sampleCount)")
        exit(1)
    }
    let gain = Float(pow(10, bridge.gain_db / 20))
    for f in 0..<count {
        let fade = Float(min(1.0, Double(f) / Double(halfFade), Double(count - 1 - f) / Double(halfFade)))
        for c in 0..<2 { mixed[(at + f) * 2 + c] += sound[(sourceStart + f) * 2 + c] * gain * fade }
    }
    bridgeReports.append(["source": bridge.source, "source_sha256": try hash(url),
                          "source_in_seconds": bridge.source_in_seconds, "timeline_start_seconds": bridge.timeline_start_seconds,
                          "duration_seconds": bridge.duration_seconds, "gain_db": bridge.gain_db])
}
let edge = 384 // 8 ms start/end fade, no change to picture timing.
for f in 0..<sampleCount {
    let fade = min(1.0, Double(f) / Double(edge), Double(sampleCount - 1 - f) / Double(edge))
    mixed[f * 2] *= Float(fade); mixed[f * 2 + 1] *= Float(fade)
}
let peak = mixed.map { abs($0) }.max()!
let master = min(1.0, pow(10, -1.5 / 20) / Double(max(peak, 1e-12)))
let format = AVAudioFormat(standardFormatWithSampleRate: rate, channels: 2)!
let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(sampleCount))!
buffer.frameLength = AVAudioFrameCount(sampleCount)
var mixSquares = 0.0
for f in 0..<sampleCount { for c in 0..<2 {
    let value = mixed[f * 2 + c] * Float(master)
    buffer.floatChannelData![c][f] = value; mixSquares += Double(value * value)
} }
do {
    let file = try AVAudioFile(forWriting: wave, settings: format.settings)
    try file.write(from: buffer)
}
let audioAsset = AVURLAsset(url: wave)
let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
try audioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: duration), of: audioAsset.tracks(withMediaType: .audio).first!, at: .zero)
let videoComposition = AVMutableVideoComposition()
videoComposition.renderSize = CGSize(width: plan.render_width, height: plan.render_height)
videoComposition.frameDuration = CMTime(value: 1, timescale: plan.fps)
videoComposition.instructions = instructions
let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
exporter.videoComposition = videoComposition
exporter.timeRange = CMTimeRange(start: .zero, duration: duration)
exporter.outputURL = output; exporter.outputFileType = .mp4; exporter.shouldOptimizeForNetworkUse = true
let done = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { done.signal() }; done.wait()
guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
let result = AVURLAsset(url: output)
let resultVideo = result.tracks(withMediaType: .video).first!
guard abs(result.duration.seconds - duration.seconds) < 0.06,
      abs(resultVideo.nominalFrameRate - Float(plan.fps)) < 0.01,
      result.tracks(withMediaType: .audio).count == 1 else { fatalError("Output metadata mismatch") }
let readBack = try decodeAudio(output)
let decodedPeak = readBack.map { abs($0) }.max()!
let report: [String: Any] = [
    "title": plan.title, "timeline": CommandLine.arguments[1], "timeline_sha256": try hash(planURL), "clips": reports, "audio_bridges": bridgeReports,
    "output": CommandLine.arguments[2], "output_sha256": try hash(output),
    "duration_seconds": result.duration.seconds, "fps": resultVideo.nominalFrameRate,
    "resolution": [resultVideo.naturalSize.width, resultVideo.naturalSize.height], "framing": plan.framing ?? "fit",
    "audio_tracks": 1, "mixed_wav": wave.path, "master_gain": master,
    "pcm_peak_dbfs": 20 * log10(max(Double(peak) * master, 1e-12)),
    "decoded_aac_peak_dbfs": 20 * log10(max(Double(decodedPeak), 1e-12)),
    "pcm_rms_dbfs": 20 * log10(max(sqrt(mixSquares / Double(sampleCount * 2)), 1e-12)),
    "crossfade_half_seconds": plan.crossfade_half_seconds, "speed_multiplier": 1.0,
    "script": "scripts/assemble-continuation.swift", "review_status": "pending_user_playback_and_listening",
    "notes": "Hard picture cuts; source frame ranges at original speed, aspect conformed according to the recorded framing setting. Picture re-encoded, not bitstream copied. Audio levels adjusted conservatively using RMS, not perceptual loudness. Native audio ducked under the supplied narration according to the timeline; no synthesis or speech removal by this script. Original source files remain untouched. Audio content and subjective transitions require listening review."
]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print("output=\(output.path) duration=\(result.duration.seconds) fps=\(resultVideo.nominalFrameRate) pcm_peak_dbfs=\(report["pcm_peak_dbfs"]!) aac_peak_dbfs=\(report["decoded_aac_peak_dbfs"]!)")
