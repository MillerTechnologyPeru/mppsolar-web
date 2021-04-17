//
//  Server.swift
//  
//
//  Created by Alsey Coleman Miller on 17/04/21.
//

import Foundation
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
    
    public var port: Int = 8080
    
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
    
    private func setupRouter() {
        
    }
    
    public func run() {
        
        // Bonjour
        let netService = NetService(
            domain: "local.",
            type: "_lock._tcp.",
            name: configuration.uuid.uuidString,
            port: Int32(port)
        )
        
        netService.publish(options: [])
        self.netService = netService
        
        // Kiture
        httpServer = Kitura.addHTTPServer(onPort: port, with: router)
        log?("Started HTTP Server on port \(port)")
        Kitura.run()
    }
}
