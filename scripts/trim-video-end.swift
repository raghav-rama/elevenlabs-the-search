import Foundation
import AVFoundation
import CryptoKit

guard CommandLine.arguments.count == 4,
      let keepFrames = Int64(CommandLine.arguments[3]), keepFrames > 0 else {
    fatalError("Usage: trim-video-end.swift INPUT OUTPUT.mov KEEP_FRAMES")
}
let source = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("trim.json")
for url in [output, record] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let asset = AVURLAsset(url: source)
guard let video = asset.tracks(withMediaType: .video).first else { fatalError("No video track") }
let fps = Double(video.nominalFrameRate)
guard fps > 0, fps.rounded() == fps, fps <= Double(Int32.max) else {
    fatalError("This helper requires an integer source frame rate")
}
let end = CMTime(value: keepFrames, timescale: Int32(fps))
guard CMTimeCompare(end, asset.duration) < 0 else { fatalError("Trim endpoint must precede source end") }
guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough) else {
    fatalError("Passthrough export unavailable")
}
exporter.outputURL = output
exporter.outputFileType = .mov
exporter.timeRange = CMTimeRange(start: .zero, duration: end)
let finished = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { finished.signal() }
finished.wait()
guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
let result = AVURLAsset(url: output)
guard abs(result.duration.seconds - end.seconds) < 0.001,
      result.tracks(withMediaType: .audio).count == asset.tracks(withMediaType: .audio).count else {
    fatalError("Output duration or audio track count differs")
}
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
let details: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try hash(source),
    "output_file": CommandLine.arguments[2], "output_sha256": try hash(output),
    "source_duration_seconds": asset.duration.seconds, "output_duration_seconds": result.duration.seconds,
    "requested_keep_frames": keepFrames, "nominal_fps": fps,
    "removed_tail_seconds": asset.duration.seconds - end.seconds,
    "audio_tracks": result.tracks(withMediaType: .audio).count,
    "export_preset": AVAssetExportPresetPassthrough,
    "source_modified": false, "playback_speed_changed": false,
    "script": "scripts/trim-video-end.swift",
    "notes": "Trim from time zero to the requested frame endpoint, including audio. Passthrough export; decoded frame verification is recorded separately."
]
let data = try JSONSerialization.data(withJSONObject: details, options: [.prettyPrinted, .sortedKeys])
try data.write(to: record)
print(String(data: data, encoding: .utf8)!)
