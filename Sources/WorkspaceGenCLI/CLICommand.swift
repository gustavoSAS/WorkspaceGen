import Foundation

public protocol CLICommand {
    func execute(arguments: [String]?)
}

public extension CLICommand {
    func execute(arguments: [String]? = nil) { }
}
