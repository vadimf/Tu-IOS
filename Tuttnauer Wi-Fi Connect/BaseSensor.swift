//
//  BaseSensor.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/26/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class BaseSensor: NSObject {

    var name: String = ""
    var value: Double = 0
    var units: AutoClaveEnums.AnalogUnits = AutoClaveEnums.AnalogUnits.celsius
    var atmosphericPressure: Double = 100.0
    
    // Pressure Factors
    let psiaFactor: Double = 689.51251465214093635799489760739
    let kpaToInhgFactor: Double = 0.2953
    private var kpaToPsiaFactor: Double {
        get {
            return (self.atmosphericPressure / self.psiaFactor)
        }
    }
    private var kpaToPsigFactor: Double {
        get {
            return self.kpaToPsiaFactor
        }
    }
    
    // MARK: - Initialization
    
    init(name: String, value: Double, units: AutoClaveEnums.AnalogUnits, pressure: Double) {
        super.init()
        self.name = name
        self.value = value
        self.units = units
        self.atmosphericPressure = pressure
        setAccordingToUserSettings()
    }
    
    // MARK: - Set / Update Methods
    
    func updateValues(name: String, value: Double, units: AutoClaveEnums.AnalogUnits, pressure: Double) {
        self.name = name
        self.value = value
        self.units = units
        self.atmosphericPressure = pressure
        setAccordingToUserSettings()
    }
    
    func setAccordingToUserSettings() {
        if let userTemperatureUnit = Defaults[.userTemperatureUnit],
            units == .celsius || units == .fahrenheit {
            self.units = AutoClaveEnums.AnalogUnits(rawValue: userTemperatureUnit)!
        }
        
        if let userPressureUnit = Defaults[.userPressureUnit],
            units == .kpa || units == .psia || units == .psig || units == .barA || units == .barG || units == .inhg || units == .mbar {
            self.units = AutoClaveEnums.AnalogUnits(rawValue: userPressureUnit)!
        }
    }
    
    // MARK: - Temperature Unit Methods
    
    func getUnit() -> Double {
        switch self.units {
        case .celsius:
            return self.value
        case .fahrenheit:
            return ((self.value * 1.8) + 32)
        case .kpa:
            return self.value
        case .psia:
            return (self.value * kpaToPsiaFactor)
        case .psig:
            return (self.value * kpaToPsigFactor)
        case .barA:
            return (self.value / 100)
        case .barG:
            return ((self.value - 100) / 100)
        case .inhg:
            return (self.value * kpaToInhgFactor)
        case .mbar:
            return abs((self.value / 10) * 100)
        }
    }
    
    func getFormattedUnit() -> String {
        let unitValue = getUnit().roundToPlaces(places: 1)
        if unitValue == 0 {
            return "-"
        }
        switch self.units {
        case .celsius:
            return "\(unitValue) °C"
        case .fahrenheit:
            return "\(unitValue) °F"
        case .kpa:
            return "\(unitValue) kPa"
        case .psia:
            return "\(unitValue) Psia"
        case .psig:
            return "\(unitValue) Psig"
        case .barA:
            return "\(unitValue) BarA"
        case .barG:
            return "\(unitValue) BarG"
        case .inhg:
            return "\(unitValue) Inhg"
        case .mbar:
            return "\(unitValue) Mbar"
        }
    }
    
}
