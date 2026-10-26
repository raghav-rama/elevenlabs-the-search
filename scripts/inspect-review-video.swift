import Foundation
import AVFoundation
import AppKit
import CryptoKit

// Inspect the exported media and extract its actual last video sample.
guard CommandLine.arguments.count == 4 else {
    fatalError("Usage: inspect-review-video.swift INPUT LAST_FRAME.png METADATA.json")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let frameOutput = URL(fileURLWithPath: CommandLine.arguments[2])
let recordOutput = URL(fileURLWithPath: CommandLine.arguments[3])
let pictureOutput = frameOutput.deletingLastPathComponent().appendingPathComponent("last-picture-frame.png")
for output in [frameOutput, pictureOutput, recordOutput] {
    guard !FileManager.default.fileExists(atPath: output.path) else { fatalError("Output exists: \(output.path)") }
}
let asset = AVURLAsset(url: input)
guard let track = asset.tracks(withMediaType: .video).first else { fatalError("No video track") }
let reader = try AVAssetReader(asset: asset)
let samples = AVAssetReaderTrackOutput(track: track, outputSettings: [
    kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
])
reader.add(samples)
guard reader.startReading() else { fatalError("Cannot read video: \(String(describing: reader.error))") }
var lastTime = CMTime.invalid
var lastPictureTime = CMTime.invalid
var nearBlackTimes = [Double]()
var frameCount = 0
while let sample = samples.copyNextSampleBuffer() {
    let time = CMSampleBufferGetPresentationTimeStamp(sample)
    if !lastTime.isValid || CMTimeCompare(time, lastTime) > 0 { lastTime = time }
    guard let pixel = CMSampleBufferGetImageBuffer(sample) else { fatalError("Missing decoded frame") }
    CVPixelBufferLockBaseAddress(pixel, .readOnly)
    let base = CVPixelBufferGetBaseAddress(pixel)!.assumingMemoryBound(to: UInt8.self)
    let strideBytes = CVPixelBufferGetBytesPerRow(pixel)
    var maximum: UInt8 = 0
    for y in stride(from: 0, to: CVPixelBufferGetHeight(pixel), by: 16) {
        for x in stride(from: 0, to: CVPixelBufferGetWidth(pixel), by: 16) {
            let offset = y * strideBytes + x * 4
            maximum = max(maximum, base[offset], base[offset + 1], base[offset + 2])
        }
    }
    CVPixelBufferUnlockBaseAddress(pixel, .readOnly)
    if maximum <= 8 { nearBlackTimes.append(time.seconds) }
    else if !lastPictureTime.isValid || CMTimeCompare(time, lastPictureTime) > 0 { lastPictureTime = time }
    frameCount += CMSampleBufferGetNumSamples(sample)
}
guard reader.status == .completed, lastTime.isValid else { fatalError("Video sample inspection failed") }
let generator = AVAssetImageGenerator(asset: asset)
generator.appliesPreferredTrackTransform = true
generator.requestedTimeToleranceBefore = .zero
generator.requestedTimeToleranceAfter = .zero
var actual = CMTime.zero
let image = try generator.copyCGImage(at: lastTime, actualTime: &actual)
guard CMTimeCompare(lastTime, actual) == 0 else {
    print("Frame timestamp mismatch: requested=\(lastTime.seconds) actual=\(actual.seconds) fps=\(track.nominalFrameRate) samples=\(frameCount) duration=\(asset.duration.seconds) track_start=\(track.timeRange.start.seconds) track_duration=\(track.timeRange.duration.seconds)")
    exit(1)
}
let bitmap = NSBitmapImageRep(cgImage: image)
try bitmap.representation(using: .png, properties: [:])!.write(to: frameOutput)
guard lastPictureTime.isValid else { fatalError("No picture above near-black threshold") }
var pictureActual = CMTime.zero
let picture = try generator.copyCGImage(at: lastPictureTime, actualTime: &pictureActual)
guard CMTimeCompare(lastPictureTime, pictureActual) == 0 else { fatalError("Picture timestamp differs") }
try NSBitmapImageRep(cgImage: picture).representation(using: .png, properties: [:])!.write(to: pictureOutput)
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
func fourCC(_ value: FourCharCode) -> String {
    String(bytes: [UInt8((value >> 24) & 255), UInt8((value >> 16) & 255), UInt8((value >> 8) & 255), UInt8(value & 255)], encoding: .ascii) ?? String(value)
}
let descriptions = track.formatDescriptions as! [CMFormatDescription]
let audioTracks = asset.tracks(withMediaType: .audio).map { audio -> [String: Any] in
    let description = audio.formatDescriptions.first as! CMAudioFormatDescription
    let format = CMAudioFormatDescriptionGetStreamBasicDescription(description)!.pointee
    return ["sample_rate": format.mSampleRate, "channels": format.mChannelsPerFrame,
            "codec_fourcc": fourCC(format.mFormatID), "duration_seconds": audio.timeRange.duration.seconds]
}
let record: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try hash(input),
    "duration_seconds": asset.duration.seconds, "video_duration_seconds": track.timeRange.duration.seconds,
    "video_codec_fourcc": fourCC(CMFormatDescriptionGetMediaSubType(descriptions[0])),
    "nominal_fps": track.nominalFrameRate, "video_samples": frameCount,
    "frame_width": image.width, "frame_height": image.height,
    "last_video_sample_seconds": lastTime.seconds, "extracted_frame_seconds": actual.seconds,
    "last_frame_file": CommandLine.arguments[2], "last_frame_sha256": try hash(frameOutput),
    "last_picture_frame_file": pictureOutput.path, "last_picture_frame_seconds": pictureActual.seconds,
    "last_picture_frame_sha256": try hash(pictureOutput),
    "near_black_frame_times_seconds": nearBlackTimes,
    "near_black_detection": "Decoded BGRA samples every 16 pixels; maximum RGB channel <= 8. Visual verification required.",
    "audio_tracks": audioTracks, "source_modified": false,
    "script": "scripts/inspect-review-video.swift",
    "review_limits": "Sample metadata and exact ending frame only; does not establish full playback or listening review."
]
let json = try JSONSerialization.data(withJSONObject: record, options: [.prettyPrinted, .sortedKeys])
try json.write(to: recordOutput)
print(String(data: json, encoding: .utf8)!)
