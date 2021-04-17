//
//  Configuration.swift
//  
//
//  Created by Alsey Coleman Miller on 17/04/21.
//

import Foundation

struct Configuration: Codable, Equatable, Hashable {
    
    var uuid: UUID
    
    var device: String
    
    init(uuid: UUID = UUID(),
         device: String = "/dev/hidraw0") {
        self.uuid = uuid
        self.device = device
    }
}
