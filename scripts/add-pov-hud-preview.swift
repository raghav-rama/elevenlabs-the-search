import Foundation
import AVFoundation
import AppKit
import QuartzCore
import CryptoKit

// Screen-space HUD concept only, not tracked VFX. Preserve native source.
guard CommandLine.arguments.count == 3 else {
    fatalError("Usage: add-pov-hud-preview.swift INPUT.mp4 NEW_OUTPUT.mp4")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("edit.json")
guard !FileManager.default.fileExists(atPath: output.path),
      !FileManager.default.fileExists(atPath: record.path) else { fatalError("Output exists") }
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
let sourceHash = try hash(input)
let asset = AVURLAsset(url: input)
guard let video = asset.tracks(withMediaType: .video).first else { fatalError("No video") }
let composition = AVMutableComposition()
let target = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)!
try target.insertTimeRange(video.timeRange, of: video, at: .zero)
if let audio = asset.tracks(withMediaType: .audio).first {
    let audioTarget = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
    try audioTarget.insertTimeRange(CMTimeRange(start: audio.timeRange.start,
        duration: CMTimeMinimum(video.timeRange.duration, audio.timeRange.duration)), of: audio, at: .zero)
}
let size = video.naturalSize
let w = size.width, h = size.height
let edit = AVMutableVideoComposition()
edit.renderSize = size
edit.frameDuration = CMTime(value: 1, timescale: 24)
let instruction = AVMutableVideoCompositionInstruction()
instruction.timeRange = CMTimeRange(start: .zero, duration: video.timeRange.duration)
let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: target)
layerInstruction.setTransform(video.preferredTransform, at: .zero)
instruction.layerInstructions = [layerInstruction]
edit.instructions = [instruction]
let root = CALayer(); root.frame = CGRect(origin: .zero, size: size)
let videoLayer = CALayer(); videoLayer.frame = root.bounds; root.addSublayer(videoLayer)
let cyan = NSColor(calibratedRed: 0.22, green: 1, blue: 0.93, alpha: 1)
func text(_ string: String, x: CGFloat, y: CGFloat, width: CGFloat, size: CGFloat, color: NSColor, parent: CALayer) {
    // Rasterize text explicitly: CATextLayer glyphs can be absent in AV export.
    let height = size * 1.7
    let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(width * 2),
        pixelsHigh: Int(height * 2), bitsPerSample: 8, samplesPerPixel: 4,
        hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB,
        bytesPerRow: 0, bitsPerPixel: 0)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
    NSGraphicsContext.current!.cgContext.scaleBy(x: 2, y: 2)
    (string as NSString).draw(in: CGRect(x: 0, y: 0, width: width, height: height),
        withAttributes: [.font: NSFont.monospacedSystemFont(ofSize: size, weight: .semibold),
                         .foregroundColor: color])
    NSGraphicsContext.restoreGraphicsState()
    let t = CALayer(); t.contents = bitmap.cgImage; t.contentsScale = 2
    t.frame = CGRect(x: x, y: y, width: width, height: height)
    parent.addSublayer(t)
}
func panel(_ frame: CGRect) -> CALayer {
    let p = CALayer(); p.frame = frame; p.cornerRadius = 7
    p.backgroundColor = NSColor.black.withAlphaComponent(0.58).cgColor
    p.borderColor = cyan.withAlphaComponent(0.7).cgColor; p.borderWidth = 1
    root.addSublayer(p); return p
}
func visible(_ layer: CALayer, from: Double, until: Double) {
    layer.opacity = 0
    let a = CAKeyframeAnimation(keyPath: "opacity")
    a.values = [0, 1, 1, 0]; a.keyTimes = [0, 0.08, 0.93, 1]
    a.beginTime = AVCoreAnimationBeginTimeAtZero + from; a.duration = until - from
    a.fillMode = .both; a.isRemovedOnCompletion = false
    layer.add(a, forKey: "visibility")
}
let brand = panel(CGRect(x: 24, y: h - 87, width: 236, height: 62))
text("AFTERHUMAN", x: 14, y: 25, width: 215, size: 21, color: .white, parent: brand)
text("NEURAL LINK  /  ONLINE", x: 14, y: 6, width: 215, size: 10, color: cyan, parent: brand)
visible(brand, from: 0.1, until: 5.16)
let scan = panel(CGRect(x: w - 270, y: h - 135, width: 246, height: 110))
text("CALCULATING INTERCEPT", x: 12, y: 77, width: 224, size: 12, color: cyan, parent: scan)
text("01  CONCOURSE", x: 12, y: 46, width: 224, size: 13, color: .white, parent: scan)
text("02  SERVICE PASSAGE", x: 12, y: 19, width: 224, size: 13, color: .white, parent: scan)
visible(scan, from: 0.35, until: 1.85)
let result = panel(CGRect(x: w - 270, y: h - 119, width: 246, height: 94))
text("INTERCEPT ROUTE FOUND", x: 12, y: 59, width: 224, size: 12, color: cyan, parent: result)
text("TAKE LEFT PASSAGE", x: 12, y: 32, width: 224, size: 15, color: .white, parent: result)
text("PATH CLEAR", x: 12, y: 9, width: 224, size: 11, color: cyan, parent: result)
visible(result, from: 1.7, until: 5.16)
let arrow = CAShapeLayer(); arrow.frame = root.bounds
let path = CGMutablePath()
path.move(to: CGPoint(x: w * 0.49, y: h * 0.32))
path.addLine(to: CGPoint(x: w * 0.39, y: h * 0.46))
path.addLine(to: CGPoint(x: w * 0.31, y: h * 0.46))
path.move(to: CGPoint(x: w * 0.35, y: h * 0.51))
path.addLine(to: CGPoint(x: w * 0.31, y: h * 0.46))
path.addLine(to: CGPoint(x: w * 0.35, y: h * 0.41))
arrow.path = path; arrow.strokeColor = cyan.cgColor; arrow.fillColor = nil
arrow.lineWidth = 3; arrow.lineCap = .round; arrow.lineJoin = .round
root.addSublayer(arrow); visible(arrow, from: 1.75, until: 3.1)
edit.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: root)
let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
exporter.outputURL = output; exporter.outputFileType = .mp4; exporter.videoComposition = edit
exporter.timeRange = instruction.timeRange
exporter.shouldOptimizeForNetworkUse = true
let done = DispatchSemaphore(value: 0)
exporter.exportAsynchronously { done.signal() }
while done.wait(timeout: .now() + 0.05) == .timedOut { RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.05)) }
guard exporter.status == .completed else { fatalError("Export failed: \(String(describing: exporter.error))") }
guard try hash(input) == sourceHash else { fatalError("Source changed") }
let metadata: [String: Any] = ["status": "editorial_hud_prototype_pending_user_review",
    "source_file": CommandLine.arguments[1], "source_sha256": sourceHash,
    "output_file": CommandLine.arguments[2], "output_sha256": try hash(output),
    "duration_seconds": video.timeRange.duration.seconds, "width": w, "height": h,
    "source_modified": false, "paid_generation": false,
    "script": "scripts/add-pov-hud-preview.swift",
    "limitations": "Screen-space concept overlay, not world-tracked VFX or a final brand design. Native source audio retained; no new music or speech."]
try JSONSerialization.data(withJSONObject: metadata, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print("Saved HUD concept preview and provenance: \(output.path)")
