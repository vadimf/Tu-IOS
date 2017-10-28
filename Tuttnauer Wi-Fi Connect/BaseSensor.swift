//
//  BaseSensor.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/26/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class BaseSensor: NSObject {

    var name: String = ""
    var value: Double = 0
    var units: AutoClaveEnums.AnalogUnits = AutoClaveEnums.AnalogUnits.celsius
    
    // MARK: - Initialization
    
    init(name: String, value: Double, units: AutoClaveEnums.AnalogUnits) {
        super.init()
        self.name = name
        self.value = value
        self.units = units
    }
    
    // MARK: - Temperature Unit Methods
    
    func getTemperatureUnit() -> Double {
        switch self.units {
        case .celsius:
            return self.value
        case .fahrenheit:
            return (self.value * 1.8) + 32
        default:
            return self.value
        }
    }
    
    func getFormattedTemperatureUnit() -> String {
        switch self.units {
        case .celsius:
            return "\(self.value) °C"
        case .fahrenheit:
            return "\((self.value * 1.8) + 32) °F"
        default:
            return "\(self.value)"
        }
    }
    
    // MARK: - Pressure Unit Methods
    
    func getPressureUnit() -> Double {
        switch self.units {
        case .kpa:
            return self.value
        case .psia:
            return self.value
        case .psig:
            return self.value
        case .barA:
            return self.value
        case .barG:
            return self.value
        case .inhg:
            return self.value
        default:
            return self.value
        }
    }
    
    func getFormattedPressureUnit() -> String {
        switch self.units {
        case .kpa:
            return "\(self.value) kPa"
        case .psia:
            return "\(self.value) Psia"
        case .psig:
            return "\(self.value) Psig"
        case .barA:
            return "\(self.value) BarA"
        case .barG:
            return "\(self.value) BarG"
        case .inhg:
            return "\(self.value) Inhg"
        default:
            return "\(self.value)"
        }
    }
    
}
