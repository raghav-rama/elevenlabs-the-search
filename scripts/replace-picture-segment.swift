import Foundation
import AVFoundation
import CryptoKit

// Splice an equal-length picture correction into an existing review without
// recompressing its audio or unaffected video. Refuses overwritten outputs.
struct Plan: Decodable {
    let source: String, source_sha256: String, replacement: String, replacement_sha256: String, output: String
    let fps: Int32, start_frame: Int, replacement_frames: Int, total_frames: Int
}
guard CommandLine.arguments.count == 2 else { fatalError("Usage: replace-picture-segment.swift CONFIG.json") }
let config = URL(fileURLWithPath: CommandLine.arguments[1])
let p = try JSONDecoder().decode(Plan.self, from: Data(contentsOf: config))
let sourceURL = URL(fileURLWithPath: p.source), replacementURL = URL(fileURLWithPath: p.replacement)
let outputURL = URL(fileURLWithPath: p.output), reportURL = outputURL.deletingPathExtension().appendingPathExtension("edit.json")
guard !FileManager.default.fileExists(atPath: outputURL.path), !FileManager.default.fileExists(atPath: reportURL.path) else { fatalError("Use fresh outputs") }
func hash(_ url: URL) throws -> String { SHA256.hash(data: try Data(contentsOf: url, options: .mappedIfSafe)).map { String(format: "%02x", $0) }.joined() }
guard try hash(sourceURL) == p.source_sha256, try hash(replacementURL) == p.replacement_sha256 else { fatalError("Source hash mismatch") }
let source = AVURLAsset(url: sourceURL), replacement = AVURLAsset(url: replacementURL)
guard let video = source.tracks(withMediaType: .video).first, let insert = replacement.tracks(withMediaType: .video).first,
      let audio = source.tracks(withMediaType: .audio).first else { fatalError("Missing track") }
let duration = CMTime(value: Int64(p.total_frames), timescale: p.fps)
let start = CMTime(value: Int64(p.start_frame), timescale: p.fps)
let length = CMTime(value: Int64(p.replacement_frames), timescale: p.fps), end = CMTimeAdd(start, length)
guard p.start_frame >= 0, p.replacement_frames > 0, p.start_frame+p.replacement_frames <= p.total_frames,
      video.naturalSize == insert.naturalSize, abs(video.nominalFrameRate-Float(p.fps)) < 0.01,
      abs(insert.nominalFrameRate-Float(p.fps)) < 0.01,
      CMTimeCompare(video.timeRange.duration, duration) == 0, CMTimeCompare(insert.timeRange.duration, length) == 0,
      CMTimeCompare(audio.timeRange.duration, duration) == 0 else { fatalError("Timing or dimensions mismatch") }
let composition = AVMutableComposition()
let picture = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)!
picture.preferredTransform = video.preferredTransform
try picture.insertTimeRange(CMTimeRange(start: .zero, duration: start), of: video, at: .zero)
try picture.insertTimeRange(CMTimeRange(start: .zero, duration: length), of: insert, at: start)
try picture.insertTimeRange(CMTimeRange(start: end, duration: CMTimeSubtract(duration, end)), of: video, at: end)
let sound = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
try sound.insertTimeRange(CMTimeRange(start: .zero, duration: duration), of: audio, at: .zero)
let export = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough)!
export.outputURL = outputURL; export.outputFileType = .mp4; export.timeRange = CMTimeRange(start: .zero, duration: duration)
export.shouldOptimizeForNetworkUse = true
let done = DispatchSemaphore(value: 0)
export.exportAsynchronously { done.signal() }
while done.wait(timeout: .now()+0.1) == .timedOut { RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.05)) }
guard export.status == .completed else { fatalError("Export failed: \(String(describing: export.error))") }
func compressedAudioHash(_ asset: AVAsset) throws -> String {
    let reader = try AVAssetReader(asset: asset)
    let out = AVAssetReaderTrackOutput(track: asset.tracks(withMediaType: .audio).first!, outputSettings: nil)
    reader.add(out); guard reader.startReading() else { fatalError("Audio read failed") }
    var hasher = SHA256()
    while let sample = out.copyNextSampleBuffer() {
        guard let block = CMSampleBufferGetDataBuffer(sample) else {
            guard CMSampleBufferGetNumSamples(sample) == 0 else { fatalError("Missing audio data") }; continue
        }
        let size = CMBlockBufferGetDataLength(block); var bytes = Data(count: size)
        let status = bytes.withUnsafeMutableBytes { CMBlockBufferCopyDataBytes(block, atOffset: 0, dataLength: size, destination: $0.baseAddress!) }
        guard status == noErr else { fatalError("Audio payload read failed") }; hasher.update(data: bytes)
    }
    guard reader.status == .completed else { fatalError("Audio inspection failed") }
    return hasher.finalize().map { String(format: "%02x", $0) }.joined()
}
let audioHash = try compressedAudioHash(source)
guard try compressedAudioHash(AVURLAsset(url: outputURL)) == audioHash else { fatalError("Original AAC changed") }
guard try hash(sourceURL) == p.source_sha256, try hash(replacementURL) == p.replacement_sha256 else { fatalError("Source changed") }
let report: [String: Any] = ["source": p.source, "source_sha256": p.source_sha256, "replacement": p.replacement,
    "replacement_sha256": p.replacement_sha256, "output": p.output, "output_sha256": try hash(outputURL),
    "config": CommandLine.arguments[1], "config_sha256": try hash(config), "fps": p.fps, "frames_expected": p.total_frames,
    "start_frame": p.start_frame, "replacement_frames": p.replacement_frames, "duration_seconds": duration.seconds,
    "export_preset": "passthrough", "source_retimed": false, "audio_payload_identical": true, "audio_payload_sha256": audioHash,
    "new_provider_generations": 0, "script": "scripts/replace-picture-segment.swift", "status": "pending_decode_and_user_review"]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: reportURL)
print("Saved picture correction with identical original AAC: \(outputURL.path)")
