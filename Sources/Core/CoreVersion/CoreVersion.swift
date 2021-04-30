import Foundation
import Version

public class CoreVersion {
    private var version: Version
    
    public init(_ version: String) {
        self.version = Version(version) ?? Version(0, 0, 0)
    }
    
    public func description() -> String {
        version.description
    }
}

extension CoreVersion: Comparable {
    public static func == (lhs: CoreVersion, rhs: CoreVersion) -> Bool {
        lhs.version == rhs.version
    }
    
    public static func < (lhs: CoreVersion, rhs: CoreVersion) -> Bool {
        lhs.version < rhs.version
    }
    
    public static func <= (lhs: CoreVersion, rhs: CoreVersion) -> Bool {
        lhs.version <= rhs.version
    }

    public static func >= (lhs: CoreVersion, rhs: CoreVersion) -> Bool {
        lhs.version >= rhs.version
    }

    public static func > (lhs: CoreVersion, rhs: CoreVersion) -> Bool {
        lhs.version > rhs.version
    }
}
