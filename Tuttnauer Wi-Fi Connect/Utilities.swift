//
//  Utilities.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/22/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class Utilities {
    
    // MARK: - UI Components
    
    class func contentNotAvailableLabel(for view: UIView, message: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = message
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = color
        label.textAlignment = .center
        label.sizeToFit()
        label.center = view.center
        return label
    }
    
    // MARK: - Push Notifications
    
    
    // MARK: - Languages
    
    class func getDeviceLanguageDirection() -> UIUserInterfaceLayoutDirection {
        
        return UIApplication.shared.userInterfaceLayoutDirection
    }
    
    // MARK: - Bytes & Arrays
    
    class func toByteArray<T>(_ value: T) -> [UInt8] {
        var value = value
        return withUnsafeBytes(of: &value) { Array($0) }
    }
    
    class func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
        return value.withUnsafeBytes {
            $0.baseAddress!.load(as: T.self)
        }
    }
    
    class func decimalsToDouble(decimals: [Int]) -> Double {
        
        var byteArray = [UInt8]()
        
        for decimal in decimals {
            
            let array = decimal.toUInt8BytesArray()
            
            for byte in array {
                if byte == 0 { continue }
                byteArray.append(byte)
            }
        }
        
        let finalValue = Utilities.fromByteArray(byteArray, Double.self)
        
        return finalValue
    }
    
}
