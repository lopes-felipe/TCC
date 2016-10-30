//
//  ManufacturersManager.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/25/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class DeviceCategoriesManager {
    var deviceCategories: [DeviceCategory]
    
    init() {
        self.deviceCategories = [DeviceCategory]()
        
        let testCommand = DeviceCommand(data: [0xE0, 0xE0, 0x40, 0xBF], numberOfBits: 32)
        let testDevice = Device(name: "UN48000 (Sala)", commands: [testCommand])
        let testManufacturer = Manufacturer(name: "Samsung", code: 7, devices: [testDevice])
        let newDeviceCategory = add(deviceCategory: "TV")
        
        testManufacturer.category = newDeviceCategory
        testDevice.manufacturer = testManufacturer
        
        newDeviceCategory.manufacturers.append(testManufacturer)
    }
    
    func add(deviceCategory name: String) -> DeviceCategory {
        let newDeviceCategory = DeviceCategory(name: name)
        self.deviceCategories.append(newDeviceCategory)
        
        return newDeviceCategory
    }
}
