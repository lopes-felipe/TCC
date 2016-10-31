//
//  Device.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/29/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

class Device {
    init(name: String, commands: [DeviceCommand]) {
        self.name = name;
        self.commands = commands;
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
