// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "WorkspaceGen",
    products: [
        .executable(name: "workspacegen", targets: ["WorkspaceGen"]),
        .library(name: "WorkspaceGenKit", targets: ["WorkspaceGenKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.6"),
        .package(url: "https://github.com/mxcl/Version.git", from: "2.0.0"),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "WorkspaceGen",
            dependencies: [
                "WorkspaceGenCLI",
                "Core"
            ]),
        .target(
            name: "WorkspaceGenCLI",
            dependencies: [
                "Core",
                "WorkspaceGenKit",
                "Rainbow",
                "SwiftCLI",
            ]),
        .target(
            name: "WorkspaceGenKit",
            dependencies: [
                "Core",
            ]),
        .target(
            name: "Core",
            dependencies: [
                "Yams",
                "Version"
            ]),
    ]
)
