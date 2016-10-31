//
//  Manufacturer.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/25/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class Manufacturer {
    init(name: String) {
        self.name = name
        self.devices = []
    }
    
    init(name: String, devices: [Device]) {
        self.name = name
        self.devices = devices
    }
    
    var name: String
    var devices: [Device]
}
