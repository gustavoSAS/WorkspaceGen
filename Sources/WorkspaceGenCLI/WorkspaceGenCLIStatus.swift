import Foundation
import WorkspaceGenKit

class WorkspaceGenCLIStatus: WorkspaceGenRunningStatus {
    private let output: OutputCLIProtocol
    
    init(output: OutputCLIProtocol) {
        self.output = output
    }
    
    func reportStatus(_ status: RunningStatus) {
        switch status {
        case let .readingConfigFile(path):
            output.infoMessage("⚙️ Reading spec file \(path)\n")
        case .readConfigFileSuccessfully:
            output.successMessage("📜 Spec lidas com sucesso\n")
        case let .addProject(path):
            output.successMessage("📚 Adicinando project \(path)\n")
        case let .addSPM(path):
            output.successMessage("📦 Adicinando SPM \(path)\n")
        case .addingTargets:
            output.successMessage("🗄 Creating Targets\n")
        case let .creatingWorkspace(path):
            output.infoMessage("🔨 Creating Workspace \(path)\n")
        case .createdWorkspace:
            output.successMessage("✅ Workspace criado com sucesso\n")
        case .finished:
            output.successMessage("Everything worked !!! Have a good time 🚀 🤘\n")
        }
    }
}
