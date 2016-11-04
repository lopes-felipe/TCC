//
//  DeviceCategory.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class DeviceCategory: NSObject, NSCoding {
    init(name: String) {
        self.name = name
        self.manufacturers = []
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.manufacturers = aDecoder.decodeObject(forKey: "manufacturers") as! [Manufacturer]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(manufacturers, forKey: "manufacturers")
    }
    
    var name: String
    var manufacturers: [Manufacturer]
}
