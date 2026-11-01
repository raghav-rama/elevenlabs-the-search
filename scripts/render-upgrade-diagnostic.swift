import Foundation
import AVFoundation
import AppKit
import CoreImage
import CryptoKit

struct Module: Decodable { let label: String, sub: String; let at: Double }
struct Config: Decodable {
    let source: String, source_sha256: String, mattes: String, output: String
    let fps: Int32, start_frame: Int, frame_count: Int
    let source_pivot: [Double], target_pivot: [Double], center_scale: Double
    let fly_in_seconds: Double, return_start_seconds: Double, return_end_seconds: Double
    let brand: String, descriptor: String, modules: [Module]
    let person_style: String?
    let picture_source: String?, picture_source_sha256: String?, picture_start_frame: Int?
}
struct Frame: Decodable { let frame: Int, mask: String; let joints: [String:[Double]] }
struct Mattes: Decodable { let source_sha256: String; let frames: [Frame] }
guard CommandLine.arguments.count == 2 else { fatalError("Usage: render-upgrade-diagnostic.swift CONFIG.json") }
let configURL = URL(fileURLWithPath:CommandLine.arguments[1])
let c = try JSONDecoder().decode(Config.self,from:Data(contentsOf:configURL))
let source = URL(fileURLWithPath:c.source), matteURL = URL(fileURLWithPath:c.mattes), output = URL(fileURLWithPath:c.output)
let reportURL = output.deletingPathExtension().appendingPathExtension("edit.json")
let previews = output.deletingLastPathComponent().appendingPathComponent(output.deletingPathExtension().lastPathComponent + "-frames")
for u in [output,reportURL,previews] {guard !FileManager.default.fileExists(atPath:u.path) else {fatalError("Output exists: \(u.path)")}}
try FileManager.default.createDirectory(at:previews,withIntermediateDirectories:true)
func hash(_ u:URL)throws->String {SHA256.hash(data:try Data(contentsOf:u)).map{String(format:"%02x",$0)}.joined()}
guard try hash(source)==c.source_sha256 else {fatalError("Source hash mismatch")}
let naturalPerson = c.person_style == "natural"
let pictureSource = c.picture_source.map { URL(fileURLWithPath:$0) } ?? source
let pictureHash = c.picture_source_sha256 ?? c.source_sha256
guard try hash(pictureSource)==pictureHash else {fatalError("Picture source hash mismatch")}
let mattes = try JSONDecoder().decode(Mattes.self,from:Data(contentsOf:matteURL))
guard mattes.frames.count==c.frame_count,mattes.source_sha256==c.source_sha256 else {fatalError("Matte/source mismatch")}
let frames = Dictionary(uniqueKeysWithValues:mattes.frames.map{($0.frame,$0)})
let gen=AVAssetImageGenerator(asset:AVURLAsset(url:pictureSource))
gen.appliesPreferredTrackTransform=true;gen.requestedTimeToleranceBefore = .zero;gen.requestedTimeToleranceAfter = .zero
let ci=CIContext(options:[.cacheIntermediates:false])
let w=1920,h=1080, rect=CGRect(x:0,y:0,width:1920,height:1080)
let clear=CIImage(color:.clear).cropped(to:rect)
let cyan=NSColor(calibratedRed:0.21,green:0.94,blue:0.91,alpha:1)
let gold=NSColor(calibratedRed:0.97,green:0.77,blue:0.38,alpha:1)
let magenta=NSColor(calibratedRed:0.85,green:0.35,blue:0.75,alpha:1)
let writer=try AVAssetWriter(outputURL:output,fileType:.mp4)
let input=AVAssetWriterInput(mediaType:.video,outputSettings:[AVVideoCodecKey:AVVideoCodecType.h264,AVVideoWidthKey:w,AVVideoHeightKey:h,AVVideoCompressionPropertiesKey:[AVVideoAverageBitRateKey:10_000_000,AVVideoExpectedSourceFrameRateKey:c.fps,AVVideoMaxKeyFrameIntervalKey:c.fps]])
let adaptor=AVAssetWriterInputPixelBufferAdaptor(assetWriterInput:input,sourcePixelBufferAttributes:[kCVPixelBufferPixelFormatTypeKey as String:kCVPixelFormatType_32ARGB,kCVPixelBufferWidthKey as String:w,kCVPixelBufferHeightKey as String:h,kCVPixelBufferCGImageCompatibilityKey as String:true,kCVPixelBufferCGBitmapContextCompatibilityKey as String:true])
writer.add(input);guard writer.startWriting() else {fatalError("Writer failed")};writer.startSession(atSourceTime:.zero)
func smooth(_ value:Double)->Double {let v=max(0,min(1,value));return v*v*(3-2*v)}
func window(_ t:Double,_ a:Double,_ b:Double,_ d:Double,_ e:Double)->Double {smooth((t-a)/(b-a))*(1-smooth((t-d)/(e-d)))}
func typeOn(_ value:String,_ t:Double,_ start:Double,_ cps:Double)->String {String(value.prefix(max(0,min(value.count,Int(max(0,t-start)*cps)))))}
var previous = [String:CGPoint]()
var saved = [String]()
let sampleFrames:Set<Int>=[0,4,8,12,18,24,30,36,48,60,72,84,92,100,108,114,120,126]
func renderFrame(_ index: Int) throws {
        let t=Double(index)/Double(c.fps),frame=c.start_frame+index
        let movement=smooth(t/c.fly_in_seconds)*(1-smooth((t-c.return_start_seconds)/(c.return_end_seconds-c.return_start_seconds)))
        // Natural mode preserves the original visible transformation and skin/clothing colors.
        // It never renders the translucent body, diagnostic skeleton or blue outline.
        let scan=naturalPerson ? 0.0 : window(t,0.55,1.05,3.3,3.85)
        let ui=window(t,0.28,0.7,3.8,4.3)
        let scale=1+(c.center_scale-1)*movement
        let tx=(c.target_pivot[0]-c.source_pivot[0])*movement+c.source_pivot[0]*(1-scale)
        let ty=(c.target_pivot[1]-c.source_pivot[1])*movement+c.source_pivot[1]*(1-scale)+sin(t*2.2)*3*movement
        let floatTransform=CGAffineTransform(a:scale,b:0,c:0,d:scale,tx:tx,ty:ty)
        var actual=CMTime.zero
        let pictureFrame=(c.picture_start_frame ?? c.start_frame)+index
        let cg=try gen.copyCGImage(at:CMTime(value:Int64(pictureFrame),timescale:c.fps),actualTime:&actual)
        guard CMTimeCompare(actual,CMTime(value:Int64(pictureFrame),timescale:c.fps))==0 else {fatalError("Source frame mismatch")}
        let native=CIImage(cgImage:cg)
        let conform=max(Double(w)/native.extent.width,Double(h)/native.extent.height)
        let photo=native.transformed(by:CGAffineTransform(scaleX:conform,y:conform))
            .transformed(by:CGAffineTransform(translationX:(Double(w)-native.extent.width*conform)/2,y:(Double(h)-native.extent.height*conform)/2)).cropped(to:rect)
        let matte=frames[frame]!
        let maskNative=CIImage(contentsOf:matteURL.deletingLastPathComponent().appendingPathComponent(matte.mask))!
        // Limit this mock-up's mask to Riley's known screen region, excluding distant incidental figures.
        let mask=maskNative.transformed(by:CGAffineTransform(scaleX:1920/maskNative.extent.width,y:1080/maskNative.extent.height)).cropped(to:CGRect(x:860,y:100,width:400,height:930)).composited(over:CIImage(color:.black).cropped(to:rect)).applyingFilter("CIMorphologyMinimum",parameters:["inputRadius":0.65]).cropped(to:rect)
        let person=photo.applyingFilter("CIBlendWithMask",parameters:["inputBackgroundImage":clear,"inputMaskImage":mask])
        let erase=mask.applyingFilter("CIMorphologyMaximum",parameters:["inputRadius":3]).applyingFilter("CIGaussianBlur",parameters:["inputRadius":2]).cropped(to:rect)
        // Temporary local background patch; heavily defocused/dimmed while Riley is detached.
        let patch=photo.transformed(by:CGAffineTransform(translationX:310,y:0)).cropped(to:rect)
        let clean=patch.applyingFilter("CIBlendWithMask",parameters:["inputBackgroundImage":photo,"inputMaskImage":erase])
        let background=clean.clampedToExtent().applyingFilter("CIGaussianBlur",parameters:["inputRadius":16*movement]).cropped(to:rect)
        while !input.isReadyForMoreMediaData {Thread.sleep(forTimeInterval:0.002)}
        var optional:CVPixelBuffer?;CVPixelBufferPoolCreatePixelBuffer(nil,adaptor.pixelBufferPool!,&optional)
        let pixel=optional!;CVPixelBufferLockBaseAddress(pixel,[])
        let ctx=CGContext(data:CVPixelBufferGetBaseAddress(pixel),width:w,height:h,bitsPerComponent:8,bytesPerRow:CVPixelBufferGetBytesPerRow(pixel),space:CGColorSpaceCreateDeviceRGB(),bitmapInfo:CGImageAlphaInfo.noneSkipFirst.rawValue)!
        func drawCI(_ image:CIImage,_ alpha:Double=1) {ctx.saveGState();ctx.setAlpha(alpha);ctx.draw(ci.createCGImage(image,from:rect)!,in:rect);ctx.restoreGState()}
        if movement<0.0001 {drawCI(photo)} else {
            drawCI(background)
            ctx.setFillColor(NSColor(calibratedRed:0.006,green:0.023,blue:0.035,alpha:0.86*movement).cgColor);ctx.fill(rect)
            // A subtle guide plane helps make the lifted body legible against the station.
            ctx.saveGState();ctx.setAlpha(ui*0.15);ctx.setStrokeColor(cyan.cgColor);ctx.setLineWidth(1)
            for x in stride(from:120,through:1800,by:80) {ctx.move(to:CGPoint(x:x,y:110));ctx.addLine(to:CGPoint(x:x,y:940))}
            for y in stride(from:110,through:940,by:80) {ctx.move(to:CGPoint(x:120,y:y));ctx.addLine(to:CGPoint(x:1800,y:y))};ctx.strokePath();ctx.restoreGState()
            let glowMask=mask.applyingFilter("CIGaussianBlur",parameters:["inputRadius":8]).cropped(to:rect)
            let glow=CIImage(color:CIColor(red:0.12,green:0.92,blue:0.9,alpha:0.6)).cropped(to:rect).applyingFilter("CIBlendWithMask",parameters:["inputBackgroundImage":clear,"inputMaskImage":glowMask])
            drawCI(glow.transformed(by:floatTransform).cropped(to:rect),scan*0.65)
            drawCI(person.transformed(by:floatTransform).cropped(to:rect),1-scan*0.92)
            let hologram=photo.applyingFilter("CIColorMonochrome",parameters:["inputColor":CIColor(red:0.2,green:0.8,blue:0.87),"inputIntensity":1]).applyingFilter("CIBlendWithMask",parameters:["inputBackgroundImage":clear,"inputMaskImage":mask])
            drawCI(hologram.transformed(by:floatTransform).cropped(to:rect),scan*0.28)
            let edge=mask.applyingFilter("CIEdges",parameters:["inputIntensity":2]).cropped(to:rect)
            let outline=CIImage(color:CIColor(red:0.32,green:0.98,blue:0.95,alpha:1)).cropped(to:rect).applyingFilter("CIBlendWithMask",parameters:["inputBackgroundImage":clear,"inputMaskImage":edge])
            drawCI(outline.transformed(by:floatTransform).cropped(to:rect),scan*0.8)
        }
        var pts=[String:CGPoint]()
        for (name,v) in matte.joints {
            let p=CGPoint(x:v[0],y:v[1]);let old=previous[name] ?? p
            let smoothed=CGPoint(x:old.x*0.65+p.x*0.35,y:old.y*0.65+p.y*0.35)
            previous[name]=smoothed;pts[name]=smoothed
        }
        // Dark boots confuse the pose estimator; these explicit screen-space anchors are mock-up guides.
        pts["leftAnkle"]=CGPoint(x:1074,y:220);pts["rightAnkle"]=CGPoint(x:1015,y:220)
        func point(_ name:String,_ fallback:CGPoint)->CGPoint {(pts[name] ?? fallback).applying(floatTransform)}
        func line(_ points:[CGPoint],_ color:NSColor,_ width:CGFloat=2,_ alpha:Double=1) {
            guard let first=points.first else{return};ctx.saveGState();ctx.setStrokeColor(color.withAlphaComponent(alpha).cgColor);ctx.setLineWidth(width);ctx.setLineCap(.round);ctx.setLineJoin(.round);ctx.move(to:first);for p in points.dropFirst(){ctx.addLine(to:p)};ctx.strokePath();ctx.restoreGState()
        }
        let neck=point("neck",CGPoint(x:1055,y:810)),hip=point("root",CGPoint(x:1055,y:620)),head=point("nose",CGPoint(x:1055,y:880))
        if scan>0 {
            ctx.saveGState();ctx.setAlpha(scan)
            let chains=[["neck","rightShoulder","rightElbow","rightWrist"],["neck","leftShoulder","leftElbow","leftWrist"],["neck","root"],["root","rightHip","rightKnee","rightAnkle"],["root","leftHip","leftKnee","leftAnkle"]]
            for chain in chains {line(chain.compactMap{pts[$0]?.applying(floatTransform)},cyan,3,0.9)}
            for p in pts.values.map({$0.applying(floatTransform)}) {ctx.setFillColor(cyan.withAlphaComponent(0.9).cgColor);ctx.fillEllipse(in:CGRect(x:p.x-4,y:p.y-4,width:8,height:8))}
            // Stylized implant cage and spine, not a medical/anatomical reconstruction.
            for n in 0..<6 {
                let u=Double(n)/6,y=neck.y-30-u*(neck.y-hip.y-60),half=(48+sin(u*Double.pi)*18)*scale
                let rib=CGMutablePath();rib.move(to:CGPoint(x:neck.x-half,y:y+9));rib.addQuadCurve(to:CGPoint(x:neck.x+half,y:y+9),control:CGPoint(x:neck.x,y:y-18));ctx.addPath(rib);ctx.setStrokeColor(cyan.withAlphaComponent(0.7).cgColor);ctx.setLineWidth(2);ctx.strokePath()
            }
            for n in 0..<10 {let y=hip.y+Double(n)*(neck.y-hip.y)/10;ctx.setFillColor(gold.withAlphaComponent(0.8).cgColor);ctx.fill(CGRect(x:neck.x-5,y:y,width:10,height:4))}
            ctx.setStrokeColor(cyan.cgColor);ctx.setLineWidth(2);ctx.strokeEllipse(in:CGRect(x:head.x-24*scale,y:head.y-18*scale,width:48*scale,height:62*scale))
            let sweep=940-(t-0.6).truncatingRemainder(dividingBy:1.45)/1.45*740
            line([CGPoint(x:790,y:sweep),CGPoint(x:1125,y:sweep)],cyan,2,0.5)
            ctx.restoreGState()
        }
        NSGraphicsContext.saveGraphicsState();NSGraphicsContext.current=NSGraphicsContext(cgContext:ctx,flipped:false)
        func text(_ value:String,_ x:Double,_ y:Double,_ size:Double,_ color:NSColor,_ alpha:Double=1,_ weight:NSFont.Weight = .medium) {
            (value as NSString).draw(at:CGPoint(x:x,y:y),withAttributes:[.font:NSFont.monospacedSystemFont(ofSize:size,weight:weight),.foregroundColor:color.withAlphaComponent(alpha)])
        }
        let typedBrand=typeOn(c.brand,t,0.25,18)
        let cursor=(Int(t*5)%2==0 && t<3.8) ? "_" : ""
        if ui>0 {
            text(typedBrand+(t<0.95 ? cursor:""),124,950,65,.white,ui,.bold)
            text(typeOn(c.descriptor,t,0.85,31)+(t>=0.85 && t<1.6 ? cursor:""),126,902,30,cyan,ui)
            text(naturalPerson ? "RILEY BROOKS  //  UPGRADE STATUS" : "RILEY BROOKS  //  SYSTEM SCAN",1300,950,20,cyan,ui)
            text("BIOLOGICAL HOST · AUGMENTED",1300,917,17,.white,ui*0.65)
        }
        let labelXY=[CGPoint(x:145,y:740),CGPoint(x:1325,y:740),CGPoint(x:145,y:410),CGPoint(x:1325,y:410)]
        let anchors=[head,CGPoint(x:neck.x,y:(neck.y+hip.y)/2),point("rightElbow",CGPoint(x:970,y:700)),point("leftKnee",CGPoint(x:1075,y:440))]
        for (i,module) in c.modules.enumerated() {
            let amount=smooth((t-module.at)/0.2)*ui
            if amount<=0 {continue}
            let xy=labelXY[i],left=i%2==0,anchor=anchors[i],col=i==2 ? gold:cyan
            let edge=CGPoint(x:left ? xy.x+370:xy.x-25,y:xy.y+20)
            let turn=CGPoint(x:left ? 745:1180,y:edge.y)
            line([edge,turn,CGPoint(x:turn.x,y:anchor.y),anchor],col,1.7,amount*0.85)
            ctx.setStrokeColor(col.withAlphaComponent(amount).cgColor);ctx.setLineWidth(2);ctx.strokeEllipse(in:CGRect(x:anchor.x-10,y:anchor.y-10,width:20,height:20))
            text(String(format:"0%d",i+1),xy.x,xy.y+52,17,col,amount*0.8)
            text(typeOn(module.label,t,module.at,35),xy.x,xy.y,34,.white,amount,.semibold)
            text(module.sub+"  [ONLINE]",xy.x,xy.y-38,19,col,amount)
            ctx.setFillColor(col.withAlphaComponent(amount*0.4).cgColor);ctx.fill(CGRect(x:xy.x,y:xy.y-55,width:300,height:2))
        }
        let complete=window(t,3.2,3.4,3.9,4.2)
        if complete>0 {text("UPGRADE COMPLETE",745,88,35,gold,complete,.semibold)}
        if t<3.2 && ui>0 {text(String(format:"INTEGRATION  %03d%%",min(100,Int(max(0,t-0.7)/2.5*100))),795,88,24,cyan,ui)}
        NSGraphicsContext.restoreGraphicsState()
        if sampleFrames.contains(index) {
            let path=previews.appendingPathComponent(String(format:"frame-%03d.png",index))
            try NSBitmapImageRep(cgImage:ctx.makeImage()!).representation(using:.png,properties:[:])!.write(to:path);saved.append(path.lastPathComponent)
        }
        CVPixelBufferUnlockBaseAddress(pixel,[])
        guard adaptor.append(pixel,withPresentationTime:CMTime(value:Int64(index),timescale:c.fps)) else {fatalError("Frame append failed")}
        if index%24==0 {print("Rendered diagnostic \(index+1)/\(c.frame_count)");fflush(stdout)}
}
for index in 0..<c.frame_count { try autoreleasepool { try renderFrame(index) } }
input.markAsFinished();writer.endSession(atSourceTime:CMTime(value:Int64(c.frame_count),timescale:c.fps))
let done=DispatchSemaphore(value:0);writer.finishWriting{done.signal()};done.wait()
guard writer.status == .completed else {fatalError("Writer failed: \(String(describing:writer.error))")}
guard try hash(source)==c.source_sha256 else {fatalError("Source changed")}
guard try hash(pictureSource)==pictureHash else {fatalError("Picture source changed")}
let limitations = naturalPerson
    ? ["Local foreground segmentation and a cloned/defocused background patch; detailed edge cleanup remains production work.","Original transformation and timing preserved; source resolution and enhancement are recorded separately."]
    : ["Local foreground segmentation and a temporary cloned/defocused background patch; detailed edge cleanup remains production work.","Stylized implant cage and pose-guided routes, not photoreal internal anatomy; dark-boot ankle anchors are hand positioned.","Existing native 480p source detail is not improved."]
let report:[String:Any] = ["status":"local_floating_upgrade_pending_user_review","person_style":naturalPerson ? "natural":"diagnostic","skeleton_rendered":!naturalPerson,"config":CommandLine.arguments[1],"config_sha256":try hash(configURL),"source":c.source,"source_sha256":c.source_sha256,"picture_source":pictureSource.path,"picture_source_sha256":pictureHash,"picture_start_frame":c.picture_start_frame ?? c.start_frame,"mattes":c.mattes,"mattes_record_sha256":try hash(matteURL),"output":c.output,"output_sha256":try hash(output),"duration_seconds":Double(c.frame_count)/Double(c.fps),"frames":c.frame_count,"fps":c.fps,"resolution":[w,h],"float_out_seconds":[0,c.fly_in_seconds],"float_return_seconds":[c.return_start_seconds,c.return_end_seconds],"source_retimed":false,"new_provider_generations":0,"saved_review_frames":saved,"script":"scripts/render-upgrade-diagnostic.swift","limitations":limitations]
try JSONSerialization.data(withJSONObject:report,options:[.prettyPrinted,.sortedKeys]).write(to:reportURL)
print("Saved diagnostic picture and provenance")
