//
//  ManufacturersManager.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/25/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class ManufacturersManager {
    var manufacturers = [Manufacturer]()
    
    init() {
        add(manufacturer: "Samsung", code: 1)
        add(manufacturer: "LG", code: 2)
    }
    
    func add(manufacturer name: String, code: Int) -> Manufacturer {
        let newManufacturer = Manufacturer(name: name, code: code)
        manufacturers.append(newManufacturer)
        
        return newManufacturer
    }
}