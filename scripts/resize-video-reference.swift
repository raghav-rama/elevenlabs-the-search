import Foundation
import AVFoundation
import CryptoKit

// Uniformly resize a provider reference without changing its timing or framing.
guard CommandLine.arguments.count == 5,
      let width = Int(CommandLine.arguments[3]), let height = Int(CommandLine.arguments[4]),
      width > 0, height > 0, width % 2 == 0, height % 2 == 0 else {
    fatalError("Usage: resize-video-reference.swift INPUT OUTPUT.mp4 WIDTH HEIGHT (even dimensions, same aspect)")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("preparation.json")
for url in [output, record] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let asset = AVURLAsset(url: input)
guard let track = asset.tracks(withMediaType: .video).first else { fatalError("Missing video") }
let bounds = CGRect(origin: .zero, size: track.naturalSize).applying(track.preferredTransform)
let sx = Double(width) / abs(bounds.width), sy = Double(height) / abs(bounds.height)
guard abs(sx - sy) < 0.000001, sx >= 1 else { fatalError("Require uniform scale >= 1, without crop/padding") }
let fps = Int32(track.nominalFrameRate.rounded())
guard fps > 0, abs(track.nominalFrameRate - Float(fps)) < 0.001 else {
    fatalError("This helper requires an integer frame rate")
}
let layer = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
layer.setTransform(track.preferredTransform
    .concatenating(CGAffineTransform(translationX: -bounds.minX, y: -bounds.minY))
    .concatenating(CGAffineTransform(scaleX: sx, y: sy)), at: .zero)
let instruction = AVMutableVideoCompositionInstruction()
instruction.timeRange = CMTimeRange(start: .zero, duration: asset.duration)
instruction.layerInstructions = [layer]
let composition = AVMutableVideoComposition()
composition.renderSize = CGSize(width: width, height: height)
composition.frameDuration = CMTime(value: 1, timescale: fps)
composition.instructions = [instruction]
guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
    fatalError("Cannot create exporter")
}
exporter.outputURL = output
exporter.outputFileType = .mp4
exporter.videoComposition = composition
exporter.timeRange = CMTimeRange(start: .zero, duration: asset.duration)
exporter.shouldOptimizeForNetworkUse = true
let done = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { done.signal() }
done.wait()
guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
let result = AVURLAsset(url: output)
guard let rendered = result.tracks(withMediaType: .video).first,
      abs(result.duration.seconds - asset.duration.seconds) < 0.001,
      abs(rendered.nominalFrameRate - track.nominalFrameRate) < 0.001,
      rendered.naturalSize.width == Double(width), rendered.naturalSize.height == Double(height),
      result.tracks(withMediaType: .audio).count == asset.tracks(withMediaType: .audio).count else {
    fatalError("Output metadata mismatch")
}
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url, options: .mappedIfSafe)).map { String(format: "%02x", $0) }.joined()
}
let report: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try hash(input),
    "output_file": CommandLine.arguments[2], "output_sha256": try hash(output),
    "source_dimensions": [abs(bounds.width), abs(bounds.height)], "output_dimensions": [width, height],
    "output_pixel_count": width * height, "uniform_scale": sx,
    "source_duration_seconds": asset.duration.seconds, "output_duration_seconds": result.duration.seconds,
    "fps": rendered.nominalFrameRate, "audio_tracks": result.tracks(withMediaType: .audio).count,
    "motion_speed_changed": false, "crop_or_padding": false, "frame_interpolation": false,
    "source_modified": false, "script": "scripts/resize-video-reference.swift",
    "notes": "Uniform reference resize for provider input compatibility, not a generative upscale. Original duration and audio tracks retained; export may re-encode audio. No audio gain/filter, retiming, added frames, crop or padding requested."
]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print("output=\(output.path) size=\(width)x\(height) duration=\(result.duration.seconds) fps=\(rendered.nominalFrameRate) sha256=\(try hash(output))")
