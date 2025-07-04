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
    
    class func decimalsToString(decimals: [Int]) -> String {
        
        guard decimals.count >= 4 else { return "" }
        
        var byteArray = [UInt8]()
        
        for decimal in decimals {
            byteArray.append(UInt8(bitPattern: Int8(decimal)))
        }

        if let finalValue = String(bytes: byteArray, encoding: .utf8) {
            return finalValue
        }
        
        return ""
        
    }
    
    class func decimalsToDouble(decimals: [Int]) -> Double {
        
        guard decimals.count == 4 else { return 0 }
        
        var byteArray = [UInt8]()
        
        for decimal in decimals {
            let array = decimal.toUInt8BytesArray()
            byteArray.append(array[6])
            byteArray.append(array[7])
        }
        
        return Utilities.fromByteArray(byteArray, Double.self)
    }
    
    class func decimalsTicksToDate(decimals: [Int]) -> Date {
    
        guard decimals.count == 4 else { return Date() }
        
        var byteArray = [UInt8]()
        
        for decimal in decimals {
            let array = decimal.toUInt8BytesArray(reverse: false)
            byteArray.append(array[1])
            byteArray.append(array[0])
        }
        
        byteArray = Array(byteArray.reversed())
        
        let ticks = Utilities.fromByteArray(byteArray, UInt64.self)
        
        return Date(ticks: ticks)
    }
    
    class func decimalsToUInt64(decimals: [Int]) -> UInt64 {
        
        guard decimals.count == 4 else { return 0 }
        
        var byteArray = [UInt8]()
        
        for decimal in decimals {
            let array = decimal.toUInt8BytesArray(reverse: false)
            byteArray.append(array[1])
            byteArray.append(array[0])
        }
        
        return Utilities.fromByteArray(byteArray, UInt64.self)
    }
    
    class func decimalsToInt(decimals: [Int]) -> Int {
        
        guard decimals.count == 4 else { return 0 }
        
        var byteArray = [UInt8]()
        
        for decimal in decimals {
            let array = decimal.toUInt8BytesArray(reverse: false)
            byteArray.append(array[1])
            byteArray.append(array[0])
        }
        
        return Utilities.fromByteArray(byteArray, Int.self)
    }
    
    // MARK: - Networking
    
    class func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
}
