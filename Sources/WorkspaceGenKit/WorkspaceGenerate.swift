import Foundation
import Core

public protocol WorkspaceGenerateProtocol {
    func addProject(at path: String)
    func addSPM(at path: String)
    func generate(at path: String, workspaceName: String) throws
}

public class WorkspaceGenerate: WorkspaceGenerateProtocol {
    private var contents: [Reference]
    private let fileSystem: FileSystemProtocol
    private let status: WorkspaceGenRunningStatus
    
    public init(status: WorkspaceGenRunningStatus, fileSystem: FileSystemProtocol) {
        self.fileSystem = fileSystem
        self.status = status
        self.contents = []
    }
    
    public func addProject(at path: String) {
        let path = path.removingSuffixIfNeeded("/")
        contents.append(Reference(path: path))
        
        status.reportStatus(.addProject(path: path))
    }
    
    public func addSPM(at path: String) {
        let path = path.removingSuffixIfNeeded("/")
        contents.append(Reference(path: path))
        
        status.reportStatus(.addSPM(path: path))
    }
    
    public func generate(at path: String, workspaceName: String) throws {
        let name = workspaceName.addingSuffixIfNeeded(".xcworkspace")
        let pathWorkspace = path.addingSuffixIfNeeded("/")
        
        let folder = try fileSystem.createFolder("\(pathWorkspace)\(name)")
        
        status.reportStatus(.addingTargets)
        let xml = createXcworkspacedata(contents: contents)
        
        let file = try fileSystem.createFile(folder, withName: "contents.xcworkspacedata")
        try fileSystem.write(xml, file: file)
    }
    
    private func createXcworkspacedata(contents: [Reference]) -> String {
        var xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
        xml.append("<Workspace version=\"1.0\">")
        
        for reference in contents {
            xml.append("    <FileRef location=\"group:\(reference.path)\"></FileRef>")
        }
        
        xml.append("</Workspace>")
        
        return xml
    }
}
