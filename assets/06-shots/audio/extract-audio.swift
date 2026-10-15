import Foundation
import AVFoundation

guard CommandLine.arguments.count == 3 else { fatalError("Usage: extract-audio.swift INPUT OUTPUT.wav") }
guard !FileManager.default.fileExists(atPath: CommandLine.arguments[2]) else { fatalError("Output already exists") }
let asset = AVURLAsset(url: URL(fileURLWithPath: CommandLine.arguments[1]))
let track = asset.tracks(withMediaType: .audio).first!
let reader = try AVAssetReader(asset: asset)
let settings: [String: Any] = [AVFormatIDKey: kAudioFormatLinearPCM,
    AVSampleRateKey: 48000, AVNumberOfChannelsKey: 2,
    AVLinearPCMBitDepthKey: 32, AVLinearPCMIsFloatKey: true,
    AVLinearPCMIsBigEndianKey: false, AVLinearPCMIsNonInterleaved: false]
let output = AVAssetReaderTrackOutput(track: track, outputSettings: settings)
reader.add(output)
guard reader.startReading() else { fatalError("\(String(describing: reader.error))") }
var samples = [Float]()
while let buffer = output.copyNextSampleBuffer() {
    guard let block = CMSampleBufferGetDataBuffer(buffer) else { continue }
    let count = CMBlockBufferGetDataLength(block)
    var values = [Float](repeating: 0, count: count / MemoryLayout<Float>.size)
    values.withUnsafeMutableBytes { raw in
        _ = CMBlockBufferCopyDataBytes(block, atOffset: 0, dataLength: count, destination: raw.baseAddress!)
    }
    samples.append(contentsOf: values)
}
guard reader.status == .completed else { fatalError("\(String(describing: reader.error))") }
let format = AVAudioFormat(standardFormatWithSampleRate: 48000, channels: 2)!
let frames = samples.count / 2
let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(frames))!
buffer.frameLength = AVAudioFrameCount(frames)
for f in 0..<frames { for c in 0..<2 { buffer.floatChannelData![c][f] = samples[f * 2 + c] } }
var file: AVAudioFile? = try AVAudioFile(forWriting: URL(fileURLWithPath: CommandLine.arguments[2]), settings: format.settings)
try file!.write(from: buffer)
file = nil // Close the writer and finalize the WAV data length before process exit.
let rms = sqrt(samples.reduce(0.0) { $0 + Double($1 * $1) } / Double(samples.count))
let peak = samples.map { abs($0) }.max()!
print("frames=\(frames), sample_rate=48000, channels=2, duration=\(Double(frames)/48000), rms_dbfs=\(20*log10(max(rms,1e-12))), peak_dbfs=\(20*log10(max(Double(peak),1e-12)))")
