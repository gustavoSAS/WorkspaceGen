import Foundation

public enum CoreError: Error {
    case fileDoesNotExist(path: String)
    case decodeFile(description: String)
}

extension CoreError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .fileDoesNotExist(path):
            return "File not found \(path)"
        case let .decodeFile(description):
            return "Decode File Error \(description)"
        }
    }
}
