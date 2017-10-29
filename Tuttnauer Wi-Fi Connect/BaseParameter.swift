
//
//  BaseParameter.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/29/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class BaseParameter: NSObject {

    var id: Int = 0
    var name: String = ""
    var value: Double = 0
    var type: AutoClaveEnums.MainParametersNames = AutoClaveEnums.MainParametersNames.none
    
    // MARK: - Initialization
    
    init(id: Int, name: String, value: Double) {
        super.init()
        self.id = id
        self.name = name
        self.value = value
        
        switch self.id {
        case AutoClaveEnums.MainParametersNames.sterTemperature.rawValue:
            type = .sterTemperature
        case AutoClaveEnums.MainParametersNames.sterTime.rawValue:
            type = .sterTime
        case AutoClaveEnums.MainParametersNames.dryTime.rawValue:
            type = .dryTime
        default:
            type = .none
        }
    }
    
    // MARK: - Unit Methods
    
    func getFormattedUnit() -> String {
        switch self.type {
        case .sterTemperature:
            if let userTemperatureUnit = Defaults[.userTemperatureUnit] {
                if userTemperatureUnit == AutoClaveEnums.AnalogUnits.celsius.rawValue {
                    return "\(self.value) °C"
                } else {
                    return "\((self.value * 1.8) + 32) °F"
                }
            } else {
                return "\(self.value)"
            }
        default:
            return "\(self.value)"
        }
    }
    
}
