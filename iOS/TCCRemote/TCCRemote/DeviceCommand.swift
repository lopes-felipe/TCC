//
//  DeviceCommand.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class DeviceCommand {
    convenience init(controlLayoutTag: Int) {
        self.init(data: [UInt8](), manufacturerCode: 0, numberOfBits: 0, controlLayoutTag: controlLayoutTag)
        
        self.data = []
    }
    
    init(data: [UInt8], manufacturerCode: UInt8, numberOfBits: UInt8, controlLayoutTag: Int) {
        self.data = data
        self.manufacturerCode = manufacturerCode
        self.numberOfBits = numberOfBits
        self.controlLayoutTag = controlLayoutTag
    }
    
    var data: [UInt8]
    var manufacturerCode: UInt8
    var numberOfBits: UInt8
    var controlLayoutTag: Int
}
