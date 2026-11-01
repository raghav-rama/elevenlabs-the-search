import Foundation
import AVFoundation
import CoreImage
import CryptoKit

// A brief editorial cue, not a reconstructed physical camera move.
struct Cue: Decodable {
    let input: String, output: String
    let fps: Int32, start_frame: Int, end_frame_exclusive: Int
    let max_shift_fraction: Double, max_blur_pixels: Double
}
guard CommandLine.arguments.count == 2 else { fatalError("Usage: add-whip-pan-cue.swift CONFIG.json") }
let configURL = URL(fileURLWithPath: CommandLine.arguments[1])
let c = try JSONDecoder().decode(Cue.self, from: Data(contentsOf: configURL))
guard c.fps > 0, c.start_frame >= 0, c.end_frame_exclusive > c.start_frame + 1,
      (0...0.2).contains(c.max_shift_fraction), (0...100).contains(c.max_blur_pixels) else {
    fatalError("Invalid cue parameters")
}
let input = URL(fileURLWithPath: c.input), output = URL(fileURLWithPath: c.output)
let recordURL = output.deletingPathExtension().appendingPathExtension("cue.json")
guard !FileManager.default.fileExists(atPath: output.path),
      !FileManager.default.fileExists(atPath: recordURL.path) else { fatalError("Use fresh outputs") }
let asset = AVURLAsset(url: input)
guard let track = asset.tracks(withMediaType: .video).first,
      abs(track.nominalFrameRate - Float(c.fps)) < 0.01,
      Double(c.end_frame_exclusive) / Double(c.fps) <= asset.duration.seconds else {
    fatalError("Invalid source or range")
}
let composition = AVVideoComposition(asset: asset) { request in
    let frame = Int((request.compositionTime.seconds * Double(c.fps)).rounded())
    let source = request.sourceImage
    guard frame >= c.start_frame, frame < c.end_frame_exclusive else {
        request.finish(with: source, context: nil); return
    }
    let progress = Double(frame - c.start_frame + 1) / Double(c.end_frame_exclusive - c.start_frame)
    // A leftward head turn sends the seen environment to screen-right.
    let shifted = source.clampedToExtent().transformed(by:
        CGAffineTransform(translationX: source.extent.width * c.max_shift_fraction * progress, y: 0))
    let blurred = shifted.applyingFilter("CIMotionBlur", parameters: [
        kCIInputRadiusKey: c.max_blur_pixels * progress, kCIInputAngleKey: 0
    ]).cropped(to: source.extent)
    request.finish(with: blurred, context: nil)
}
let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
exporter.videoComposition = composition
exporter.outputURL = output; exporter.outputFileType = .mp4
exporter.timeRange = CMTimeRange(start: .zero, duration: asset.duration)
exporter.shouldOptimizeForNetworkUse = true
let done = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { done.signal() }; done.wait()
guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
let record: [String: Any] = [
    "source_file": c.input, "source_sha256": try hash(input),
    "output_file": c.output, "output_sha256": try hash(output),
    "config_file": configURL.path, "config_sha256": try hash(configURL),
    "start_frame": c.start_frame, "end_frame_exclusive": c.end_frame_exclusive,
    "max_shift_fraction": c.max_shift_fraction, "max_blur_pixels": c.max_blur_pixels,
    "duration_seconds": asset.duration.seconds, "source_modified": false,
    "retimed": false, "script": "scripts/add-whip-pan-cue.swift",
    "note": "Editorial screen-right shift and motion blur suggest a left glance. This is not a generated physical head rotation. Existing source audio retained through export; no new synthesis."
]
try JSONSerialization.data(withJSONObject: record, options: [.prettyPrinted, .sortedKeys]).write(to: recordURL)
print("Saved \(c.output), cue frames \(c.start_frame)..<\(c.end_frame_exclusive)")
