//
//  DeviceCategory.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class DeviceCategory {
    init(name: String) {
        self.name = name
        self.manufacturers = []
    }
    
    var name: String
    var manufacturers: [Manufacturer]
}
