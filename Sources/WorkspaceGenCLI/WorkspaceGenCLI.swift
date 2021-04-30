import Foundation
import SwiftCLI
import Core


public class WorkspaceGenCLI: CLICommand {
    private let cli: CLI
    
    public init(version: CoreVersion) {
        let projectCommand = ProjectCommand(version: version)
        
        cli = CLI(
            name: "workspacegen",
            version: version.description(),
            description: "Generates Xcode Workspace",
            commands: [
                projectCommand,
            ]
        )
        cli.parser.routeBehavior = .searchWithFallback(projectCommand)
    }
    
    public func execute(arguments: [String]? = nil) {
        let status: Int32
        if let arguments = arguments {
            status = cli.go(with: arguments)
        } else {
            status = cli.go()
        }
        exit(status)
    }
}
