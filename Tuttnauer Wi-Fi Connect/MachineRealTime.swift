//
//  MachineRealTime.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class MachineRealTime: NSObject {

    // MARK: - Real Time Data
    
    var systemStatus: Int = 0
    var cycleName: AutoClaveEnums.CycleID?
    var screenSaverOn: Int = 0
    var doorState: AutoClaveEnums.DoorState?
    
    // MARK: - Current Cycle Properties
    
    var analogInput1IOMapping: Int = 0
    var analogInput2IOMapping: Int = 0
    var analogInput3IOMapping: Int = 0
    var cycleTemperatureSensor1: Int = 0
    var cycleTemperatureSensor2: Int = 0
    var cycleTemperatureSensor3: Int = 0
    var cycleTemperatureSensor4: Int = 0
    var currentCycleIconID: Int = 0
    
}
