import Foundation

public enum WorkspaceGenKitError: Error {
    case minimumVersion(minimum: String, current: String)
}

extension WorkspaceGenKitError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .minimumVersion(minimum, current):
            return "WorkspaceGen must be at least in version \(minimum), the current version is \(current)"
        }
    }
}
