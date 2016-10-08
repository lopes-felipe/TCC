//
//  Manufacturer.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 9/25/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class Manufacturer: NSObject {
    init(name: String, code: Int) {
        self.name = name
        self.code = code
        
        super.init()
    }
    
    var name: String
    var code: Int
}