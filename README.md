# WorkspaceGen
WorkspaceGen is a command line tool written in Swift that generate your .xcworkspace also add .xcodeproj and local Swift Package Manager. Using your workspace spec.

Given an example project spec:

```yaml
name: MyWorkspace
minimumVersion: 1.0.0

targets:
  - MyProject:
    type: project
    path: CocktailApp.xcodeproj

  - CoreNetworking:
    type: project
    path: CoreNetworking/CoreNetworking.xcodeproj

  - MySPM:
    type: spm
    path: MySPM
```

## Installing

### Homebrew

```shell
brew install workspacegen
```

### Swift Package Manager

**Use as CLI**

```shell
git clone git@github.com:gustavoSAS/WorkspaceGen.git
cd WorkspaceGen
swift run workspacegen
```
## Usage

Simply run:

```shell
workspacegen generate
```

This will look for a workspace spec in the current directory called `workspace.yml` and generate a Workspace. 

Options:

- **-h, --help**: Show help information.
- **-q, --quiet**: Suppress all informational, success and warning output.
- **-s, --spec <value>**: The path to the workspace spec file. Defaults to workspace.yml

## Inspiration
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)
- [Xgen](https://github.com/JohnSundell/Xgen)

## License

WorkspaceGen is licensed under the MIT license. See [LICENSE](LICENSE) for more info.
