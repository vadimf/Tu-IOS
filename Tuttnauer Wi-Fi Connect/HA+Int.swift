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
    
    func toInt16BinaryArray(reversed: Bool) -> [Int] {
        let string = String(self, radix: 2).padBinary(toSize: 16)
        var array = Array(string).map { Int(String($0)) ?? 0 }
        if reversed {
            array = Array(array.reversed())
        }
        return array
    }
        
}

extension Double {
    
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded().divided(by: divisor)
    }
    
    var clearZeroIfNeeded: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}
