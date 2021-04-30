import Core
import Foundation

public protocol WorkspaceGenKitProtocol {
    func generateWorkspace(at path: String?, workspaceName: String, currentVersion: CoreVersion) throws
}

public class WorkspaceGenKit: WorkspaceGenKitProtocol {
    private let decoder: DecoderProtocol
    private let status: WorkspaceGenRunningStatus
    private let fileSystem = FileSystem()
    
    public init(status: WorkspaceGenRunningStatus, decoder: DecoderProtocol = DecodeYaml()) {
        self.status = status
        self.decoder = decoder
    }
    
    public func generateWorkspace(at path: String?, workspaceName: String, currentVersion: CoreVersion) throws {
        let basePath: String
        let workspacePath: String
        if let path = path {
            basePath = path
            workspacePath = "\(path)\(workspaceName)"
        } else {
            basePath = "/."
            workspacePath = workspaceName
        }
        
        status.reportStatus(.readingConfigFile(path: workspacePath))
        
        let model: WorkspaceModel = try decoder.decodeFile(at: workspacePath)
        
        try validateMinimumVersion(currentVersion: currentVersion, fileVersion: model.minimumVersion)
        
        status.reportStatus(.readConfigFileSuccessfully)
        
        let genereteWorkspace = WorkspaceGenerate(status: status, fileSystem: fileSystem)
        
        addTargets(genereteWorkspace: genereteWorkspace, targets: model.targets)
        
        try genereteWorkspace.generate(at: basePath, workspaceName: model.name)
        
        status.reportStatus(.finished)
    }
    
    private func addTargets(genereteWorkspace: WorkspaceGenerate, targets: [TargetModel]) {
        for target in targets {
            switch target.type {
            case .project:
                genereteWorkspace.addProject(at: target.path)
            case .spm:
                genereteWorkspace.addSPM(at: target.path)
            }
        }
    }
    
    private func validateMinimumVersion(currentVersion: CoreVersion, fileVersion: String) throws {
        let minimumVersion = CoreVersion(fileVersion)
        
        if currentVersion < minimumVersion {
            throw WorkspaceGenKitError.minimumVersion(
                minimum: minimumVersion.description(),
                current: currentVersion.description()
            )
        }
    }
}
