import Foundation
import AVFoundation
import CoreGraphics

// Prepare a silent, horizontally mirrored 3-second motion driver.
// All timing changes apply to the supplied slow-motion reference only.
guard CommandLine.arguments.count == 3 else {
    fatalError("Usage: swift prepare-reference.swift INPUT.mp4 OUTPUT.mp4")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
guard !FileManager.default.fileExists(atPath: output.path) else {
    fatalError("Output already exists; choose a new version.")
}
let asset = AVURLAsset(url: input)
guard let sourceTrack = asset.tracks(withMediaType: .video).first else {
    fatalError("No video track")
}
let start = CMTime(seconds: 1.0, preferredTimescale: 60000)
let sourceDuration = CMTime(seconds: 25.2, preferredTimescale: 60000)
let targetDuration = CMTime(seconds: 3.0, preferredTimescale: 60000)
guard CMTimeCompare(CMTimeAdd(start, sourceDuration), asset.duration) <= 0 else {
    fatalError("Source is too short")
}
let composition = AVMutableComposition()
let track = composition.addMutableTrack(withMediaType: .video,
    preferredTrackID: kCMPersistentTrackID_Invalid)!
try track.insertTimeRange(CMTimeRange(start: start, duration: sourceDuration),
                         of: sourceTrack, at: .zero)
track.scaleTimeRange(CMTimeRange(start: .zero, duration: sourceDuration),
                     toDuration: targetDuration)

let bounds = CGRect(origin: .zero, size: sourceTrack.naturalSize)
    .applying(sourceTrack.preferredTransform)
let width = abs(bounds.width)
let height = abs(bounds.height)
let orient = sourceTrack.preferredTransform.concatenating(
    CGAffineTransform(translationX: -bounds.minX, y: -bounds.minY))
let mirror = CGAffineTransform(a: -1, b: 0, c: 0, d: 1, tx: width, ty: 0)
let layer = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
layer.setTransform(orient.concatenating(mirror), at: .zero)
let instruction = AVMutableVideoCompositionInstruction()
instruction.timeRange = CMTimeRange(start: .zero, duration: targetDuration)
instruction.layerInstructions = [layer]
let videoComposition = AVMutableVideoComposition()
videoComposition.renderSize = CGSize(width: width, height: height)
videoComposition.frameDuration = CMTime(value: 1, timescale: 24)
videoComposition.instructions = [instruction]

guard let exporter = AVAssetExportSession(asset: composition,
    presetName: AVAssetExportPresetHighestQuality) else {
    fatalError("Cannot create exporter")
}
exporter.outputURL = output
exporter.outputFileType = .mp4
exporter.videoComposition = videoComposition
exporter.shouldOptimizeForNetworkUse = true
let finished = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { finished.signal() }
finished.wait()
guard exporter.status == .completed else {
    fatalError("Export failed: \(String(describing: exporter.error))")
}
let result = AVURLAsset(url: output)
let video = result.tracks(withMediaType: .video).first!
print("output=\(output.path)")
print("duration_seconds=\(CMTimeGetSeconds(result.duration)), fps=\(video.nominalFrameRate), size=\(video.naturalSize), audio_tracks=\(result.tracks(withMediaType: .audio).count)")
print("source_range_seconds=1.0..<26.2, reference_speed_multiplier=8.4, horizontal_flip=true")
