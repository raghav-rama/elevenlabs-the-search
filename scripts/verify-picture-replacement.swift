import Foundation
import AVFoundation
import AppKit
import CoreImage
import CryptoKit
import Darwin

guard CommandLine.arguments.count == 2 else { fatalError("Usage: verify-picture-replacement.swift SPLICE_CONFIG.json") }
let configURL = URL(fileURLWithPath: CommandLine.arguments[1])
let p = try JSONSerialization.jsonObject(with: Data(contentsOf: configURL)) as! [String: Any]
let sourceURL = URL(fileURLWithPath: p["source"] as! String), outputURL = URL(fileURLWithPath: p["output"] as! String)
let insertURL = URL(fileURLWithPath: p["replacement"] as! String)
let start = p["start_frame"] as! Int, length = p["replacement_frames"] as! Int, total = p["total_frames"] as! Int, fps = p["fps"] as! Int
let reportURL = outputURL.deletingPathExtension().appendingPathExtension("verification.json")
guard !FileManager.default.fileExists(atPath: reportURL.path) else { fatalError("Verification output exists") }
final class Decoder {
    let reader: AVAssetReader, output: AVAssetReaderTrackOutput
    init(_ url: URL) throws {
        let asset = AVURLAsset(url: url)
        reader = try AVAssetReader(asset: asset)
        output = AVAssetReaderTrackOutput(track: asset.tracks(withMediaType: .video).first!, outputSettings: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA])
        output.alwaysCopiesSampleData = false; reader.add(output)
        guard reader.startReading() else { fatalError("Cannot start video decode") }
    }
    func next() -> CMSampleBuffer? {
        while let s = output.copyNextSampleBuffer() {
            if CMSampleBufferGetNumSamples(s) > 0 { return s }
        }
        return nil
    }
}
func samePixels(_ a: CVPixelBuffer, _ b: CVPixelBuffer) -> Bool {
    let w = CVPixelBufferGetWidth(a), h = CVPixelBufferGetHeight(a)
    guard w == CVPixelBufferGetWidth(b), h == CVPixelBufferGetHeight(b) else { return false }
    CVPixelBufferLockBaseAddress(a, .readOnly); CVPixelBufferLockBaseAddress(b, .readOnly)
    defer { CVPixelBufferUnlockBaseAddress(a, .readOnly); CVPixelBufferUnlockBaseAddress(b, .readOnly) }
    let ap = CVPixelBufferGetBaseAddress(a)!, bp = CVPixelBufferGetBaseAddress(b)!
    let asize = CVPixelBufferGetBytesPerRow(a), bsize = CVPixelBufferGetBytesPerRow(b)
    for row in 0..<h { if memcmp(ap.advanced(by: row*asize), bp.advanced(by: row*bsize), w*4) != 0 { return false } }
    return true
}
let old = try Decoder(sourceURL), new = try Decoder(outputURL), replacement = try Decoder(insertURL)
let ci = CIContext(options: [.cacheIntermediates: false])
var unchanged = 0, inserted = 0
let reviewIndices: Set<Int> = [348, 368, 392]
for frame in 0..<total {
    try autoreleasepool {
        guard let a = old.next(), let b = new.next(), let ap = CMSampleBufferGetImageBuffer(a), let bp = CMSampleBufferGetImageBuffer(b) else { fatalError("Missing frame \(frame)") }
        let expected = CMTime(value: Int64(frame), timescale: Int32(fps))
        guard CMTimeCompare(CMSampleBufferGetPresentationTimeStamp(a), expected) == 0,
              CMTimeCompare(CMSampleBufferGetPresentationTimeStamp(b), expected) == 0 else { fatalError("Frame timing mismatch \(frame)") }
        if (start..<(start+length)).contains(frame) {
            guard let s = replacement.next(), let rp = CMSampleBufferGetImageBuffer(s), samePixels(rp, bp) else { fatalError("Replacement pixels differ at \(frame)") }
            inserted += 1
        } else {
            guard samePixels(ap, bp) else { fatalError("Unchanged picture differs at \(frame)") }; unchanged += 1
        }
        if reviewIndices.contains(frame) {
            for (label, pixel) in [("before",ap),("after",bp)] {
                let crop = CGRect(x: 800,y: 140,width: 350,height: 850)
                let image = ci.createCGImage(CIImage(cvPixelBuffer: pixel), from: crop)!
                let target = outputURL.deletingLastPathComponent().appendingPathComponent(String(format:"%@-frame-%04d.png", label, frame))
                guard !FileManager.default.fileExists(atPath: target.path) else { fatalError("Preview exists") }
                try NSBitmapImageRep(cgImage: image).representation(using: .png, properties: [:])!.write(to: target)
            }
        }
    }
    if frame % 240 == 0 { print("Verified picture \(frame+1)/\(total)"); fflush(stdout) }
}
guard old.next() == nil, new.next() == nil, replacement.next() == nil,
      old.reader.status == .completed, new.reader.status == .completed, replacement.reader.status == .completed else { fatalError("Extra frames or decode error") }
func hash(_ url: URL) throws -> String { SHA256.hash(data: try Data(contentsOf: url, options: .mappedIfSafe)).map { String(format: "%02x", $0) }.joined() }
guard try hash(sourceURL) == p["source_sha256"] as! String, try hash(insertURL) == p["replacement_sha256"] as! String else { fatalError("Input changed") }
let report: [String: Any] = ["source": sourceURL.path,"output": outputURL.path,"output_sha256": try hash(outputURL),
    "source_sha256": p["source_sha256"]!,"replacement_sha256": p["replacement_sha256"]!,
    "frames": total,"fps": fps,"duration_seconds": Double(total)/Double(fps),
    "unchanged_frames_pixel_identical": unchanged,"replacement_frames_pixel_identical": inserted,
    "every_frame_timestamp_verified": true,"all_three_video_streams_fully_decoded": true,
    "comparison": "Every visible BGRA byte, excluding row padding; outside correction compare with original review, inside compare with corrected component",
    "script": "scripts/verify-picture-replacement.swift"]
try JSONSerialization.data(withJSONObject: report,options:[.prettyPrinted,.sortedKeys]).write(to: reportURL)
print("Verified \(unchanged) unchanged frames and \(inserted) replacement frames, every timestamp exact")
