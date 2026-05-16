import AVFoundation
import UniformTypeIdentifiers

class VideoBypass {
    private let ELST_SIGNATURE: [UInt8] = [0x65, 0x6C, 0x73, 0x74]
    private let PAYLOAD: UInt32 = 268435457 // 0x10000001
    
    func bypassVideo(inputURL: URL, outputURL: URL) async throws -> Bool {
        let fileHandle = try FileHandle(forWritingTo: outputURL)
        try FileManager.default.copyItem(at: inputURL, to: outputURL)
        
        let fileData = try Data(contentsOf: outputURL)
        let elstRange = findPattern(data: fileData, pattern: ELST_SIGNATURE)
        
        guard let range = elstRange else {
            print("elst atom not found")
            return false
        }
        
        // Patch the 4 bytes at elst + 8
        var patchedData = fileData
        let patchOffset = range.location + 8
        withUnsafeBytes(of: PAYLOAD.bigEndian) { bytes in
            patchedData.replaceSubrange(patchOffset..<patchOffset+4, with: bytes)
        }
        
        try patchedData.write(to: outputURL)
        return true
    }
    
    private func findPattern(data: Data, pattern: [UInt8]) -> NSRange? {
        let nsData = data as NSData
        return nsData.range(of: Data(pattern), options: [])
    }
}
