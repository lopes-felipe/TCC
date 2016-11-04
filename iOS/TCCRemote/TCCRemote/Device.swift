//
//  Device.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class Device: NSObject, NSCoding {
    init(name: String) {
        self.name = name
        self.commands = []
    }
    
    init(name: String, commands: [DeviceCommand]) {
        self.name = name;
        self.commands = commands;
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.commands = aDecoder.decodeObject(forKey: "commands") as! [DeviceCommand]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(commands, forKey: "commands")
    }
    
    var name: String
    var commands: [DeviceCommand]
    
    func findCommandBy(layoutTag tag: Int) -> DeviceCommand? {
        for command in commands {
            if command.controlLayoutTag == tag {
                return command
            }
        }
        
        return nil
    }
}
