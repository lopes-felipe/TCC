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
        var dataLenght: Int = 0
        let dataPointer = aDecoder.decodeBytes(forKey: "data", returnedLength: &dataLenght)
        let dataBuffer = UnsafeBufferPointer(start: dataPointer, count: dataLenght)
        self.data = [UInt8](dataBuffer)
        
        // TODO: Verificar melhor forma de decoding dos campos abaixo
        let manufacturerCodePointer = aDecoder.decodeBytes(forKey: "manufacturerCode", returnedLength: &dataLenght)
        let manufacturerCodeBuffer = UnsafeBufferPointer(start: manufacturerCodePointer, count: 1)
        self.manufacturerCode = [UInt8](manufacturerCodeBuffer)[0]
        
        let numberOfBitsPointer = aDecoder.decodeBytes(forKey: "numberOfBits", returnedLength: &dataLenght)
        let numberOfBitsBuffer = UnsafeBufferPointer(start: numberOfBitsPointer, count: 1)
        self.numberOfBits = [UInt8](numberOfBitsBuffer)[0]
        
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
