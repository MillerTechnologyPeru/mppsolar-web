//
//  Arguments.swift
//  
//
//  Created by Alsey Coleman Miller on 17/04/21.
//

import Foundation
import ArgumentParser

extension UUID: ExpressibleByArgument {
    
    public init?(argument: String) {
        self.init(uuidString: argument)
    }
}
