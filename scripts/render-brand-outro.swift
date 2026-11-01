import Foundation
import AVFoundation
import AppKit
import CryptoKit

// Local editorial spiral/end card. No generative service; sources are read only.
guard (3...4).contains(CommandLine.arguments.count) else {
    fatalError("Usage: render-brand-outro.swift ENDING_FRAME.png NEW_OUTRO.mp4 [PRODUCT_DESCRIPTOR]")
}
let descriptor = CommandLine.arguments.count == 4 ? CommandLine.arguments[3] : nil
let source = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
let record = output.deletingPathExtension().appendingPathExtension("edit.json")
guard !FileManager.default.fileExists(atPath: output.path),
      !FileManager.default.fileExists(atPath: record.path) else { fatalError("Output exists") }
let picture = NSImage(contentsOf: source)!
var proposed = CGRect(origin: .zero, size: picture.size)
let photo = picture.cgImage(forProposedRect: &proposed, context: nil, hints: nil)!
let width = 1920, height = 1080, fps: Int32 = 24, frames = 60
let writer = try AVAssetWriter(outputURL: output, fileType: .mp4)
let input = AVAssetWriterInput(mediaType: .video, outputSettings: [
    AVVideoCodecKey: AVVideoCodecType.h264, AVVideoWidthKey: width, AVVideoHeightKey: height,
    AVVideoCompressionPropertiesKey: [AVVideoAverageBitRateKey: 8_000_000,
        AVVideoExpectedSourceFrameRateKey: fps, AVVideoMaxKeyFrameIntervalKey: fps]
])
let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input,
    sourcePixelBufferAttributes: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB,
        kCVPixelBufferWidthKey as String: width, kCVPixelBufferHeightKey as String: height,
        kCVPixelBufferCGImageCompatibilityKey as String: true,
        kCVPixelBufferCGBitmapContextCompatibilityKey as String: true])
writer.add(input)
guard writer.startWriting() else { fatalError("Writer failed") }
writer.startSession(atSourceTime: .zero)
let cyan = NSColor(calibratedRed: 0.18, green: 0.94, blue: 0.91, alpha: 1)
let gold = NSColor(calibratedRed: 0.97, green: 0.76, blue: 0.35, alpha: 1)
func ease(_ x: Double) -> Double { let v = max(0, min(1, x)); return v * v * (3 - 2 * v) }
for frame in 0..<frames {
    while !input.isReadyForMoreMediaData { Thread.sleep(forTimeInterval: 0.002) }
    var optional: CVPixelBuffer?
    CVPixelBufferPoolCreatePixelBuffer(nil, adaptor.pixelBufferPool!, &optional)
    let pixel = optional!
    CVPixelBufferLockBaseAddress(pixel, [])
    let context = CGContext(data: CVPixelBufferGetBaseAddress(pixel), width: width, height: height,
        bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixel),
        space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)!
    let t = Double(frame) / Double(fps)
    context.setFillColor(NSColor(calibratedRed: 0.018, green: 0.027, blue: 0.042, alpha: 1).cgColor)
    context.fill(CGRect(x: 0, y: 0, width: width, height: height))
    // Shrink and rotate the overhead image into the spiral during the first half second.
    if t < 0.5 {
        let progress = ease(t / 0.5), scale = pow(1 - progress, 1.4)
        context.saveGState()
        context.translateBy(x: 960, y: 540)
        context.rotate(by: progress * .pi * 1.7)
        context.scaleBy(x: scale, y: scale)
        context.setAlpha(1 - progress)
        let fillScale = max(1920.0 / Double(photo.width), 1080.0 / Double(photo.height))
        let w = Double(photo.width) * fillScale, h = Double(photo.height) * fillScale
        context.draw(photo, in: CGRect(x: -w / 2, y: -h / 2, width: w, height: h))
        context.restoreGState()
    }
    let settle = ease(t / 0.65), radius = 1100 * (1 - settle) + 84 * settle
    let center = CGPoint(x: 960, y: 540 + 195 * settle)
    context.saveGState()
    context.translateBy(x: center.x, y: center.y)
    context.rotate(by: (1 - settle) * .pi * 2)
    context.setLineCap(.round)
    for arm in 0..<2 {
        let path = CGMutablePath()
        for step in 0...200 {
            let u = Double(step) / 200
            let angle = u * .pi * 3.2 + Double(arm) * .pi
            let r = radius * (0.08 + 0.92 * u)
            let point = CGPoint(x: cos(angle) * r, y: sin(angle) * r)
            if step == 0 { path.move(to: point) } else { path.addLine(to: point) }
        }
        context.addPath(path)
        context.setStrokeColor((arm == 0 ? cyan : gold).withAlphaComponent(t < 0.05 ? 0 : 0.9).cgColor)
        context.setLineWidth(6 + 4 * (1 - settle)); context.strokePath()
    }
    context.restoreGState()
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: false)
    let opacity = ease((t - 0.28) / 0.3)
    func centered(_ text: String, y: Double, size: Double, kern: Double, color: NSColor, weight: NSFont.Weight) {
        let attrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: size, weight: weight),
            .foregroundColor: color.withAlphaComponent(opacity), .kern: kern]
        let measured = (text as NSString).size(withAttributes: attrs)
        (text as NSString).draw(at: CGPoint(x: (1920 - measured.width) / 2, y: y), withAttributes: attrs)
    }
    centered("AFTERHUMAN", y: 455, size: 138, kern: 10, color: .white, weight: .heavy)
    if let descriptor = descriptor {
        centered(descriptor, y: 390, size: 42, kern: 5, color: .white, weight: .medium)
        centered("A STEP AHEAD.", y: 300, size: 34, kern: 7, color: cyan, weight: .medium)
    } else {
        centered("A STEP AHEAD.", y: 365, size: 39, kern: 8, color: cyan, weight: .medium)
    }
    NSGraphicsContext.restoreGraphicsState()
    CVPixelBufferUnlockBaseAddress(pixel, [])
    guard adaptor.append(pixel, withPresentationTime: CMTime(value: Int64(frame), timescale: fps)) else {
        fatalError("Frame append failed: \(String(describing: writer.error))")
    }
}
input.markAsFinished()
writer.endSession(atSourceTime: CMTime(value: Int64(frames), timescale: fps))
let done = DispatchSemaphore(value: 0)
writer.finishWriting { done.signal() }; done.wait()
guard writer.status == .completed else { fatalError("Export failed: \(String(describing: writer.error))") }
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
let report: [String: Any] = ["status": "editorial_end_card_pending_user_review",
    "source_file": source.path, "source_sha256": try hash(source), "output_file": output.path,
    "output_sha256": try hash(output), "frames": frames, "fps": fps, "duration_seconds": 2.5,
    "dimensions": [width, height], "audio": "none; assembled soundtrack supplied separately",
    "script": "scripts/render-brand-outro.swift", "paid_generation": false,
    "product_descriptor": descriptor ?? "",
    "note": "Local spiral transition from the held ending frame into exact brand typography; not a newly approved identity/logo design."]
try JSONSerialization.data(withJSONObject: report, options: [.prettyPrinted, .sortedKeys]).write(to: record)
print("Saved 60-frame editorial outro: \(output.path)")
