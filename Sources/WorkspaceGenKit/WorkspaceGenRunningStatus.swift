import Foundation

public protocol WorkspaceGenRunningStatus {
    func reportStatus(_ status: RunningStatus)
}

public enum RunningStatus {
    case readingConfigFile(path: String)
    case readConfigFileSuccessfully
    case creatingWorkspace(path: String)
    case createdWorkspace
    case addProject(path: String)
    case addSPM(path: String)
    case addingTargets
    case finished
}
