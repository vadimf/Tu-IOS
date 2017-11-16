//
//  HA+String.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import CoreGraphics

extension String {
    
    // Returns the localized version for this string (if exists)
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var cgFloatValue: CGFloat {
        guard let number = NumberFormatter().number(from: self) else { return 0 }
        return CGFloat(number)
    }
    
    func padBinary(toSize: Int) -> String {
        let padding = String(repeating: Character("0"), count: (toSize - self.count))
        return padding + self
    }
    
    // MARK: - String to Date
    
    func stringToDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            print("Cannot return current date. Invalid arguments")
            return Date()
        }
        return date
    }
    
}
