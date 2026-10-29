import Foundation
import AVFoundation
import CryptoKit

// Read-only adjacent-frame measurements; these flag changes, not perceptual quality.
guard CommandLine.arguments.count == 3 else {
    fatalError("Usage: inspect-frame-continuity.swift INPUT OUTPUT.json")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])
guard !FileManager.default.fileExists(atPath: outputURL.path) else {
    fatalError("Output already exists")
}
let asset = AVURLAsset(url: input)
guard let track = asset.tracks(withMediaType: .video).first else { fatalError("No video") }
let reader = try AVAssetReader(asset: asset)
let output = AVAssetReaderTrackOutput(track: track, outputSettings: [
    kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
])
reader.add(output)
guard reader.startReading() else { fatalError("Reader failed") }
var previous: [UInt8]? = nil
var previousTime = 0.0
var previousDimensions: (Int, Int)? = nil
var frameCount = 0
var pairs = [[String: Any]]()
while let sample = output.copyNextSampleBuffer() {
    guard let pixel = CMSampleBufferGetImageBuffer(sample) else { fatalError("Missing frame") }
    let time = CMSampleBufferGetPresentationTimeStamp(sample).seconds
    let width = CVPixelBufferGetWidth(pixel), height = CVPixelBufferGetHeight(pixel)
    if let dimensions = previousDimensions {
        guard dimensions.0 == width && dimensions.1 == height else { fatalError("Dimensions changed") }
    }
    CVPixelBufferLockBaseAddress(pixel, .readOnly)
    let base = CVPixelBufferGetBaseAddress(pixel)!.assumingMemoryBound(to: UInt8.self)
    let strideBytes = CVPixelBufferGetBytesPerRow(pixel)
    var current = [UInt8]()
    var sums = ["full": 0.0, "upper_background": 0.0, "subject": 0.0]
    var counts = ["full": 0, "upper_background": 0, "subject": 0]
    var index = 0
    for y in stride(from: 0, to: height, by: 8) {
        for x in stride(from: 0, to: width, by: 8) {
            for channel in 0..<3 {
                let value = base[y * strideBytes + x * 4 + channel]
                current.append(value)
                if let previous = previous {
                    let delta = abs(Double(value) - Double(previous[index])) / 255.0
                    sums["full"]! += delta; counts["full"]! += 1
                    let nx = Double(x) / Double(width), ny = Double(y) / Double(height)
                    if nx >= 0.45 && ny < 0.25 {
                        sums["upper_background"]! += delta; counts["upper_background"]! += 1
                    }
                    if nx >= 0.4 && nx <= 0.65 && ny >= 0.25 {
                        sums["subject"]! += delta; counts["subject"]! += 1
                    }
                }
                index += 1
            }
        }
    }
    CVPixelBufferUnlockBaseAddress(pixel, .readOnly)
    if previous != nil {
        pairs.append([
            "from_seconds": previousTime, "to_seconds": time,
            "normalized_mean_absolute_rgb_difference": Dictionary(uniqueKeysWithValues:
                sums.map { ($0.key, $0.value / Double(max(counts[$0.key]!, 1))) })
        ])
    }
    previous = current; previousTime = time
    previousDimensions = (width, height); frameCount += 1
}
guard reader.status == .completed else { fatalError("Decode did not complete") }
let record: [String: Any] = [
    "source_file": CommandLine.arguments[1],
    "source_sha256": SHA256.hash(data: try Data(contentsOf: input)).map { String(format: "%02x", $0) }.joined(),
    "frame_count": frameCount, "grid_step_pixels": 8,
    "regions": ["full": [0.0, 0.0, 1.0, 1.0], "upper_background": [0.45, 0.0, 1.0, 0.25], "subject": [0.4, 0.25, 0.65, 1.0]],
    "pairs": pairs,
    "review_limits": "Adjacent decoded RGB changes, without motion compensation. High values may be natural motion; low values do not establish seamless playback, identity, or absence of subtle warping."
]
try JSONSerialization.data(withJSONObject: record, options: [.prettyPrinted, .sortedKeys]).write(to: outputURL)
print("Inspected \(frameCount) frames; saved \(pairs.count) adjacent-frame measurements.")
