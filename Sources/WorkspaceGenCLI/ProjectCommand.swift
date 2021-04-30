import Foundation
import SwiftCLI
import Rainbow
import WorkspaceGenKit
import Core

class ProjectCommand: Command {
    @Flag("-q", "--quiet", description: "Suppress all informational, success and warning output")
    var quiet: Bool
    
    @Key("-s", "--spec", description: "The path to the workspace spec file. Defaults to workspace.yml")
    var spec: String?
    
    private let workspaceName = "workspace.yml"
    var name: String
    
    private let version: CoreVersion
    
    init(version: CoreVersion) {
        self.name = "generate"
        self.version = version
    }

    func execute() throws {
        let output: OutputCLIProtocol = OutputCLI(quiet: quiet)
        let generateKit = WorkspaceGenKit(status: WorkspaceGenCLIStatus(output: output))
        
        do {
            try generateKit.generateWorkspace(at: spec, workspaceName: workspaceName, currentVersion: version)
        } catch let error as CoreError {
            output.errorMessage(error.description)
            throw WorkspaceCLIError.core
        } catch let error as WorkspaceGenKitError {
            output.errorMessage(error.description)
            throw WorkspaceCLIError.workspaceGenKit
        } catch {
            output.errorMessage(error.localizedDescription)
            throw WorkspaceCLIError.unknown
        }
    }
}
