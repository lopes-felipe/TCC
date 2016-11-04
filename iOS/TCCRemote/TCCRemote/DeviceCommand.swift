//
//  DeviceCommand.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class DeviceCommand: NSObject, NSCoding {
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
    
    required init(coder aDecoder: NSCoder) {
        self.data = aDecoder.decodeBytes(withReturnedLength: self.data)(forKey: "data") as! [UInt8]
        self.manufacturerCode = aDecoder.decodeObject(forKey: "manufacturerCode") as! UInt8
        self.numberOfBits = aDecoder.decodeObject(forKey: "numberOfBits") as! UInt8
        self.controlLayoutTag = aDecoder.decodeInteger(forKey: "controlLayoutTag")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeBytes(self.data, length: self.data.count, forKey: "data")
        aCoder.encodeBytes([self.manufacturerCode], length: 1, forKey: "manufacturerCode")
        aCoder.encodeBytes([self.numberOfBits], length: 1, forKey: "numberOfBits")
        aCoder.encode(controlLayoutTag, forKey: "controlLayoutTag")
    }
    
    var data: [UInt8]
    var manufacturerCode: UInt8
    var numberOfBits: UInt8
    var controlLayoutTag: Int
}
