//
//  Server.swift
//  
//
//  Created by Alsey Coleman Miller on 17/04/21.
//

import Foundation
import MPPSolar
import Kitura
import KituraNet
#if os(Linux)
import NetService
#endif

/// MPP Solar Server
public final class WebServer {
    
    // MARK: - Properties
    
    public let configuration: Configuration
    
    public var log: ((String) -> ())?
    
    internal lazy var jsonEncoder = JSONEncoder()
    
    internal lazy var jsonDecoder = JSONDecoder()
    
    internal let router = Router()
    
    private var httpServer: HTTPServer?
    
    private var netService: NetService?
    
    // MARK: - Initialization
    
    public init(configuration: Configuration) {
        self.configuration = configuration
        setupRouter()
    }
    
    // MARK: - Methods
    
    public func start() {
        
        precondition(httpServer == nil)
        precondition(netService == nil)
        
        // Bonjour
        let netService = NetService(
            domain: "local.",
            type: "_lock._tcp.",
            name: configuration.uuid.uuidString,
            port: Int32(configuration.port)
        )
        
        netService.publish(options: [])
        self.netService = netService
        
        // Kiture
        httpServer = Kitura.addHTTPServer(onPort: configuration.port, with: router)
        log?("Started HTTP Server on port \(configuration.port)")
        Kitura.start()
    }
    
    private func setupRouter() {
        router.get("/command/:command", handler: self.command)
    }
    
    private func command(
        request: RouterRequest,
        response: RouterResponse,
        next: @escaping () -> Void) throws -> Void {
        
        guard let command = request.parameters["command"] else {
            response.status(.badRequest)
            return
        }
        
        do {
            guard let solarDevice = MPPSolar(path: configuration.device) else {
                log?("Could not connect to device \(configuration.device)")
                response.status(.internalServerError)
                return
            }
            let responseString = try solarDevice.send(command)
            response.send(responseString)
            response.status(.OK)
        }
        catch {
            log?("Error: \(error)")
            response.status(.badRequest)
        }
    }
}
