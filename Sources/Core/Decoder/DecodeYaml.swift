import Foundation
import Yams

public protocol DecoderProtocol {
    func decodeFile<T: Decodable>(at path: String) throws -> T
}

public class DecodeYaml: DecoderProtocol {
    private let fileSystem: FileSystemProtocol
    
    public init(fileSystem: FileSystemProtocol = FileSystem()) {
        self.fileSystem = fileSystem
    }
    
    public func decodeFile<T: Decodable>(at path: String) throws -> T {
        let decoder = YAMLDecoder()
        let filePath = fileSystem.appendCurrentPath(path)
        guard fileSystem.fileExists(filePath) else {
            throw CoreError.fileDoesNotExist(path: filePath)
        }
        
        let fileDate = try String(contentsOfFile: filePath, encoding: .utf8)
        do {
            return try decoder.decode(T.self, from: fileDate)
        } catch {
            throw CoreError.decodeFile(description: error.localizedDescription)
        }
    }
}
