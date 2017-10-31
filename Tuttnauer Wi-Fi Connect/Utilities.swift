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
        
        var blanksArray = [UInt8]()
        
        if byteArray.count < 8 {
            for _ in 0..<(8 - byteArray.count) {
                blanksArray.append(0)
            }
            byteArray = blanksArray + byteArray
        }
        
        let finalValue = Utilities.fromByteArray(byteArray, Double.self)
        
        return finalValue
    }
    
    // MARK: - Networking
    
    class func getIFAddresses() -> [String] {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }
        
        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            var addr = ptr.pointee.ifa_addr.pointee
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return addresses
        
    }
    
}
