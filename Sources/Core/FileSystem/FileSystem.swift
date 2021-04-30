import Foundation

public protocol FileSystemProtocol {
    func createFolder(_ path: String) throws -> String
    func createFile(_ path: String, withName: String) throws -> String
    func write(_ string: String, file: String) throws
    func fileExists(_ path: String) -> Bool
    func appendCurrentPath(_ path: String) -> String
}

public class FileSystem: FileSystemProtocol {
    private let fileManager = FileManager.default
    private let currentPath: String
    
    public init() {
        currentPath = fileManager.currentDirectoryPath.addingSuffixIfNeeded("/")
    }
    
    public func createFolder(_ path: String) throws -> String {
        let atPath = appendCurrentPath(path)
        try fileManager.createDirectory(atPath: atPath, withIntermediateDirectories: true, attributes: nil)
        return path
    }
    
    public func createFile(_ path: String, withName: String) throws -> String {
        let file = "\(path)/\(withName)"
        let atPath =  appendCurrentPath(file)
        if fileManager.fileExists(atPath: atPath) {
            try FileManager().removeItem(atPath: atPath)
        }
        let _ = fileManager.createFile(atPath: atPath, contents: nil, attributes: nil)
        return atPath
    }
    
    public func write(_ string: String, file: String) throws {
        try string.write(toFile: file, atomically: false, encoding: .utf8)
    }
    
    public func fileExists(_ path: String) -> Bool {
        fileManager.fileExists(atPath: path)
    }
    
    public func appendCurrentPath(_ path: String) -> String {
        "\(currentPath)\(path)"
    }
}
