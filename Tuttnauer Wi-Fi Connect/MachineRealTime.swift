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
    var backgroundStatus = [String]()
    var screenSaverOn: Int = 0
    var doorState: AutoClaveEnums.DoorState?
    var atmosphericPressure: Double = 100.0
    
    var cycleID: AutoClaveEnums.CycleID?
    var cycleName: String?
    var cycleStage: AutoClaveEnums.CycleStage? {
        didSet {
            updateSystemStatus() // Did this because there is no way to determine RealTimeStateSystemStatus (according to Avi)
        }
    }
    var cycleStageTimerIsOn: Bool = false
    var cycleStageTimer: String? {
        get {
            if let end = cycleStageEndTime {
                return updatedTimer(endDate: end)
            } else {
                return nil
            }
        }
    }
    var cycleStageStartTime: Date?
    var cycleStageEndTime: Date?
    var cycleSubStage: AutoClaveEnums.CycleSubStage?
    var cycleError: AutoClaveEnums.CycleError? {
        didSet {
            updateSystemStatus()
        }
    }
    
    // MARK: - Sensors
    
    var sensor1: BaseSensor?
    var sensor2: BaseSensor?
    var sensor3: BaseSensor?
    
    // MARK: - Main Parameters
    
    var parameter1: BaseParameter?
    var parameter2: BaseParameter?
    var parameter3: BaseParameter?
    
    // MARK: - Update Methods
    
    private func updateSystemStatus() {
        
        if cycleError != nil && cycleError != AutoClaveEnums.CycleError.none {
            systemStatus = AutoClaveEnums.SystemCurrentStatus.cycleFail
            return
        }
        
        if doorState == .door1Opened {
            systemStatus = AutoClaveEnums.SystemCurrentStatus.notReady
            return
        }
        
        switch cycleStage! {
        case .none:
            systemStatus = AutoClaveEnums.SystemCurrentStatus.none
        case .done:
            systemStatus = AutoClaveEnums.SystemCurrentStatus.cycleDone
        default:
            systemStatus = AutoClaveEnums.SystemCurrentStatus.cycleRunning
        }
    }
    
    private func updatedTimer(endDate: Date) -> String {
        
        return Date().minutesAndSeconds(until: endDate)
    }
    
}
