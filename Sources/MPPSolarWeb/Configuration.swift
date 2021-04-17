//
//  Configuration.swift
//  
//
//  Created by Alsey Coleman Miller on 17/04/21.
//

import Foundation

/// MPP Solar Web Server configuration
public struct Configuration: Codable, Equatable, Hashable {
    
    // MARK: - Properties
    
    public let uuid: UUID
    
    public var device: String
    
    // MARK: - Initialization
    
    public init(uuid: UUID = UUID(),
         device: String = "/dev/hidraw0") {
        self.uuid = uuid
        self.device = device
    }
}
