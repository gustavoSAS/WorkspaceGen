import Foundation

extension String {
    public func addingSuffixIfNeeded(_ suffix: String) -> String {
        guard hasSuffix(suffix) else {
            return self + suffix
        }
        
        return self
    }
    
    public func removingSuffixIfNeeded(_ suffix: String) -> String {
        guard hasSuffix(suffix) else {
            return self
        }
        
        let substringEndIndex = index(endIndex, offsetBy: -suffix.count)
        return String(self[..<substringEndIndex])
    }
}
