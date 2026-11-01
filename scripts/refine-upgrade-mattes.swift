import Foundation
import AVFoundation
import AppKit
import Vision
import CoreImage
import CryptoKit

// Re-segment a tightly framed, higher-resolution Riley plate. Preserve the
// original pose records and frame mapping used by the approved float edit.
struct Exclusion: Decodable { let start_index: Int, end_index: Int; let rect: [Double] }
struct Config: Decodable {
    let source: String, source_sha256: String, original_mattes: String, output: String
    let source_start_frame: Int, frame_count: Int, fps: Int32
    let crop: [Double], mode: String
    let indices: [Int]?
    let opening_radius: Double?
    let opening_regions: [[Double]]?
    let exclusions: [Exclusion]?
}
guard CommandLine.arguments.count == 2 else { fatalError("Usage: refine-upgrade-mattes.swift CONFIG.json") }
let configURL = URL(fileURLWithPath: CommandLine.arguments[1])
let c = try JSONDecoder().decode(Config.self, from: Data(contentsOf: configURL))
let source = URL(fileURLWithPath: c.source), oldURL = URL(fileURLWithPath: c.original_mattes)
let output = URL(fileURLWithPath: c.output)
guard !FileManager.default.fileExists(atPath: output.path), c.crop.count == 4,
      ["person", "foreground", "hybrid"].contains(c.mode) else { fatalError("Use fresh output and valid configuration") }
func hash(_ u: URL) throws -> String { SHA256.hash(data: try Data(contentsOf: u)).map { String(format: "%02x", $0) }.joined() }
guard try hash(source) == c.source_sha256 else { fatalError("Source hash mismatch") }
var old = try JSONSerialization.jsonObject(with: Data(contentsOf: oldURL)) as! [String: Any]
let originalFrames = old["frames"] as! [[String: Any]]
guard originalFrames.count == c.frame_count else { fatalError("Frame count mismatch") }
try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
let generator = AVAssetImageGenerator(asset: AVURLAsset(url: source))
generator.appliesPreferredTrackTransform = true
generator.requestedTimeToleranceBefore = .zero; generator.requestedTimeToleranceAfter = .zero
let ci = CIContext(options: [.cacheIntermediates: false])
let rect = CGRect(x: 0, y: 0, width: 1920, height: 1080)
let crop = CGRect(x: c.crop[0], y: c.crop[1], width: c.crop[2], height: c.crop[3])
let black = CIImage(color: .black).cropped(to: rect)
let foreground = VNGenerateForegroundInstanceMaskRequest()
let person = VNGeneratePersonSegmentationRequest()
person.qualityLevel = .accurate; person.outputPixelFormat = kCVPixelFormatType_OneComponent8
let indices = c.indices ?? Array(0..<c.frame_count)
let previews: Set<Int> = [0, 12, 24, 36, 40, 48, 60, 72, 84, 96, 108, 120, 126]
var records = [[String: Any]]()
func save(_ image: CIImage, _ region: CGRect, _ name: String) throws {
    let cg = ci.createCGImage(image, from: region)!
    try NSBitmapImageRep(cgImage: cg).representation(using: .png, properties: [:])!.write(to: output.appendingPathComponent(name))
}
for index in indices {
    try autoreleasepool {
        let time = CMTime(value: Int64(c.source_start_frame + index), timescale: c.fps)
        var actual = CMTime.zero
        let cg = try generator.copyCGImage(at: time, actualTime: &actual)
        guard CMTimeCompare(time, actual) == 0 else { fatalError("Frame mismatch") }
        let native = CIImage(cgImage: cg)
        let scale = max(rect.width / native.extent.width, rect.height / native.extent.height)
        let photo = native.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
            .transformed(by: CGAffineTransform(translationX: (rect.width-native.extent.width*scale)/2, y: (rect.height-native.extent.height*scale)/2)).cropped(to: rect)
        let croppedCG = ci.createCGImage(photo, from: crop)!
        let handler = VNImageRequestHandler(cgImage: croppedCG, options: [:])
        let pixel: CVPixelBuffer
        if c.mode != "person" {
            try handler.perform([foreground])
            guard let result = foreground.results?.first else { fatalError("No foreground result") }
            pixel = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
        } else {
            try handler.perform([person])
            guard let result = person.results?.first else { fatalError("No person result") }
            pixel = result.pixelBuffer
        }
        var small = CIImage(cvPixelBuffer: pixel)
        if c.mode == "hybrid" {
            // The general foreground model sometimes includes small station lamps
            // touching a hand. A second human-specific matte gates only the arms;
            // preserve the general model's better hair, clothing and boot edges.
            try handler.perform([person])
            guard let humanPixel = person.results?.first?.pixelBuffer else { fatalError("No human matte") }
            let humanNative = CIImage(cvPixelBuffer: humanPixel)
            let human = humanNative.transformed(by: CGAffineTransform(scaleX: small.extent.width/humanNative.extent.width, y: small.extent.height/humanNative.extent.height))
                .applyingFilter("CIColorMatrix", parameters: [
                    "inputRVector": CIVector(x: 4, y: 0, z: 0, w: 0),
                    "inputGVector": CIVector(x: 0, y: 4, z: 0, w: 0),
                    "inputBVector": CIVector(x: 0, y: 0, z: 4, w: 0),
                    "inputBiasVector": CIVector(x: -1, y: -1, z: -1, w: 0)])
                .applyingFilter("CIColorClamp", parameters: ["inputMinComponents": CIVector(x: 0,y: 0,z: 0,w: 0), "inputMaxComponents": CIVector(x: 1,y: 1,z: 1,w: 1)])
            let armRegion = CGRect(x: 0, y: (530-crop.minY)/crop.height*small.extent.height, width: small.extent.width, height: 320/crop.height*small.extent.height)
            let gate = human.cropped(to: armRegion).composited(over: CIImage(color: .white).cropped(to: small.extent))
            small = small.applyingFilter("CIMinimumCompositing", parameters: ["inputBackgroundImage": gate]).cropped(to: small.extent)
        }
        if let radius = c.opening_radius, radius > 0 {
            let opened = small.applyingFilter("CIMorphologyMinimum", parameters: ["inputRadius": radius])
                .applyingFilter("CIMorphologyMaximum", parameters: ["inputRadius": radius])
            // Remove narrow lamp projections near the arms, without altering the
            // rest of the silhouette or the fine detail in Riley's raised hands.
            let zones = (c.opening_regions ?? []).map { v -> CGRect in
                guard v.count == 4 else { fatalError("Invalid opening region") }
                return CGRect(x: v[0], y: v[1], width: v[2], height: v[3])
            }
            for zone in zones { small = opened.cropped(to: zone).composited(over: small).cropped(to: small.extent) }
        }
        // Reviewed, fixed-position station lights just outside the lifted elbows.
        // Coordinates are relative to the crop, with a bottom-left origin.
        for exclusion in c.exclusions ?? [] where (exclusion.start_index...exclusion.end_index).contains(index) {
            let v = exclusion.rect
            guard v.count == 4 else { fatalError("Invalid exclusion") }
            let zone = CGRect(x: v[0], y: v[1], width: v[2], height: v[3])
            small = CIImage(color: .black).cropped(to: zone).composited(over: small).cropped(to: small.extent)
        }
        let mask = small.transformed(by: CGAffineTransform(scaleX: crop.width/small.extent.width, y: crop.height/small.extent.height))
            .transformed(by: CGAffineTransform(translationX: crop.minX, y: crop.minY)).cropped(to: crop).composited(over: black).cropped(to: rect)
        var record = originalFrames[index]
        let frame = record["frame"] as! Int
        let name = String(format: "mask-%04d.png", frame)
        try save(mask, rect, name)
        record["mask"] = name; record["mask_width"] = 1920; record["mask_height"] = 1080
        record["segmentation_source_frame"] = c.source_start_frame + index
        records.append(record)
        if c.indices != nil || previews.contains(index) {
            let background = CIImage(color: CIColor(red: 0.04, green: 0.06, blue: 0.08)).cropped(to: rect)
            let cutout = photo.applyingFilter("CIBlendWithMask", parameters: ["inputBackgroundImage": background, "inputMaskImage": mask])
            try save(photo, crop, String(format: "source-%03d.png", index))
            try save(cutout, crop, String(format: "cutout-%03d.png", index))
            let oldMask = CIImage(contentsOf: oldURL.deletingLastPathComponent().appendingPathComponent(originalFrames[index]["mask"] as! String))!
            let oldCutout = photo.applyingFilter("CIBlendWithMask", parameters: ["inputBackgroundImage": background, "inputMaskImage": oldMask])
            try save(oldCutout, crop, String(format: "before-%03d.png", index))
        }
        if index % 12 == 0 || c.indices != nil { print("Refined matte \(index+1)/\(c.frame_count)"); fflush(stdout) }
    }
}
guard try hash(source) == c.source_sha256 else { fatalError("Source changed") }
old["frames"] = records; old["count"] = records.count
old["method"] = "Local Apple Vision \(c.mode) segmentation on a tight crop of the verified Topaz picture; original frame mapping and pose preserved"
old["segmentation_source"] = c.source; old["segmentation_source_sha256"] = c.source_sha256
old["segmentation_source_start_frame"] = c.source_start_frame; old["crop"] = c.crop
old["original_mattes"] = c.original_mattes; old["original_mattes_sha256"] = try hash(oldURL)
old["config"] = CommandLine.arguments[1]; old["config_sha256"] = try hash(configURL)
old["script"] = "scripts/refine-upgrade-mattes.swift"; old["new_provider_generations"] = 0
try JSONSerialization.data(withJSONObject: old, options: [.prettyPrinted, .sortedKeys]).write(to: output.appendingPathComponent("mattes.json"))
print("Saved \(records.count) refined mattes")
