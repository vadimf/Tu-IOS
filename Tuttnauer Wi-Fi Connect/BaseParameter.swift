
//
//  BaseParameter.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/29/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class BaseParameter: NSObject {

    var name: String = ""
    var value: Double = 0
    var units: AutoClaveEnums.MainParametersUnits = AutoClaveEnums.MainParametersUnits.temperature
    
    init(name: String, value: Double, units: AutoClaveEnums.MainParametersUnits) {
        super.init()
        self.name = name
        self.value = value.roundToPlaces(places: 2)
        self.units = units
    }
    
}
