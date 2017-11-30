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
    var units: AutoClaveEnums.AnalogUnits = .celsius
    var unitsTypes: AutoClaveEnums.AnalogUnitsTypes = .temperature
    var atmosphericPressure: Double = 100.0
    
    // Pressure Factors
    let kpaToPSIAFactor: Double = 0.14503773773020923
    var kpaToPSIGFactor: Double {
        get {
            let psiaFactor: Double = 689.51251465214093635799489760739
            return (100.0 / psiaFactor)
        }
    }
    let kpaToInhgFactor: Double = 0.2953
    
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
            units = AutoClaveEnums.AnalogUnits(rawValue: userTemperatureUnit)!
            unitsTypes = .temperature
        }
        
        if let userPressureUnit = Defaults[.userPressureUnit],
            units == .kpa || units == .psia || units == .psig || units == .barA || units == .barG || units == .inhg || units == .mbar {
            units = AutoClaveEnums.AnalogUnits(rawValue: userPressureUnit)!
            unitsTypes = .pressure
        }
    }
    
    // MARK: - Temperature Unit Methods
    
    func getUnit() -> Double {
        switch units {
        case .celsius:
            return value
        case .fahrenheit:
            return ((value * 1.8) + 32)
        case .kpa:
            return value
        case .psia:
            return (value * kpaToPSIAFactor)
        case .psig:
            return getPsigValue()
        case .barA:
            return (value / 100)
        case .barG:
            if value.isNaN {
                return 0
            } else {
                return (value - atmosphericPressure) * kpaToInhgFactor
            }
        case .inhg:
            return (value * kpaToInhgFactor)
        case .mbar:
            return abs((value / 10) * 100)
        }
    }
    
    func getFormattedUnit() -> String {
        let unitValue = getUnit().roundToPlaces(places: 1).clearZeroIfNeeded
        switch units {
        case .celsius:
            return "\(unitValue) °C"
        case .fahrenheit:
            return "\(unitValue) °F"
        case .kpa:
            return "\(unitValue) kPa"
        case .psia:
            return "\(unitValue) Psia"
        case .psig:
            if (value <= atmosphericPressure) {
                // We cannot display 0 or negative numbers for Psig, so it needs to be in inHg values
                return "\(unitValue) inHg"
            }
            return "\(unitValue) Psig"
        case .barA:
            return "\(unitValue) BarA"
        case .barG:
            return "\(unitValue) BarG"
        case .inhg:
            return "\(unitValue) inHg"
        case .mbar:
            return "\(unitValue) Mbar"
        }
    }
    
    private func getPsigValue() -> Double {
        
        if atmosphericPressure.isNaN {
            return 0
        }
        
        /*
         * Requested by the customer:
         * If open door + Psig is -10 or +10 than the current atmosphere pressure, return 0.
         *
         * Example:
         * -> Door Open
         * -> Atmosphere pressure is 100.0
         * -> Psig value is between 90.0 and 110.0
         * = Return 0
         */
        if let machine = MachineMonitoring.shared.currentConnection?.machine?.realTime {
            let minAtmosphere = atmosphericPressure - 10
            let maxAtmosphere = atmosphericPressure + 10
            if value >= minAtmosphere && value <= maxAtmosphere,
                machine.doorState == .door1Opened {
                return 0
            }
        }
        
        if (value >= atmosphericPressure) {
            return (value - atmosphericPressure) * kpaToPSIGFactor
        } else {
            // We cannot display 0 or negative numbers for Psig, so it needs to be in inHg values
            return abs((value - atmosphericPressure) * kpaToInhgFactor)
        }
    }
    
}
