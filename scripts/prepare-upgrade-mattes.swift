import Foundation
import AVFoundation
import AppKit
import Vision
import CoreImage
import CryptoKit

guard (5...6).contains(CommandLine.arguments.count), let start = Int(CommandLine.arguments[2]), let count = Int(CommandLine.arguments[3]), count > 0 else {
    fatalError("Usage: prepare-upgrade-mattes.swift SOURCE.mp4 START_FRAME COUNT NEW_DIRECTORY [person|foreground]")
}
let mode = CommandLine.arguments.count == 6 ? CommandLine.arguments[5] : "foreground"
guard ["person", "foreground"].contains(mode) else { fatalError("Invalid mask mode") }
let source = URL(fileURLWithPath: CommandLine.arguments[1])
let folder = URL(fileURLWithPath: CommandLine.arguments[4])
guard !FileManager.default.fileExists(atPath: folder.path) else { fatalError("Output directory exists") }
try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
let asset = AVURLAsset(url: source)
let generator = AVAssetImageGenerator(asset: asset)
generator.appliesPreferredTrackTransform = true
generator.requestedTimeToleranceBefore = .zero; generator.requestedTimeToleranceAfter = .zero
let ci = CIContext(options: [.cacheIntermediates: false])
let segmentation = VNGeneratePersonSegmentationRequest()
segmentation.qualityLevel = .accurate; segmentation.outputPixelFormat = kCVPixelFormatType_OneComponent8
let pose = VNDetectHumanBodyPoseRequest()
let foreground = VNGenerateForegroundInstanceMaskRequest()
let joints: [(String, VNHumanBodyPoseObservation.JointName)] = [
    ("nose", .nose), ("neck", .neck), ("root", .root),
    ("leftShoulder", .leftShoulder), ("rightShoulder", .rightShoulder),
    ("leftElbow", .leftElbow), ("rightElbow", .rightElbow),
    ("leftWrist", .leftWrist), ("rightWrist", .rightWrist),
    ("leftHip", .leftHip), ("rightHip", .rightHip),
    ("leftKnee", .leftKnee), ("rightKnee", .rightKnee),
    ("leftAnkle", .leftAnkle), ("rightAnkle", .rightAnkle)]
var records = [[String: Any]]()
for index in 0..<count {
    try autoreleasepool {
        let frame = start + index, time = CMTime(value: Int64(start + index), timescale: 24)
        var actual = CMTime.zero
        let image = try generator.copyCGImage(at: time, actualTime: &actual)
        guard CMTimeCompare(actual, time) == 0 else { fatalError("Frame differs") }
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        let pixel: CVPixelBuffer
        if mode == "foreground" {
            try handler.perform([foreground, pose])
            guard let result = foreground.results?.first else { fatalError("No foreground mask") }
            pixel = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
        } else {
            try handler.perform([segmentation, pose])
            guard let result = segmentation.results?.first else { fatalError("No person mask") }
            pixel = result.pixelBuffer
        }
        let maskImage = CIImage(cvPixelBuffer: pixel)
        let maskCG = ci.createCGImage(maskImage, from: maskImage.extent)!
        let maskURL = folder.appendingPathComponent(String(format: "mask-%04d.png", frame))
        try NSBitmapImageRep(cgImage: maskCG).representation(using: .png, properties: [:])!.write(to: maskURL)
        var points = [String: [Double]]()
        let person = pose.results?.max(by: { a,b in a.confidence < b.confidence })
        if let person = person {
            for (name, joint) in joints {
                if let point = try? person.recognizedPoint(joint), point.confidence > 0.15 {
                    points[name] = [point.location.x * Double(image.width), point.location.y * Double(image.height), Double(point.confidence)]
                }
            }
        }
        records.append(["frame": frame, "seconds": time.seconds, "mask": maskURL.lastPathComponent,
            "mask_width": maskCG.width, "mask_height": maskCG.height, "joints": points])
        if index == 0 || index == count - 1 {
            try NSBitmapImageRep(cgImage: image).representation(using: .png, properties: [:])!.write(to: folder.appendingPathComponent(String(format: "source-%04d.png", frame)))
            let mask = maskImage.transformed(by: CGAffineTransform(scaleX: CGFloat(image.width)/maskImage.extent.width, y: CGFloat(image.height)/maskImage.extent.height))
            let clear = CIImage(color: .clear).cropped(to: CGRect(x:0,y:0,width:image.width,height:image.height))
            let cutout = CIImage(cgImage:image).applyingFilter("CIBlendWithMask", parameters:["inputBackgroundImage":clear,"inputMaskImage":mask])
            try NSBitmapImageRep(cgImage:ci.createCGImage(cutout,from:clear.extent)!).representation(using:.png,properties:[:])!.write(to:folder.appendingPathComponent(String(format:"cutout-%04d.png",frame)))
        }
        if index % 24 == 0 {print("Prepared matte \(index+1)/\(count)");fflush(stdout)}
    }
}
let hash = SHA256.hash(data:try Data(contentsOf:source)).map{String(format:"%02x",$0)}.joined()
let report:[String:Any] = ["source":CommandLine.arguments[1],"source_sha256":hash,"fps":24,"start_frame":start,"count":count,"source_dimensions":[1920,1080],"method":"Local Apple Vision \(mode) segmentation and 2D body pose; no external generation","frames":records,"script":"scripts/prepare-upgrade-mattes.swift"]
try JSONSerialization.data(withJSONObject:report,options:[.prettyPrinted,.sortedKeys]).write(to:folder.appendingPathComponent("mattes.json"))
print("Prepared \(count) source-frame mattes and pose records")
