import Foundation
import AVFoundation
import ImageIO
import CryptoKit

// Extract one native frame without cropping, labels, retiming or source changes.
guard CommandLine.arguments.count == 4,
      let seconds = Double(CommandLine.arguments[2]), seconds.isFinite, seconds >= 0 else {
    fatalError("Usage: extract-video-frame.swift INPUT SECONDS OUTPUT.png")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[3])
let recordURL = output.deletingPathExtension().appendingPathExtension("frame.json")
guard output.pathExtension.lowercased() == "png",
      !FileManager.default.fileExists(atPath: output.path),
      !FileManager.default.fileExists(atPath: recordURL.path) else {
    fatalError("Use a fresh PNG and metadata destination")
}
let asset = AVURLAsset(url: input)
guard seconds < asset.duration.seconds else { fatalError("Requested time exceeds duration") }
let generator = AVAssetImageGenerator(asset: asset)
generator.appliesPreferredTrackTransform = true
generator.requestedTimeToleranceBefore = .zero
generator.requestedTimeToleranceAfter = .zero
var actual = CMTime.zero
let frame = try generator.copyCGImage(at: CMTime(seconds: seconds, preferredTimescale: 60000), actualTime: &actual)
guard let destination = CGImageDestinationCreateWithURL(output as CFURL, "public.png" as CFString, 1, nil) else {
    fatalError("Cannot create PNG")
}
CGImageDestinationAddImage(destination, frame, nil)
guard CGImageDestinationFinalize(destination) else { fatalError("PNG write failed") }
func hash(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}
let record: [String: Any] = [
    "source_file": CommandLine.arguments[1], "source_sha256": try hash(input),
    "requested_seconds": seconds, "actual_seconds": actual.seconds,
    "output_file": CommandLine.arguments[3], "sha256": try hash(output),
    "width": frame.width, "height": frame.height,
    "script": "scripts/extract-video-frame.swift", "source_modified": false
]
try JSONSerialization.data(withJSONObject: record, options: [.prettyPrinted, .sortedKeys]).write(to: recordURL)
print("Extracted native \(frame.width)x\(frame.height) frame at \(actual.seconds)s")
