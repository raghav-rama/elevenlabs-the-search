import Foundation
import AVFoundation
import CryptoKit

// Whole-clip speed preview, including synchronized pitch-preserved native audio.
guard CommandLine.arguments.count == 4,
      let speed = Double(CommandLine.arguments[3]), speed.isFinite, speed > 0 else {
    fatalError("Usage: retime-video.swift INPUT OUTPUT.mp4 SPEED")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("retime.json")
for url in [output, record] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let source = AVURLAsset(url: input)
guard let sourceVideo = source.tracks(withMediaType: .video).first,
      source.duration.seconds.isFinite, source.duration.seconds > 0 else { fatalError("Invalid source video") }
let composition = AVMutableComposition()
for mediaType in [AVMediaType.video, AVMediaType.audio] {
    for sourceTrack in source.tracks(withMediaType: mediaType) {
        let track = composition.addMutableTrack(withMediaType: mediaType, preferredTrackID: kCMPersistentTrackID_Invalid)!
        try track.insertTimeRange(sourceTrack.timeRange, of: sourceTrack, at: sourceTrack.timeRange.start)
        track.preferredTransform = sourceTrack.preferredTransform
    }
}
let sourceDuration = composition.duration
let targetDuration = CMTimeMultiplyByFloat64(sourceDuration, multiplier: 1 / speed)
composition.scaleTimeRange(CMTimeRange(start: .zero, duration: sourceDuration), toDuration: targetDuration)
guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
    fatalError("Cannot create exporter")
}
exporter.outputURL = output
exporter.outputFileType = .mp4
exporter.audioTimePitchAlgorithm = .spectral
exporter.shouldOptimizeForNetworkUse = true
let finished = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { finished.signal() }
finished.wait()
guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
let result = AVURLAsset(url: output)
guard let video = result.tracks(withMediaType: .video).first,
      abs(result.duration.seconds - targetDuration.seconds) < 0.06,
      video.naturalSize == sourceVideo.naturalSize,
      result.tracks(withMediaType: .audio).count == source.tracks(withMediaType: .audio).count else {
    fatalError("Output metadata mismatch")
}
func sha256(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url, options: .mappedIfSafe)).map { String(format: "%02x", $0) }.joined()
}
let report: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try sha256(input),
    "source_duration_seconds": sourceDuration.seconds, "speed_multiplier": speed,
    "output_file": CommandLine.arguments[2], "output_sha256": try sha256(output),
    "duration_seconds": result.duration.seconds, "fps": video.nominalFrameRate,
    "resolution": [video.naturalSize.width, video.naturalSize.height],
    "audio_tracks": result.tracks(withMediaType: .audio).count,
    "audio_processing": "Same speed change as picture, AVFoundation spectral pitch preservation requested; listening review pending.",
    "script": "scripts/retime-video.swift", "review_status": "pending_user_review",
    "notes": "Whole generated clip retimed at user request. Source unchanged. Re-encoded locally; no AI generation or optical-flow interpolation requested."
]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print(String(data: try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]), encoding: .utf8)!)
