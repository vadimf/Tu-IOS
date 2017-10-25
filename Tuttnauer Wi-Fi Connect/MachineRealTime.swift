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
    
    var systemStatus: AutoClaveEnums.SystemCurrentStatus?
    var screenSaverOn: Int = 0
    var doorState: AutoClaveEnums.DoorState?
    
    var cycleName: AutoClaveEnums.CycleID?
    var cycleStage: AutoClaveEnums.CycleStage? {
        didSet {
            updateSystemStatus() // Did this because there is no way to determine RealTimeStateSystemStatus (according to Avi)
        }
    }
    var cycleSubStage: AutoClaveEnums.CycleSubStage?
    var cycleError: AutoClaveEnums.CycleError?
    
    // MARK: - Current Cycle Properties
    
    var analogInput1IOMapping: Int = 0
    var analogInput2IOMapping: Int = 0
    var analogInput3IOMapping: Int = 0
    var cycleTemperatureSensor1: Int = 0
    var cycleTemperatureSensor2: Int = 0
    var cycleTemperatureSensor3: Int = 0
    var cycleTemperatureSensor4: Int = 0
    var currentCycleIconID: Int = 0
    
    private func updateSystemStatus() {
        switch cycleStage! {
        case .none:
            systemStatus = AutoClaveEnums.SystemCurrentStatus.none
        case .done:
            systemStatus = AutoClaveEnums.SystemCurrentStatus.cycleDone
        default:
            systemStatus = AutoClaveEnums.SystemCurrentStatus.cycleRunning
        }
    }
    
}
