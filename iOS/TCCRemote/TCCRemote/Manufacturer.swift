//
//  Manufacturer.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/25/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class Manufacturer: NSObject, NSCoding {
    init(name: String) {
        self.name = name
        self.devices = []
    }
    
    init(name: String, devices: [Device]) {
        self.name = name
        self.devices = devices
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.devices = aDecoder.decodeObject(forKey: "devices") as! [Device]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(devices, forKey: "devices")
    }
    
    var name: String
    var devices: [Device]
}
