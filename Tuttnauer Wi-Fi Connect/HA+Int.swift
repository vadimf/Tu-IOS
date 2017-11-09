//
//  HA+Int.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/28/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

extension Int {
    
    func toUInt8BytesArray(reverse: Bool = true) -> [UInt8] {
        var decimal = self
        let data = Data(bytes: &decimal, count: MemoryLayout<Int>.size)
        if reverse {
            return Array(data.reversed())
        }
        return Array(data)
    }
    
}

extension Double {
    
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded().divided(by: divisor)
    }
    
}
