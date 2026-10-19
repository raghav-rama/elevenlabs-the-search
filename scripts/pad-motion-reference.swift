import Foundation
import AVFoundation
import CryptoKit

// Preserve decoded motion and timestamps, then repeat the final frame. Silent reference.
guard CommandLine.arguments.count == 4, let seconds = Double(CommandLine.arguments[3]),
      seconds.isFinite, seconds > 0 else { fatalError("Usage: pad-motion-reference.swift INPUT OUTPUT.mp4 TOTAL_SECONDS") }
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("preparation.json")
for url in [output, record] {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
let asset = AVURLAsset(url: input)
guard let track = asset.tracks(withMediaType: .video).first,
      track.nominalFrameRate > 0, seconds >= asset.duration.seconds else { fatalError("Invalid source or target duration") }
let reader = try AVAssetReader(asset: asset)
let decoded = AVAssetReaderTrackOutput(track: track, outputSettings: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA])
reader.add(decoded)
let writer = try AVAssetWriter(outputURL: output, fileType: .mp4)
let encoded = AVAssetWriterInput(mediaType: .video, outputSettings: [
    AVVideoCodecKey: AVVideoCodecType.h264,
    AVVideoWidthKey: Int(track.naturalSize.width), AVVideoHeightKey: Int(track.naturalSize.height),
    AVVideoCompressionPropertiesKey: [AVVideoAverageBitRateKey: 6000000, AVVideoAllowFrameReorderingKey: false]
])
encoded.transform = track.preferredTransform
let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: encoded, sourcePixelBufferAttributes: nil)
writer.add(encoded)
guard reader.startReading(), writer.startWriting() else { fatalError("Cannot start media processing") }
writer.startSession(atSourceTime: .zero)
var last: CVPixelBuffer? = nil
var lastTime = CMTime.zero
var sourceFrames = 0
let step = CMTime(seconds: 1 / Double(track.nominalFrameRate), preferredTimescale: 60000)
let end = CMTime(seconds: seconds, preferredTimescale: 60000)
func append(_ pixel: CVPixelBuffer, _ time: CMTime) {
    while !encoded.isReadyForMoreMediaData {
        guard writer.status == .writing else { fatalError("Writer failed: \(String(describing: writer.error))") }
        Thread.sleep(forTimeInterval: 0.002)
    }
    guard adaptor.append(pixel, withPresentationTime: time) else { fatalError("Append failed: \(String(describing: writer.error))") }
}
while let sample = decoded.copyNextSampleBuffer() {
    guard let pixel = CMSampleBufferGetImageBuffer(sample) else { fatalError("Missing decoded frame") }
    let time = CMSampleBufferGetPresentationTimeStamp(sample)
    append(pixel, time)
    last = pixel; lastTime = time; sourceFrames += 1
}
guard reader.status == .completed, let finalPixel = last else { fatalError("Decode failed") }
let motionEnd = CMTimeAdd(lastTime, step)
var next = motionEnd
var heldFrames = 0
while CMTimeCompare(next, end) < 0 {
    append(finalPixel, next); heldFrames += 1; next = CMTimeAdd(next, step)
}
writer.endSession(atSourceTime: end)
encoded.markAsFinished()
let finished = DispatchSemaphore(value: 0)
writer.finishWriting { finished.signal() }
finished.wait()
guard writer.status == .completed else { fatalError("Export failed: \(String(describing: writer.error))") }
let result = AVURLAsset(url: output)
guard abs(result.duration.seconds - seconds) < 0.025,
      result.tracks(withMediaType: .audio).isEmpty else { fatalError("Output verification failed") }
func sha256(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
let report: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try sha256(input),
    "source_duration_seconds": asset.duration.seconds, "source_video_end_seconds": motionEnd.seconds,
    "output_file": CommandLine.arguments[2], "output_sha256": try sha256(output),
    "duration_seconds": result.duration.seconds, "source_frames_preserved": sourceFrames,
    "appended_hold_frames": heldFrames, "fps": result.tracks(withMediaType: .video).first!.nominalFrameRate,
    "file_size": try output.resourceValues(forKeys: [.fileSizeKey]).fileSize!,
    "audio_removed": true, "motion_speed_changed": false,
    "script": "scripts/pad-motion-reference.swift",
    "notes": "Decoded source frames retain their timestamps. Final frame repeated to meet provider minimum duration. Silent motion reference; source unchanged."
]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print(String(data: try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]), encoding: .utf8)!)
