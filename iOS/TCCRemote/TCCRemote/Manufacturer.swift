//
//  Manufacturer.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/25/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class Manufacturer {
    init(name: String, code: UInt8, devices: [Device]) {
        self.name = name
        self.code = code
        self.devices = devices
    }
    
    var name: String
    var code: UInt8
    var devices: [Device]
    
    var category: DeviceCategory?
}
