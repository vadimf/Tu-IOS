//
//  MachineNetworking.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/23/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

typealias MachineConnectCompletionHandler = (_ success: Bool,_ error: NSError?) -> Void
typealias MachineRegistersCompletionHandler = (_ data: [AnyObject]?, _ error: NSError?) -> Void

protocol MachineNetworkingDelegate {
    func receivedMachineSetupData(with machine: Machine)
    func receivedMachineRealTimeStateData(with machineRealTimeState: MachineRealTime)
    func receivedMachineSensorsData(with machineRealTimeState: MachineRealTime)
    func receivedMachineParametersData(with machineRealTimeState: MachineRealTime)
    func didDisconnectFromMachine()
    func connectionLost()
}

class MachineNetworking: NSObject {
    
    static let shared = MachineNetworking()
    
    var delegate: MachineNetworkingDelegate?
    
    private var modbus: SwiftLibModbus?
    
    private var machine: Machine?
    private var machineRealTime: MachineRealTime?
    
    // MARK: - Connecting & Disconnecting
    
    func connect(ipAddress: String, completion: MachineConnectCompletionHandler?) {
        
        // Create a new Modbus instance
        modbus = SwiftLibModbus(ipAddress: ipAddress as NSString, port: 502, device: 1)
        
        // Connect
        modbus?.connect(success: {
            completion?(true, nil)
            self.machine = Machine()
            self.machineRealTime = MachineRealTime()
            print("Connected to:", ipAddress)
        }, failure: { error in
            completion?(false, error)
            print(error.localizedDescription)
        })
    }
    
    func reconnect(completion: MachineConnectCompletionHandler?) {
        guard let machine = self.machine else { return }
        print("Reconnecting to:", machine.ipAddress)
        connect(ipAddress: machine.ipAddress) { (success, error) in
            if success {
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
    
    func checkConnection(error: NSError) {
        if error.code == 54 {
            delegate?.connectionLost()
        }
        print(error.localizedDescription)
    }
    
    func disconnect() {
        modbus?.disconnect()
        modbus = nil
        machine = nil
        machineRealTime = nil
        delegate?.didDisconnectFromMachine()
    }
    
    // MARK: - Machine Setup Methods
    
    func getMachineSetupData() {
        
        let versionMajorAddress = MachineConstants.Versions.versionMajor
        let versionMinorAddress = MachineConstants.Versions.versionMinor
        let versionRevisionAddress = MachineConstants.Versions.versionRevision
        let versionBuildAddress = MachineConstants.Versions.versionBuild
        
        let modelNameAddress = MachineConstants.Setup.modelName
        let serialNumberAddress = MachineConstants.Setup.serialNumber
        
        let versionTotalAddresses = (versionMajorAddress.count + versionMinorAddress.count + versionRevisionAddress.count + versionBuildAddress.count)
        let modelTotalAddresses = (modelNameAddress.count + serialNumberAddress.count)
        
        // Get Version Number
        modbus?.readRegistersFrom(startAddress: (versionMajorAddress.start - 1), count: versionTotalAddresses, success: { (data) in
            
            print("Received version number")
            
            guard let data = data as? [Int],
                let machine = self.machine else { return }
            
            let version: String = "\(data[0]).\(data[1]).\(data[3]).\(data[2])"
            machine.bsVersion = version
            
            self.delegate?.receivedMachineSetupData(with: machine)
            
        }, failure: { (error) in
            self.getMachineSetupData()
            print(error.localizedDescription)
        })
        
        // Get Model Name & Serial Number
        modbus?.readRegistersFrom(startAddress: (modelNameAddress.start - 1), count: modelTotalAddresses, success: { (data) in
            
            print("Received model name")
            
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
            
            self.delegate?.receivedMachineSetupData(with: machine)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.getMachineSetupData()
        })
        
    }
    
    // MARK: - Machine Real Time Observer Methods
    
    func getMachineRealTimeStateData() {
        
        let totalAddresses = MachineConstants.RealTime.total
        
        modbus?.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            print("Received Real Time Data")
            
            guard let data = data as? [Int],
                let machineRealTime = self.machineRealTime else { return }
            
            machineRealTime.doorState = AutoClaveEnums.DoorState(rawValue: self.getMachineRealTimeDoorState(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.DoorState(rawValue: 0)
            machineRealTime.cycleName = AutoClaveEnums.CycleID(rawValue: self.getMachineRealTimeCurrentCycleID(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleID(rawValue: 0)
            machineRealTime.cycleStage = AutoClaveEnums.CycleStage(rawValue: self.getMachineRealTimeCycleStage(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleStage(rawValue: 0)
            machineRealTime.cycleSubStage = AutoClaveEnums.CycleSubStage(rawValue: self.getMachineRealTimeCycleSubStage(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleSubStage(rawValue: 0)
            machineRealTime.cycleError = AutoClaveEnums.CycleError(rawValue: self.getMachineRealTimeCycleError(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleError(rawValue: 0)
            
            self.delegate?.receivedMachineRealTimeStateData(with: machineRealTime)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.getMachineRealTimeStateData()
        })
        
    }
    
    private func getMachineRealTimeCurrentCycleID(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.cycleID
        return data[Int(address.start - startAddress)]
    }
    
    private func getMachineRealTimeCurrentStatus(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.systemStatus
        return data[Int(address.start - startAddress)] // TODO: it's 4 addresses, translate that to a String
    }
    
    private func getMachineRealTimeDoorState(startAddress: Int32, data: [Int]) -> Int {
        let address = MachineConstants.RealTime.doorState
        return data[Int(address.start - startAddress)]
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
    
    // MARK: - Current Cycle Sensors Observer Methods
    
    func getMachineSensorsData() {
        
        let totalAddresses = MachineConstants.Sensors.total
        
        modbus?.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            print("Received Sensors Data")
            
            guard let data = data as? [Int],
                let machineRealTime = self.machineRealTime else { return }
            
            let sensorNames = self.getMachineSensorsNames(startAddress: totalAddresses.start, data: data)
            let sensorValues = self.getMachineSensorsValues(startAddress: totalAddresses.start, data: data)
            let sensorsUnits = self.getMachineSensorsUnits(startAddress: totalAddresses.start, data: data)
            
            let sensor1 = BaseSensor(name: sensorNames.0, value: sensorValues.0, units: sensorsUnits.0)
            let sensor2 = BaseSensor(name: sensorNames.1, value: sensorValues.1, units: sensorsUnits.1)
            let sensor3 = BaseSensor(name: sensorNames.2, value: sensorValues.2, units: sensorsUnits.2)
            
            // Check if larger than 3. Solves a certain bug where the machine sometimes sends a faulty double 2.234352...
            
            if sensor1.value > 3 {
                machineRealTime.sensor1 = sensor1
            } else {
                machineRealTime.sensor1 = nil
            }
            
            if sensor2.value > 3 {
                machineRealTime.sensor2 = sensor2
            } else {
                machineRealTime.sensor2 = nil
            }
            
            if sensor3.value > 3 {
                machineRealTime.sensor3 = sensor3
            } else {
                machineRealTime.sensor3 = nil
            }
            
            self.delegate?.receivedMachineSensorsData(with: machineRealTime)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.getMachineSensorsData()
        })
        
    }
    
    private func getMachineSensorsNames(startAddress: Int32, data: [Int]) -> (String, String, String) {
        
        let sensor1Address = MachineConstants.Sensors.analogInput1ShortName
        let sensor2Address = MachineConstants.Sensors.analogInput2ShortName
        let sensor3Address = MachineConstants.Sensors.analogInput3ShortName
        
        let sensor1Name = AutoClaveEnums.AnalogInputShorNames(rawValue: data[Int(sensor1Address.start - startAddress)])?.getName ?? ""
        let sensor2Name = AutoClaveEnums.AnalogInputShorNames(rawValue: data[Int(sensor2Address.start - startAddress)])?.getName ?? ""
        let sensor3Name = AutoClaveEnums.AnalogInputShorNames(rawValue: data[Int(sensor3Address.start - startAddress)])?.getName ?? ""
        
        return (sensor1Name, sensor2Name, sensor3Name)
    }
    
    private func getMachineSensorsValues(startAddress: Int32, data: [Int]) -> (Double, Double, Double) {
        
        let sensor1Address = MachineConstants.Sensors.analogInput1Value
        let sensor2Address = MachineConstants.Sensors.analogInput2Value
        let sensor3Address = MachineConstants.Sensors.analogInput3Value
        
        let sensor1 = Array(data[Int(sensor1Address.start - startAddress)..<Int(sensor1Address.end - startAddress + 1)])
        let sensor2 = Array(data[Int(sensor2Address.start - startAddress)..<Int(sensor2Address.end - startAddress + 1)])
        let sensor3 = Array(data[Int(sensor3Address.start - startAddress)..<Int(sensor3Address.end - startAddress + 1)])
        
        let sensor1Value = Utilities.decimalsToDouble(decimals: sensor1)
        let sensor2Value = Utilities.decimalsToDouble(decimals: sensor2)
        let sensor3Value = Utilities.decimalsToDouble(decimals: sensor3)
        
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
    
    // MARK: - Current Cycle Parameters Observer Methods
    
    func getMachineCycleParametersData() {
        
        let totalAddresses = MachineConstants.CycleParameters.total
        
        modbus?.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            print("Received Cycle Prameters Data")
            
            guard let data = data as? [Int],
                let machineRealTime = self.machineRealTime else { return }
            
            let parametersNames = self.getMachinePrametersIDs(startAddress: totalAddresses.start, data: data)
            let parametersValues = self.getMachineParametersValues(startAddress: totalAddresses.start, data: data)
            
            let parameter1 = BaseParameter(name: parametersNames.0, value: parametersValues.0, units: .temperature)
            let parameter2 = BaseParameter(name: parametersNames.1, value: parametersValues.1, units: .time)
            let parameter3 = BaseParameter(name: parametersNames.2, value: parametersValues.2, units: .time)
            
            if !parameter1.name.isEmpty {
                machineRealTime.parameter1 = parameter1
            } else {
                machineRealTime.parameter1 = nil
            }
            
            if !parameter2.name.isEmpty {
                machineRealTime.parameter2 = parameter2
            } else {
                machineRealTime.parameter2 = nil
            }
            
            if !parameter3.name.isEmpty {
                machineRealTime.parameter3 = parameter3
            } else {
                machineRealTime.parameter3 = nil
            }
            
            self.delegate?.receivedMachineParametersData(with: machineRealTime)
            
        }, failure: { (error) in
            self.checkConnection(error: error)
            self.getMachineCycleParametersData()
        })
        
    }
    
    private func getMachinePrametersIDs(startAddress: Int32, data: [Int]) -> (String, String, String) {
        
        let parameter1Address = MachineConstants.CycleParameters.parameter1ID
        let parameter2Address = MachineConstants.CycleParameters.parameter2ID
        let parameter3Address = MachineConstants.CycleParameters.parameter3ID
        
        let parameter1 = data[Int(parameter1Address.start - startAddress)]
        let parameter2 = data[Int(parameter2Address.start - startAddress)]
        let parameter3 = data[Int(parameter3Address.start - startAddress)]
        
        let paramter1Name = AutoClaveEnums.MainParametersNames(rawValue: parameter1)!.getName
        let paramter2Name = AutoClaveEnums.MainParametersNames(rawValue: parameter2)!.getName
        let paramter3Name = AutoClaveEnums.MainParametersNames(rawValue: parameter3)!.getName
        
        return (paramter1Name, paramter2Name, paramter3Name)
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
