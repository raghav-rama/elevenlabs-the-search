import Foundation
import AVFoundation
import AppKit

guard (3...9).contains(CommandLine.arguments.count) else {
    fatalError("Usage: extract-contact-sheet.swift INPUT OUTPUT.png|jpg [START INTERVAL COUNT COLUMNS WIDTH HEIGHT]")
}
let args = CommandLine.arguments
func number(_ index: Int, _ fallback: Double) -> Double {
    guard args.count > index else { return fallback }
    guard let value = Double(args[index]), value.isFinite else { fatalError("Invalid numeric argument") }
    return value
}
let source = CommandLine.arguments[1]
let destination = CommandLine.arguments[2]
guard !FileManager.default.fileExists(atPath: destination) else { fatalError("Output already exists") }
let start = number(3, 0), interval = number(4, 0.125)
let countValue = number(5, 24), columnsValue = number(6, 4)
let widthValue = number(7, 416), heightValue = number(8, 240)
for value in [countValue, columnsValue, widthValue, heightValue] {
    guard value >= 1, value <= 10000, value.rounded() == value else { fatalError("Expected positive integer size/count") }
}
guard start >= 0, interval > 0 else { fatalError("Invalid sampling range") }
let count = Int(countValue), columns = Int(columnsValue)
let width = Int(widthValue), height = Int(heightValue), labelHeight = 24
let rows = (count + columns - 1) / columns
let ext = URL(fileURLWithPath: destination).pathExtension.lowercased()
guard ["png", "jpg", "jpeg"].contains(ext) else { fatalError("Output must be PNG or JPEG") }
let asset = AVURLAsset(url: URL(fileURLWithPath: source))
let generator = AVAssetImageGenerator(asset: asset)
generator.appliesPreferredTrackTransform = true
generator.requestedTimeToleranceBefore = .zero
generator.requestedTimeToleranceAfter = .zero
let duration = CMTimeGetSeconds(asset.duration)
let tracks = asset.tracks(withMediaType: .video)
print("duration_seconds=\(duration), fps=\(tracks.first?.nominalFrameRate ?? 0), audio_tracks=\(asset.tracks(withMediaType: .audio).count)")
guard start + Double(count - 1) * interval < duration else { fatalError("Sampling extends past video duration") }
let sheet = NSImage(size: NSSize(width: columns * width, height: rows * (height + labelHeight)))
sheet.lockFocus()
NSColor.black.setFill()
NSRect(origin: .zero, size: sheet.size).fill()
for i in 0..<count {
    let seconds = start + Double(i) * interval
    let time = CMTime(seconds: seconds, preferredTimescale: 600)
    var actual = CMTime.zero
    let cg = try generator.copyCGImage(at: time, actualTime: &actual)
    let x = (i % columns) * width
    let y = (rows - 1 - i / columns) * (height + labelHeight)
    NSImage(cgImage: cg, size: .zero).draw(in: NSRect(x: x, y: y, width: width, height: height))
    let text = String(format: "%.3f s", CMTimeGetSeconds(actual)) as NSString
    text.draw(at: NSPoint(x: x + 8, y: y + height + 3), withAttributes: [.foregroundColor: NSColor.white, .font: NSFont.monospacedSystemFont(ofSize: 15, weight: .regular)])
}
sheet.unlockFocus()
let bitmap = NSBitmapImageRep(data: sheet.tiffRepresentation!)!
let fileType: NSBitmapImageRep.FileType = ext == "png" ? .png : .jpeg
try bitmap.representation(using: fileType, properties: [.compressionFactor: 0.8])!.write(to: URL(fileURLWithPath: destination))
