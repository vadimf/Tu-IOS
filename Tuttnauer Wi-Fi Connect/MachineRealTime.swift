//
//  MachineRealTime.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import UIKit.UIImage

class MachineRealTime: NSObject {

    // MARK: - Real Time Data
    
    var systemStatus: AutoClaveEnums.SystemCurrentStatus?
    var backgroundStatus = [String]()
    var screenSaverOn: Int = 0
    var doorState: AutoClaveEnums.DoorState?
    var atmosphericPressure: Double = 100.0
    
    var cycleID: AutoClaveEnums.CycleID?
    var cycleName: String?
    var cycleIconID: Int = 9 // Default, blank icon
    var cycleIcon: UIImage! {
        get {
            return UIImage(named: "icon_cycle_\(self.cycleIconID)")
        }
    }
    var cycleStage: AutoClaveEnums.CycleStage? {
        didSet {
            updateSystemStatus() // Did this because there is no way to determine RealTimeStateSystemStatus (according to Avi)
        }
    }
    var cycleStageTimerMachineGMT: TimeInterval?
    var cycleStageTimerIsOn: Bool = false
    var cycleStageTimer: String? {
        get {
            if let start = cycleStageStartTime, let end = cycleStageEndTime {
                return updatedTimer(startDate: start, endDate: end)
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
    
    private func updatedTimer(startDate: Date, endDate: Date) -> String {
        // Find out what is the difference between GMT to the machine time
        //let secondsFromGMT = TimeInterval(TimeZone.current.secondsFromGMT())
        guard let machineGMT = self.cycleStageTimerMachineGMT else { return "" }
        var now = Date()
        now.addTimeInterval(machineGMT)
        return now.minutesAndSeconds(until: endDate)
    }
    
}
