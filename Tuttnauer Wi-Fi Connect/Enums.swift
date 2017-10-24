//
//  Enums.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class Enums: NSObject {

    enum TemperatureUnit: Int {
        case celcius = 0
        case fahrenheit
    }
    
    enum PressureUnit: Int {
        case kpa = 0
        case psia
        case psig
        case barA
        case barG
        case inhg
        case mBar
        
    }
    
    enum Language: Int {
        case english = 0
    }
    
    enum ConnectionType: Int {
        case autoConnectOnStart = 0
        case manualConnect
        case connectToLastMachine
    }
    
}
