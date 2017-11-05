//
//  Machine.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/19/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class Machine: NSObject {
    
    // Version Info
    var magicNumber: String = ""
    var bsVersion: String = ""
    
    // Setup Definition
    var modelName: String = ""
    var serialNumber: String = ""
    var ipAddress: String = ""
    var currentLanguage: Int = 0
    var currentPressureUnits: Int = 0
    var currentTemperatureUnits: Int = 0
    
    // Real Time Data
    var realTime: MachineRealTime?
    
}
