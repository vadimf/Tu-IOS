//
//  HA+Array.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/23/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

extension Array {
    
}

extension Array where Element == Int {
    
    // Takes an [Int] type array and translates it from Unicode Ints to a String
    func generateStringFromIntArray() -> String {
        var string = ""
        for int in self {
            if int != 0 {
                let char = Character(UnicodeScalar(int)!)
                string += char.description
            } else {
                continue
            }
        }
        return string
    }
        
}

extension Array where Element == String {
    
}
