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
    
    // MARK: - Sensors
    
    var sensor1: BaseSensor?
    var sensor2: BaseSensor?
    var sensor3: BaseSensor?
    
    // MARK: Update Methods
    
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
