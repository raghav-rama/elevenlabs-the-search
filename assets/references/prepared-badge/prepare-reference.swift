import Foundation
import AVFoundation
import CoreGraphics
import CryptoKit

// Shot 2 motion reference: constant crop, selectable reference-only speed, silent.
guard (3...4).contains(CommandLine.arguments.count) else {
    fatalError("Usage: prepare-reference.swift INPUT OUTPUT.mp4 [SPEED=1.0]")
}
let speed = CommandLine.arguments.count == 4 ? Double(CommandLine.arguments[3]) : 1.0
guard let speed = speed, speed.isFinite, speed > 0 else { fatalError("Speed must be positive and finite") }
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("preparation.json")
for url in [output, record] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let asset = AVURLAsset(url: input)
guard let sourceTrack = asset.tracks(withMediaType: .video).first else { fatalError("No video track") }
let start = CMTime(seconds: 3, preferredTimescale: 60000)
let duration = CMTime(seconds: 3, preferredTimescale: 60000)
let sourceDuration = CMTime(seconds: 3 * speed, preferredTimescale: 60000)
guard CMTimeCompare(CMTimeAdd(start, sourceDuration), asset.duration) <= 0 else { fatalError("Source is too short") }
let composition = AVMutableComposition()
let track = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)!
try track.insertTimeRange(CMTimeRange(start: start, duration: sourceDuration), of: sourceTrack, at: .zero)
track.scaleTimeRange(CMTimeRange(start: .zero, duration: sourceDuration), toDuration: duration)
let bounds = CGRect(origin: .zero, size: sourceTrack.naturalSize).applying(sourceTrack.preferredTransform)
let width = abs(bounds.width), height = abs(bounds.height)
guard abs(width / height - 16.0 / 9.0) < 0.02 else { fatalError("Recipe expects landscape 16:9 source") }
// Normalized crop in displayed video coordinates, origin at top left.
let crop = CGRect(x: 0, y: 0, width: width * 0.80, height: height * 0.80)
let transform = sourceTrack.preferredTransform
    .concatenating(CGAffineTransform(translationX: -bounds.minX, y: -bounds.minY))
    .concatenating(CGAffineTransform(translationX: -crop.minX, y: -crop.minY))
    .concatenating(CGAffineTransform(scaleX: 1280 / crop.width, y: 720 / crop.height))
let layer = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
layer.setTransform(transform, at: .zero)
let instruction = AVMutableVideoCompositionInstruction()
instruction.timeRange = CMTimeRange(start: .zero, duration: duration)
instruction.layerInstructions = [layer]
let videoComposition = AVMutableVideoComposition()
videoComposition.renderSize = CGSize(width: 1280, height: 720)
videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
videoComposition.instructions = [instruction]
guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPreset1280x720) else {
    fatalError("Cannot create exporter")
}
exporter.outputURL = output
exporter.outputFileType = .mp4
exporter.videoComposition = videoComposition
exporter.shouldOptimizeForNetworkUse = true
let finished = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { finished.signal() }
finished.wait()
guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
let result = AVURLAsset(url: output)
let resultTrack = result.tracks(withMediaType: .video).first!
guard result.tracks(withMediaType: .audio).isEmpty,
      abs(CMTimeGetSeconds(result.duration) - 3) < 0.04,
      resultTrack.naturalSize == CGSize(width: 1280, height: 720) else { fatalError("Output metadata mismatch") }
func sha256(_ url: URL) throws -> String {
    let data = try Data(contentsOf: url, options: .mappedIfSafe)
    return SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
}
let report: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try sha256(input),
    "source_duration_seconds": CMTimeGetSeconds(asset.duration),
    "source_nominal_fps": sourceTrack.nominalFrameRate,
    "source_display_size": [width, height],
    "source_range_seconds": [3.0, 3.0 + 3.0 * speed], "speed_multiplier": speed,
    "crop_normalized_top_left": ["x": 0.0, "y": 0.0, "width": 0.80, "height": 0.80],
    "horizontal_flip": false, "stabilization_applied": false, "audio_removed": true,
    "output_file": CommandLine.arguments[2], "output_sha256": try sha256(output),
    "file_size": try output.resourceValues(forKeys: [.fileSizeKey]).fileSize!,
    "duration_seconds": CMTimeGetSeconds(result.duration), "fps": resultTrack.nominalFrameRate,
    "resolution": [1280, 720], "audio_tracks": result.tracks(withMediaType: .audio).count,
    "script": "assets/references/prepared-badge/prepare-reference.swift",
    "review_status": "prepared_for_visual_review", "model_submission": false,
    "notes": "User-recorded badge motion only. Appearance differs from Riley; pair with her badge still. Fixed crop, explicit reference-only time scaling, no looping or motion interpolation. Generated ad takes are unchanged."
]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print(String(data: try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]), encoding: .utf8)!)
