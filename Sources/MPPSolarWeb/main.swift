#if os(macOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

import Foundation
import MPPSolar
import ArgumentParser

struct MPPSolarWebServerTool: ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "A deamon for exposing an MPP Solar device to the web",
        version: "1.0.0"
    )
    
    @Option(default: "/dev/hidraw0", help: "The special file path to the solar device.")
    var device: String
    
    @Option(help: "UUID for server instance.")
    var uuid: UUID?
    
    func validate() throws {
        
    }
    
    func run() throws {
        print("Will start MPP Solar server")
        let uuid = self.uuid ?? UUID()
        print("UUID: \(uuid)")
        print("Device: \(device)")
        let configuration = Configuration(
            uuid: uuid,
            device: device
        )
        let server = WebServer(configuration: configuration)
        server.log = { print($0) }
        server.start()
        RunLoop.main.run()
    }
}

MPPSolarWebServerTool.main()
