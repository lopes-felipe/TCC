//
//  DeviceCommand.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class DeviceCommand {
    init(data: [UInt8], numberOfBits: UInt8) {
        self.data = data
        self.numberOfBits = numberOfBits
    }
    
    var data: [UInt8]
    var numberOfBits: UInt8
}
