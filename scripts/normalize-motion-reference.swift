import Foundation
import AVFoundation
import CryptoKit

// Constant-rate reference: sample by timestamp, then hold the final pose. No time scaling.
guard CommandLine.arguments.count == 5,
      let duration = Double(CommandLine.arguments[3]), duration.isFinite, duration > 0,
      let fps = Int32(CommandLine.arguments[4]), fps > 0, fps <= 120 else {
    fatalError("Usage: normalize-motion-reference.swift INPUT OUTPUT.mp4 SECONDS FPS")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("preparation.json")
for url in [output, record] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let asset = AVURLAsset(url: input)
guard let track = asset.tracks(withMediaType: .video).first, duration >= asset.duration.seconds else {
    fatalError("Need a video and a target duration at least as long as its source")
}
let reader = try AVAssetReader(asset: asset)
let decoded = AVAssetReaderTrackOutput(track: track, outputSettings: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA])
reader.add(decoded)
guard reader.startReading() else { fatalError("Cannot decode") }
var frames: [(time: CMTime, pixels: CVPixelBuffer)] = []
while let sample = decoded.copyNextSampleBuffer() {
    guard let pixels = CMSampleBufferGetImageBuffer(sample) else { fatalError("Missing frame") }
    frames.append((CMSampleBufferGetPresentationTimeStamp(sample), pixels))
}
guard reader.status == .completed, !frames.isEmpty else { fatalError("Decode failed") }
let writer = try AVAssetWriter(outputURL: output, fileType: .mp4)
let encoded = AVAssetWriterInput(mediaType: .video, outputSettings: [
    AVVideoCodecKey: AVVideoCodecType.h264,
    AVVideoWidthKey: Int(track.naturalSize.width), AVVideoHeightKey: Int(track.naturalSize.height),
    AVVideoCompressionPropertiesKey: [AVVideoAverageBitRateKey: 6000000, AVVideoAllowFrameReorderingKey: false]
])
encoded.transform = track.preferredTransform
let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: encoded, sourcePixelBufferAttributes: nil)
writer.add(encoded)
guard writer.startWriting() else { fatalError("Cannot encode") }
writer.startSession(atSourceTime: .zero)
let count = Int((duration * Double(fps)).rounded())
guard abs(Double(count) / Double(fps) - duration) < 0.0001 else { fatalError("Duration must contain a whole number of frames") }
var sourceIndex = 0
var sampleMap: [[String: Any]] = []
for frameIndex in 0..<count {
    let time = CMTime(value: Int64(frameIndex), timescale: fps)
    while sourceIndex + 1 < frames.count && CMTimeCompare(frames[sourceIndex + 1].time, time) <= 0 { sourceIndex += 1 }
    while !encoded.isReadyForMoreMediaData {
        guard writer.status == .writing else { fatalError("Encoder failed") }
        Thread.sleep(forTimeInterval: 0.002)
    }
    guard adaptor.append(frames[sourceIndex].pixels, withPresentationTime: time) else {
        fatalError("Append failed: \(String(describing: writer.error))")
    }
    sampleMap.append(["output_seconds": time.seconds, "source_seconds": frames[sourceIndex].time.seconds])
}
writer.endSession(atSourceTime: CMTime(value: Int64(count), timescale: fps))
encoded.markAsFinished()
let done = DispatchSemaphore(value: 0)
writer.finishWriting { done.signal() }
done.wait()
guard writer.status == .completed else { fatalError("Export failed") }
let result = AVURLAsset(url: output)
let resultVideo = result.tracks(withMediaType: .video).first!
guard abs(result.duration.seconds - duration) < 0.001,
      abs(resultVideo.nominalFrameRate - Float(fps)) < 0.01,
      result.tracks(withMediaType: .audio).isEmpty else { fatalError("Output metadata mismatch") }
func sha256(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
let report: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try sha256(input),
    "source_duration_seconds": asset.duration.seconds, "source_fps": track.nominalFrameRate,
    "output_file": CommandLine.arguments[2], "output_sha256": try sha256(output),
    "duration_seconds": result.duration.seconds, "fps": resultVideo.nominalFrameRate,
    "file_size": try output.resourceValues(forKeys: [.fileSizeKey]).fileSize!,
    "output_frames": count, "audio_removed": true, "motion_speed_changed": false,
    "sample_map": sampleMap, "script": "scripts/normalize-motion-reference.swift",
    "notes": "Timestamp-based frame selection preserves playback pace; final pose repeats after source picture ends. No optical flow, looping or time scaling. Source is unchanged."
]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print("duration=\(result.duration.seconds) fps=\(resultVideo.nominalFrameRate) frames=\(count) bytes=\(try output.resourceValues(forKeys: [.fileSizeKey]).fileSize!) sha256=\(try sha256(output))")
