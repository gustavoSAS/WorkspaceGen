import Foundation

struct WorkspaceModel: Decodable {
    let name: String
    let minimumVersion: String
    let targets: [TargetModel]
}

struct TargetModel: Decodable {
    let type: TargetType
    let path: String
}

extension TargetModel {
    enum TargetType: String, Decodable {
        case project
        case spm
    }
}
