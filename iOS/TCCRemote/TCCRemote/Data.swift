//
//  Data.swift
//  TCCRemote
//
//  Created by Felipe Lopes on 10/30/16.
//  Copyright © 2016 Felipe Lopes. All rights reserved.
//

import Foundation

extension Data {
    func toUInt8() -> UInt8 {
        var dataResult: UInt8 = 0
        copyBytes(to: &dataResult, count: MemoryLayout<UInt8>.size)
        
        return dataResult
    }
}
