import Foundation
import SwiftCLI
import Rainbow

protocol OutputCLIProtocol {
    func infoMessage(_ string: String)
    func errorMessage(_ string: String)
    func warningMessage(_ string: String)
    func successMessage(_ string: String)
}

class OutputCLI: OutputCLIProtocol {
    private let quiet: Bool
    
    private var stdout: WritableStream {
        return Term.stdout
    }
    
    init(quiet: Bool) {
        self.quiet = quiet
    }
    
    func infoMessage(_ string: String) {
        if !quiet {
            stdout.print(string)
        }
    }
    
    func errorMessage(_ string: String) {
        stdout.print(string.red)
    }
    
    func warningMessage(_ string: String) {
        if !quiet {
            stdout.print(string.yellow)
        }
    }
    
    func successMessage(_ string: String) {
        if !quiet {
            stdout.print(string.green)
        }
    }
}
