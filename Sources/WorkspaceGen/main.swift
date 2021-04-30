import Foundation
import Core
import WorkspaceGenCLI

let version = CoreVersion("1.0.0")
let cli = WorkspaceGenCLI(version: version)
cli.execute()
