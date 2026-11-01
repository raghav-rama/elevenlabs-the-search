import Foundation
import AVFoundation
import AppKit
import QuartzCore
import CryptoKit

// Editorial label plus replacement end card. The existing AAC mix is passed through.
struct Plan: Decodable {
    let source: String, source_sha256: String, outro: String, output: String
    let fps: Int32, outro_start_frame: Int, total_frames: Int
    let label_start_frame: Int, label_end_frame: Int
    let brand: String, descriptor: String
}
guard (2...3).contains(CommandLine.arguments.count) else { fatalError("Usage: add-product-clarity.swift CONFIG.json [--verify-existing]") }
let verifyExisting = CommandLine.arguments.count == 3
guard !verifyExisting || CommandLine.arguments[2] == "--verify-existing" else { fatalError("Unknown option") }
let configURL = URL(fileURLWithPath: CommandLine.arguments[1])
let plan = try JSONDecoder().decode(Plan.self, from: Data(contentsOf: configURL))
let sourceURL = URL(fileURLWithPath: plan.source), outroURL = URL(fileURLWithPath: plan.outro)
let outputURL = URL(fileURLWithPath: plan.output)
let recordURL = outputURL.deletingPathExtension().appendingPathExtension("edit.json")
for url in (verifyExisting ? [recordURL] : [outputURL, recordURL]) {
    guard !FileManager.default.fileExists(atPath: url.path) else { fatalError("Output exists: \(url.path)") }
}
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url, options: .mappedIfSafe)).map { String(format: "%02x", $0) }.joined()
}
guard try hash(sourceURL) == plan.source_sha256 else { fatalError("Source hash mismatch") }
let outroHash = try hash(outroURL)
let source = AVURLAsset(url: sourceURL), outro = AVURLAsset(url: outroURL)
guard let video = source.tracks(withMediaType: .video).first,
      let audio = source.tracks(withMediaType: .audio).first,
      let ending = outro.tracks(withMediaType: .video).first else { fatalError("Missing media track") }
let duration = CMTime(value: Int64(plan.total_frames), timescale: plan.fps)
let cut = CMTime(value: Int64(plan.outro_start_frame), timescale: plan.fps)
let endingDuration = CMTimeSubtract(duration, cut)
guard plan.fps == 24, video.naturalSize == CGSize(width: 1920, height: 1080),
      ending.naturalSize == video.naturalSize,
      abs(video.nominalFrameRate - 24) < 0.1, abs(ending.nominalFrameRate - 24) < 0.1,
      CMTimeCompare(video.timeRange.duration, duration) == 0,
      CMTimeCompare(ending.timeRange.duration, endingDuration) == 0,
      CMTimeCompare(audio.timeRange.duration, duration) >= 0,
      plan.label_start_frame >= 0, plan.label_end_frame < plan.outro_start_frame,
      plan.label_end_frame > plan.label_start_frame else { fatalError("Unexpected timing or dimensions") }

if !verifyExisting {
let composition = AVMutableComposition()
let track = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)!
try track.insertTimeRange(CMTimeRange(start: .zero, duration: cut), of: video, at: .zero)
try track.insertTimeRange(CMTimeRange(start: .zero, duration: endingDuration), of: ending, at: cut)
let edit = AVMutableVideoComposition()
edit.renderSize = video.naturalSize
edit.frameDuration = CMTime(value: 1, timescale: plan.fps)
let instruction = AVMutableVideoCompositionInstruction()
instruction.timeRange = CMTimeRange(start: .zero, duration: duration)
let transform = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
transform.setTransform(video.preferredTransform, at: .zero)
instruction.layerInstructions = [transform]; edit.instructions = [instruction]
let root = CALayer(); root.frame = CGRect(origin: .zero, size: edit.renderSize)
let videoLayer = CALayer(); videoLayer.frame = root.bounds; root.addSublayer(videoLayer)
let cyan = NSColor(calibratedRed: 0.18, green: 0.94, blue: 0.91, alpha: 1)
let panel = CALayer(); panel.frame = CGRect(x: 112, y: 124, width: 750, height: 192)
panel.backgroundColor = NSColor(calibratedRed: 0.018, green: 0.027, blue: 0.042, alpha: 0.90).cgColor
panel.cornerRadius = 12
let accent = CALayer(); accent.frame = CGRect(x: 0, y: 18, width: 4, height: 156)
accent.backgroundColor = cyan.cgColor; panel.addSublayer(accent)
func label(_ text: String, y: CGFloat, size: CGFloat, kern: CGFloat, color: NSColor, weight: NSFont.Weight) {
    let width = 680.0, height = size * 1.55
    let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(width * 2),
        pixelsHigh: Int(height * 2), bitsPerSample: 8, samplesPerPixel: 4,
        hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
    NSGraphicsContext.current!.cgContext.scaleBy(x: 2, y: 2)
    (text as NSString).draw(in: CGRect(x: 0, y: 0, width: width, height: height), withAttributes: [
        .font: NSFont.systemFont(ofSize: size, weight: weight), .kern: kern, .foregroundColor: color])
    NSGraphicsContext.restoreGraphicsState()
    let layer = CALayer(); layer.contents = bitmap.cgImage; layer.contentsScale = 2
    layer.frame = CGRect(x: 36, y: y, width: width, height: height); panel.addSublayer(layer)
}
label(plan.brand, y: 87, size: 57, kern: 5, color: .white, weight: .heavy)
label(plan.descriptor, y: 27, size: 34, kern: 2.5, color: cyan, weight: .medium)
panel.opacity = 0
let fade = CAKeyframeAnimation(keyPath: "opacity")
let labelDuration = Double(plan.label_end_frame - plan.label_start_frame) / Double(plan.fps)
fade.values = [0, 1, 1, 0]; fade.keyTimes = [0, NSNumber(value: 0.2 / labelDuration), NSNumber(value: 1 - 0.2 / labelDuration), 1]
fade.beginTime = AVCoreAnimationBeginTimeAtZero + Double(plan.label_start_frame) / Double(plan.fps)
fade.duration = labelDuration; fade.fillMode = .both; fade.isRemovedOnCompletion = false
panel.add(fade, forKey: "product-visibility"); root.addSublayer(panel)
edit.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: root)
func export(_ exporter: AVAssetExportSession) {
    let done = DispatchSemaphore(value: 0)
    exporter.exportAsynchronously { done.signal() }
    while done.wait(timeout: .now() + 0.05) == .timedOut { RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.05)) }
    guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
}
let temporary = FileManager.default.temporaryDirectory.appendingPathComponent("afterhuman-label-\(UUID().uuidString).mp4")
defer { try? FileManager.default.removeItem(at: temporary) }
let pictureExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
pictureExport.outputURL = temporary; pictureExport.outputFileType = .mp4
pictureExport.videoComposition = edit; pictureExport.timeRange = instruction.timeRange
export(pictureExport)

// Remux original compressed audio to preserve speech, music, timing and loudness exactly.
let picture = AVURLAsset(url: temporary)
let mux = AVMutableComposition()
let muxVideo = mux.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)!
try muxVideo.insertTimeRange(instruction.timeRange, of: picture.tracks(withMediaType: .video).first!, at: .zero)
let muxAudio = mux.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
try muxAudio.insertTimeRange(instruction.timeRange, of: audio, at: .zero)
let finalExport = AVAssetExportSession(asset: mux, presetName: AVAssetExportPresetPassthrough)!
finalExport.outputURL = outputURL; finalExport.outputFileType = .mp4
finalExport.timeRange = instruction.timeRange; finalExport.shouldOptimizeForNetworkUse = true
export(finalExport)
}

func compressedAudioHash(_ asset: AVAsset) throws -> String {
    let reader = try AVAssetReader(asset: asset)
    let output = AVAssetReaderTrackOutput(track: asset.tracks(withMediaType: .audio).first!, outputSettings: nil)
    reader.add(output); guard reader.startReading() else { fatalError("Audio read failed") }
    var hasher = SHA256()
    while let sample = output.copyNextSampleBuffer() {
        guard let block = CMSampleBufferGetDataBuffer(sample) else {
            // AVAssetReader emits zero-sample timeline markers at AAC track boundaries.
            guard CMSampleBufferGetNumSamples(sample) == 0 else { fatalError("Missing nonempty audio block") }
            continue
        }
        let count = CMBlockBufferGetDataLength(block)
        var bytes = Data(count: count)
        let result = bytes.withUnsafeMutableBytes { p in
            CMBlockBufferCopyDataBytes(block, atOffset: 0, dataLength: count, destination: p.baseAddress!)
        }
        guard result == noErr else { fatalError("Audio copy failed") }; hasher.update(data: bytes)
    }
    guard reader.status == .completed else { fatalError("Audio inspection failed") }
    return hasher.finalize().map { String(format: "%02x", $0) }.joined()
}
let originalAudioHash = try compressedAudioHash(source)
let exportedAudioHash = try compressedAudioHash(AVURLAsset(url: outputURL))
guard originalAudioHash == exportedAudioHash else { fatalError("AAC payload differs; review export before delivery") }
guard try hash(sourceURL) == plan.source_sha256, try hash(outroURL) == outroHash else { fatalError("Input changed") }
let report: [String: Any] = [
    "status": "product_clarity_edit_pending_user_review", "config": configURL.path,
    "config_sha256": try hash(configURL), "source": plan.source, "source_sha256": plan.source_sha256,
    "outro": plan.outro, "outro_sha256": outroHash, "output": plan.output,
    "output_sha256": try hash(outputURL), "duration_seconds": duration.seconds,
    "fps": plan.fps, "frames_expected": plan.total_frames,
    "label_start_seconds": Double(plan.label_start_frame) / Double(plan.fps),
    "label_end_seconds": Double(plan.label_end_frame) / Double(plan.fps),
    "outro_start_seconds": cut.seconds, "brand": plan.brand, "descriptor": plan.descriptor,
    "audio_payload_identical": true, "audio_payload_sha256": exportedAudioHash,
    "source_speed_multiplier": 1, "new_provider_generations": 0,
    "script": "scripts/add-product-clarity.swift", "verified_existing_export": verifyExisting,
    "limitations": "Existing 1080p review canvas is re-encoded; native source detail is not improved. Scene redesign and overhead replacement remain future production work."
]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: recordURL)
print("Saved product clarity review; original AAC payload verified unchanged: \(outputURL.path)")
