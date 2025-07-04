//
//  MachineConnection.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 11/6/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

typealias MachineConnectCompletionHandler = (_ success: Bool,_ error: NSError?) -> Void
typealias MachineRegistersCompletionHandler = (_ data: [AnyObject]?, _ error: NSError?) -> Void

protocol MachineConnectionDelegate {
    func didConnect(to connection: MachineConnection, success: Bool)
    func didDisconnect(from connection: MachineConnection)
    func didLoseConnection(to connection: MachineConnection)
    func didUpdateSetupData(for connection: MachineConnection, machine: Machine)
    func didUpdateRealTimeData(for connection: MachineConnection, machine: Machine)
}

class MachineConnection: NSObject {

    fileprivate var delegate: MachineConnectionDelegate?
    
    fileprivate var modbus: SwiftLibModbus!
    
    var machine: Machine?
    var ipAddress: String!
    var isConnected: Bool = false
    var isFetching: Bool = false
    
    var operationTimeOutTimes: Int = 8 // The operation timeout times allowed before disconnecting
    var operationTimedOutCounter: Int = 0
    
    var timer: Timer?
    
    // MARK: Initialization
    
    init(ipAddress: String, delegate: MachineConnectionDelegate?) {
        super.init()
        self.modbus = SwiftLibModbus(ipAddress: ipAddress as NSString, port: 502, device: 1)
        self.delegate = delegate
        self.ipAddress = ipAddress
        self.connect(completion: nil)
    }
    
    // MARK: Connecting & Disconnecting
    
    func connect(completion: MachineConnectCompletionHandler?) {
        modbus.connect(success: {
            self.isConnected = true
            if self.machine == nil {
                self.machine = Machine()
                self.machine?.ipAddress = self.ipAddress
            }
            completion?(true, nil)
            self.delegate?.didConnect(to: self, success: true)
        }, failure: { error in
            self.isConnected = false
            completion?(false, error)
            self.delegate?.didConnect(to: self, success: false)
            print(error.localizedDescription)
        })
    }
    
    func disconnect() {
        modbus.disconnect()
        isConnected = false
        stopFetching()
        delegate?.didDisconnect(from: self)
    }
    
    func disconnectAfterLostConnection() {
        modbus.disconnect()
        isConnected = false
        stopFetching()
        delegate?.didLoseConnection(to: self)
    }
    
    fileprivate func checkConnection(error: NSError) {
        
        print(error.localizedDescription)

        if error.code == 54 {
            disconnectAfterLostConnection()
        } else if error.code == 60 {
            operationTimedOutCounter += 1
    
            if operationTimedOutCounter > operationTimeOutTimes { // If operation has timed out by the machine more than X times, let's not take a risk and disconnect
                disconnectAfterLostConnection()
                return
            }
            
            if let networkReachability = NetworkManager.shared.reachability,
                !networkReachability.isReachableViaWiFi {
                disconnectAfterLostConnection()
                return
            }
        }
    }
    
    // MARK: - Fetch Start & Stop
    
    func startFetching() {
        if isConnected {
            print("startFetching() -> IS CONNECTED")
            fetchMachineSetupData()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchMachineRealTimeData), userInfo: nil, repeats: true)
            timer?.fire()
            isFetching = true
        } else {
            print("startFetching() -> NOT CONNECTED")
            connect { (success, error) in
                print("startFetching() -> DID CONNECT")
                if success {
                    self.startFetching()
                } else {
                    self.stopFetching()
                }
            }
        }
    }
    
    func stopFetching(shouldDisconnect: Bool = false) {
        guard timer != nil else { return }
        timer!.invalidate()
        timer = nil
        isFetching = false
        if shouldDisconnect {
            modbus.disconnect()
            isConnected = false
        }
    }

}

// MARK: - Fetch Data Methods

extension MachineConnection {
    
    func fetchMachineSetupData() {
        modbusMachineSetupData()
    }
    
    @objc fileprivate func fetchMachineRealTimeData() {
        modbusMachineStateData()
        modbusMachineSensorsData()
        modbusMachineCurrentCycleInfo()
        modbusCurrentCycleParameters()
    }
    
}

// MARK: - Fetch & Parse Modbus Data

extension MachineConnection {
    
    // MARK: Fetch Setup Data
    
    fileprivate func modbusMachineSetupData() {
        
        let versionMajorAddress = MachineConstants.Versions.versionMajor
        let versionMinorAddress = MachineConstants.Versions.versionMinor
        let versionRevisionAddress = MachineConstants.Versions.versionRevision
        let versionBuildAddress = MachineConstants.Versions.versionBuild
        
        let modelNameAddress = MachineConstants.Setup.modelName
        let serialNumberAddress = MachineConstants.Setup.serialNumber
        
        let versionTotalAddresses = (versionMajorAddress.count + versionMinorAddress.count + versionRevisionAddress.count + versionBuildAddress.count)
        let modelTotalAddresses = (modelNameAddress.count + serialNumberAddress.count)
        
        // Get Version Number
        modbus.readRegistersFrom(startAddress: (versionMajorAddress.start - 1), count: versionTotalAddresses, success: { (data) in
            
            self.operationTimedOutCounter = 0
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            let version: String = "\(data[0]).\(data[1]).\(data[3]).\(data[2])"
            machine.bsVersion = version
            
            self.delegate?.didUpdateSetupData(for: self, machine: machine)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.modbusMachineSetupData()
            print(error.localizedDescription)
        })
        
        // Get Model Name & Serial Number
        modbus.readRegistersFrom(startAddress: (modelNameAddress.start - 1), count: modelTotalAddresses, success: { (data) in
            
            self.operationTimedOutCounter = 0
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            let modelName = Array(data[..<Int(modelNameAddress.count)]).generateStringFromIntArray()
            
            var serialNumber: String = ""
            for int in Array(data[Int(modelNameAddress.count + 1)..<Int(modelTotalAddresses)]) {
                if int != 0 {
                    serialNumber += "\(int)"
                }
            }
            
            machine.modelName = modelName
            machine.serialNumber = serialNumber
            machine.ipAddress = String.init(describing: self.modbus!.ipAddress!)
            
            self.delegate?.didUpdateSetupData(for: self, machine: machine)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.modbusMachineSetupData()
        })
        
    }
    
    // MARK: Fetch Real Time State Data
    
    fileprivate func modbusMachineStateData() {
        
        let totalAddresses = MachineConstants.RealTime.total
        
        modbus.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            self.operationTimedOutCounter = 0
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            machine.realTime.backgroundStatus = self.getMachineRealTimeBackgroundStatus(startAddress: totalAddresses.start, data: data)
            machine.realTime.atmosphericPressure = self.getMachineRealTimeAtmosphericPressure(startAddress: totalAddresses.start, data: data)
            machine.realTime.doorState = AutoClaveEnums.DoorState(rawValue: self.getMachineRealTimeDoorState(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.DoorState(rawValue: 0)
            machine.realTime.cycleID = AutoClaveEnums.CycleID(rawValue: self.getMachineRealTimeCurrentCycleID(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleID(rawValue: 0)
            machine.realTime.cycleStage = AutoClaveEnums.CycleStage(rawValue: self.getMachineRealTimeCycleStage(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleStage(rawValue: 0)
            machine.realTime.cycleSubStage = AutoClaveEnums.CycleSubStage(rawValue: self.getMachineRealTimeCycleSubStage(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleSubStage(rawValue: 0)
            machine.realTime.cycleError = AutoClaveEnums.CycleError(rawValue: self.getMachineRealTimeCycleError(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleError(rawValue: 0)
            machine.realTime.cycleStageTimerIsOn = self.getMachineStageTimeIsOn(startAddress: totalAddresses.start, data: data)
            
            if machine.realTime.cycleStageTimerIsOn {
                // When the timer is coming up for the first time, it's values are not good
                if machine.realTime.cycleStageStartTime == nil && machine.realTime.cycleStageEndTime == nil && machine.realTime.cycleStageTimerMachineGMT == nil {
                    let times = self.getMachineStageStartEndTime(startAddress: totalAddresses.start, data: data)
                    machine.realTime.cycleStageTimerMachineGMT = times.machineGMT
                    machine.realTime.cycleStageStartTime = times.start
                    machine.realTime.cycleStageEndTime = times.end
                }
            } else {
                machine.realTime.cycleStageTimerMachineGMT = nil
                machine.realTime.cycleStageStartTime = nil
                machine.realTime.cycleStageEndTime = nil
            }
            
            self.delegate?.didUpdateRealTimeData(for: self, machine: machine)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.modbusMachineStateData()
        })
        
    }
    
    private func getMachineRealTimeCurrentCycleID(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.cycleID
        return data[Int(address.start - startAddress)]
    }
    
    private func getMachineRealTimeBackgroundStatus(startAddress: Int32, data: [Int]) -> [String] {
        let address = MachineConstants.RealTime.systemStatus
        let systemStatusData = Array(data[Int(address.start - startAddress)..<Int(address.end - startAddress + 1)])
        
        let status1 = systemStatusData[3].toInt16BinaryArray(reversed: true)
        let status2 = systemStatusData[2].toInt16BinaryArray(reversed: true)
        let status3 = systemStatusData[1].toInt16BinaryArray(reversed: true)
        let status4 = systemStatusData[0].toInt16BinaryArray(reversed: true)
        
        let statusData = status1 + status2 + status3 + status4
        
        var statuses = [String]()
        
        for (index, status) in statusData.enumerated() {
            if status == 1,
                let name = AutoClaveEnums.BackgroundStatus(rawValue: (index + 1))?.getName {
                statuses.append(name)
            }
        }
        
        return statuses
    }
    
    private func getMachineRealTimeDoorState(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.doorState
        return data[Int(address.start - startAddress)]
    }
    
    private func getMachineRealTimeAtmosphericPressure(startAddress: Int32, data: [Int]) -> Double {
        let address = MachineConstants.RealTime.atmospherePressure
        let data = Array(data[Int(address.start - startAddress)..<Int(address.end - startAddress + 1)])
        let pressure = Utilities.decimalsToDouble(decimals: data)
        return pressure
    }
    
    private func getMachineRealTimeCycleStage(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.cycleStage
        return data[Int(address.start - startAddress)]
    }
    
    private func getMachineRealTimeCycleSubStage(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.cycleSubStage
        return data[Int(address.start - startAddress)]
    }
    
    private func getMachineRealTimeCycleError(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.cycleError
        return data[Int(address.start - startAddress)]
    }
    
    private func getMachineStageTimeIsOn(startAddress: Int32, data: [Int]) -> Bool {
        let address = MachineConstants.RealTime.isStageTimerOn
        let isOn = data[Int(address.start - startAddress)]
        if isOn == 1 { return true } else { return false }
    }
    
    private func getMachineStageStartEndTime(startAddress: Int32, data: [Int]) -> (start: Date?, end: Date?, machineGMT: TimeInterval?) {
        
        let startTimeAddress = MachineConstants.RealTime.stageStartTime
        let endTimeAddress = MachineConstants.RealTime.stageEndTime
        
        let startTimeData = Array(data[Int(startTimeAddress.start - startAddress)..<Int(startTimeAddress.end - startAddress + 1)])
        let endTimeData = Array(data[Int(endTimeAddress.start - startAddress)..<Int(endTimeAddress.end - startAddress + 1)])

        let startTime = Utilities.decimalsTicksToDate(decimals: startTimeData)
        let endTime = Utilities.decimalsTicksToDate(decimals: endTimeData)
        
        guard startTime.timeIntervalSinceReferenceDate > 0, endTime.timeIntervalSinceReferenceDate > 0 else {
            return (nil, nil, nil)
        }
        
        // Finding the machine's GMT
        let machineGMT = (startTime.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
        let machineGMTHours = round(machineGMT / 60 / 60)
        let machineGMTSeconds = TimeInterval(machineGMTHours * 60 * 60)
        
        return (startTime, endTime, machineGMTSeconds)
    }
    
    // MARK: - Fetch Real Time Sensors Data
    
    fileprivate func modbusMachineSensorsData() {
        
        let totalAddresses = MachineConstants.Sensors.total
        
        modbus.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            self.operationTimedOutCounter = 0
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            let pressure = machine.realTime.atmosphericPressure
            let sensorNames = self.getMachineSensorsNames(startAddress: totalAddresses.start, data: data)
            let sensorValues = self.getMachineSensorsValues(startAddress: totalAddresses.start, data: data)
            let sensorsUnits = self.getMachineSensorsUnits(startAddress: totalAddresses.start, data: data)
            
            if !sensorNames.0.isEmpty {
                if machine.realTime.sensor1 == nil {
                    let sensor1 = BaseSensor(name: sensorNames.0, value: sensorValues.0, units: sensorsUnits.0, pressure: pressure)
                    machine.realTime.sensor1 = sensor1
                } else {
                    machine.realTime.sensor1?.updateValues(name: sensorNames.0, value: sensorValues.0, units: sensorsUnits.0, pressure: pressure)
                }
            } else {
                machine.realTime.sensor1 = nil
            }
            
            if !sensorNames.1.isEmpty {
                if machine.realTime.sensor2 == nil {
                    let sensor2 = BaseSensor(name: sensorNames.1, value: sensorValues.1, units: sensorsUnits.1, pressure: pressure)
                    machine.realTime.sensor2 = sensor2
                } else {
                    machine.realTime.sensor2?.updateValues(name: sensorNames.1, value: sensorValues.1, units: sensorsUnits.1, pressure: pressure)
                }
            } else {
                machine.realTime.sensor2 = nil
            }
            
            if !sensorNames.2.isEmpty {
                if machine.realTime.sensor3 == nil {
                    let sensor3 = BaseSensor(name: sensorNames.2, value: sensorValues.2, units: sensorsUnits.2, pressure: pressure)
                    machine.realTime.sensor3 = sensor3
                } else {
                    machine.realTime.sensor3?.updateValues(name: sensorNames.2, value: sensorValues.2, units: sensorsUnits.2, pressure: pressure)
                }
            } else {
                machine.realTime.sensor3 = nil
            }
            
            self.delegate?.didUpdateRealTimeData(for: self, machine: machine)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.modbusMachineSensorsData()
        })
        
    }
    
    private func getMachineSensorsNames(startAddress: Int32, data: [Int]) -> (String, String, String) {
        
        let sensor1Address = MachineConstants.Sensors.analogInput1ShortName
        let sensor2Address = MachineConstants.Sensors.analogInput2ShortName
        let sensor3Address = MachineConstants.Sensors.analogInput3ShortName
        
        let sensor1Name = AutoClaveEnums.AnalogInputShorNames(rawValue: data[Int(sensor1Address.start - startAddress)])?.getName ?? AutoClaveEnums.AnalogInputShorNames.none.getName
        let sensor2Name = AutoClaveEnums.AnalogInputShorNames(rawValue: data[Int(sensor2Address.start - startAddress)])?.getName ?? AutoClaveEnums.AnalogInputShorNames.none.getName
        let sensor3Name = AutoClaveEnums.AnalogInputShorNames(rawValue: data[Int(sensor3Address.start - startAddress)])?.getName ?? AutoClaveEnums.AnalogInputShorNames.none.getName
        
        return (sensor1Name, sensor2Name, sensor3Name)
    }
    
    private func getMachineSensorsValues(startAddress: Int32, data: [Int]) -> (Double, Double, Double) {
        
        let sensor1Address = MachineConstants.Sensors.analogInput1Value
        let sensor2Address = MachineConstants.Sensors.analogInput2Value
        let sensor3Address = MachineConstants.Sensors.analogInput3Value
        
        let sensor1 = Array(data[Int(sensor1Address.start - startAddress)..<Int(sensor1Address.end - startAddress + 1)])
        let sensor2 = Array(data[Int(sensor2Address.start - startAddress)..<Int(sensor2Address.end - startAddress + 1)])
        let sensor3 = Array(data[Int(sensor3Address.start - startAddress)..<Int(sensor3Address.end - startAddress + 1)])
        
        var sensor1Value = Utilities.decimalsToDouble(decimals: sensor1)
        var sensor2Value = Utilities.decimalsToDouble(decimals: sensor2)
        var sensor3Value = Utilities.decimalsToDouble(decimals: sensor3)
        
        if sensor1Value.isNaN {
            sensor1Value = 0
        }
        
        if sensor2Value.isNaN {
            sensor2Value = 0
        }
        
        if sensor3Value.isNaN {
            sensor3Value = 0
        }
        
        return (sensor1Value, sensor2Value, sensor3Value)
    }
    
    private func getMachineSensorsUnits(startAddress: Int32, data: [Int]) -> (AutoClaveEnums.AnalogUnits, AutoClaveEnums.AnalogUnits, AutoClaveEnums.AnalogUnits) {
        
        let sensor1Address = MachineConstants.Sensors.analog1Units
        let sensor2Address = MachineConstants.Sensors.analog2Units
        let sensor3Address = MachineConstants.Sensors.analog3Units
        
        let sensor1Units = AutoClaveEnums.AnalogUnits(rawValue: data[Int(sensor1Address.start - startAddress)]) ?? AutoClaveEnums.AnalogUnits.celsius
        let sensor2Units = AutoClaveEnums.AnalogUnits(rawValue: data[Int(sensor2Address.start - startAddress)]) ?? AutoClaveEnums.AnalogUnits.celsius
        let sensor3Units = AutoClaveEnums.AnalogUnits(rawValue: data[Int(sensor3Address.start - startAddress)]) ?? AutoClaveEnums.AnalogUnits.celsius
        
        return (sensor1Units, sensor2Units, sensor3Units)
    }
    
    // MARK: Fetch Current Cycle Information
    
    fileprivate func modbusMachineCurrentCycleInfo() {
        
        // Cycle Name
        let cycleNameAddresses = MachineConstants.CycleInfo.total
        
        modbus.readRegistersFrom(startAddress: (cycleNameAddresses.start - 1), count: cycleNameAddresses.count, success: { (data) in
            
            self.operationTimedOutCounter = 0
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            let cycleName = self.getMachineCycleName(startAddress: cycleNameAddresses.start, data: data)
            
            if machine.realTime.cycleName != cycleName {
                machine.realTime.cycleName = cycleName
                self.delegate?.didUpdateRealTimeData(for: self, machine: machine)
            }
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.modbusMachineCurrentCycleInfo()
        })
        
        // Cycle Icon
        
        let cycleIconIDAddress = MachineConstants.CurrentCycleProperties.cycleIcon
        
        modbus.readRegistersFrom(startAddress: (cycleIconIDAddress.start - 1), count: cycleIconIDAddress.count, success: { (data) in
            
            self.operationTimedOutCounter = 0
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            let cycleIconID = data[0]
            
            if machine.realTime.cycleIconID != cycleIconID {
                machine.realTime.cycleIconID = cycleIconID
                self.delegate?.didUpdateRealTimeData(for: self, machine: machine)
            }
        
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.modbusMachineCurrentCycleInfo()
        })
        
    }
    
    private func getMachineCycleName(startAddress: Int32, data: [Int]) -> String {
        let cycleNameAddress = MachineConstants.CycleInfo.currentCycleName
        let cycleName = Array(data[Int(cycleNameAddress.start - startAddress)..<Int(cycleNameAddress.end - startAddress + 1)])
        let cycleNameValue = Utilities.decimalsToString(decimals: cycleName)
        return cycleNameValue
    }
    
    private func getMachineCycleIconID(startAddress: Int32, data: [Int]) -> Int {
        let cycleIconID = Utilities.decimalsToInt(decimals: data)
        return cycleIconID
    }
    
    // MARK: Current Cycle Parameters
    
    fileprivate func modbusCurrentCycleParameters() {
        
        let totalAddresses = MachineConstants.CycleParameters.total
        
        modbus.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            self.operationTimedOutCounter = 0
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            let parametersNames = self.getMachinePrametersIDs(startAddress: totalAddresses.start, data: data)
            let parametersValues = self.getMachineParametersValues(startAddress: totalAddresses.start, data: data)
            
            let parameter1 = BaseParameter(id: parametersNames.0, name: parametersNames.1, value: parametersValues.0)
            let parameter2 = BaseParameter(id: parametersNames.2, name: parametersNames.3, value: parametersValues.1)
            let parameter3 = BaseParameter(id: parametersNames.4, name: parametersNames.5, value: parametersValues.2)
            
            if !parameter1.name.isEmpty {
                machine.realTime.parameter1 = parameter1
            } else {
                machine.realTime.parameter1 = nil
            }
            
            if !parameter2.name.isEmpty {
                machine.realTime.parameter2 = parameter2
            } else {
                machine.realTime.parameter2 = nil
            }
            
            if !parameter3.name.isEmpty {
               machine.realTime.parameter3 = parameter3
            } else {
                machine.realTime.parameter3 = nil
            }
            
            self.delegate?.didUpdateRealTimeData(for: self, machine: machine)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.modbusCurrentCycleParameters()
        })
        
    }
    
    private func getMachinePrametersIDs(startAddress: Int32, data: [Int]) -> (Int, String, Int, String, Int, String) {
        
        let parameter1Address = MachineConstants.CycleParameters.parameter1ID
        let parameter2Address = MachineConstants.CycleParameters.parameter2ID
        let parameter3Address = MachineConstants.CycleParameters.parameter3ID
        
        let parameter1ID = data[Int(parameter1Address.start - startAddress)]
        let parameter2ID = data[Int(parameter2Address.start - startAddress)]
        let parameter3ID = data[Int(parameter3Address.start - startAddress)]
        
        let paramter1Name = AutoClaveEnums.MainParametersNames(rawValue: parameter1ID)?.getName ?? AutoClaveEnums.MainParametersNames.none.getName
        let paramter2Name = AutoClaveEnums.MainParametersNames(rawValue: parameter2ID)?.getName ?? AutoClaveEnums.MainParametersNames.none.getName
        let paramter3Name = AutoClaveEnums.MainParametersNames(rawValue: parameter3ID)?.getName ?? AutoClaveEnums.MainParametersNames.none.getName
        
        return (parameter1ID, paramter1Name, parameter2ID, paramter2Name, parameter3ID, paramter3Name)
    }
    
    private func getMachineParametersValues(startAddress: Int32, data: [Int]) -> (Double, Double, Double) {
        
        let parameter1Address = MachineConstants.CycleParameters.parameter1Value
        let parameter2Address = MachineConstants.CycleParameters.parameter2Value
        let parameter3Address = MachineConstants.CycleParameters.parameter3Value
        
        let parameter1 = Array(data[Int(parameter1Address.start - startAddress)..<Int(parameter1Address.end - startAddress + 1)])
        let parameter2 = Array(data[Int(parameter2Address.start - startAddress)..<Int(parameter2Address.end - startAddress + 1)])
        let parameter3 = Array(data[Int(parameter3Address.start - startAddress)..<Int(parameter3Address.end - startAddress + 1)])
        
        let parameter1Value = Utilities.decimalsToDouble(decimals: parameter1)
        let parameter2Value = Utilities.decimalsToDouble(decimals: parameter2)
        let parameter3Value = Utilities.decimalsToDouble(decimals: parameter3)
        
        return (parameter1Value, parameter2Value, parameter3Value)
    }
    
}
