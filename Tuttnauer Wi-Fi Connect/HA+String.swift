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
    
}
