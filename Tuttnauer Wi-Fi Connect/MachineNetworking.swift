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
    
    func machineNewData(modelName: String, serialNumber: String)
    func disconnect()
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
    
    func disconnect() {
        modbus?.disconnect()
        modbus = nil
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
            self.getMachineSetupData()
            print(error.localizedDescription)
        })
        
    }
    
    // MARK: - Machine Real Time Observer Methods
    
    func getMachineRealTimeStateData() {
        
        let totalAddresses = MachineConstants.RealTime.total
        
        modbus?.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            print("Received Real Time Data")
            
            guard let data = data as? [Int],
                let machineRealTime = self.machineRealTime else { return }
            
            //machineRealTime.systemStatus = self.getMachineRealTimeCurrentStatus(startAddress: totalAddresses.start, data: data)
            machineRealTime.doorState = AutoClaveEnums.DoorState(rawValue: self.getMachineRealTimeDoorState(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.DoorState(rawValue: 0)
            machineRealTime.cycleName = AutoClaveEnums.CycleID(rawValue: self.getMachineRealTimeCurrentCycleID(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleID(rawValue: 0)
            machineRealTime.cycleStage = AutoClaveEnums.CycleStage(rawValue: self.getMachineRealTimeCycleStage(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleStage(rawValue: 0)
            machineRealTime.cycleSubStage = AutoClaveEnums.CycleSubStage(rawValue: self.getMachineRealTimeCycleSubStage(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleSubStage(rawValue: 0)
            machineRealTime.cycleError = AutoClaveEnums.CycleError(rawValue: self.getMachineRealTimeCycleError(startAddress: totalAddresses.start, data: data)) ?? AutoClaveEnums.CycleError(rawValue: 0)
            
            self.delegate?.receivedMachineRealTimeStateData(with: machineRealTime)
            
        }, failure: { (error) in
            self.getMachineRealTimeStateData()
            print(error.localizedDescription)
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
    
    // MARK: - Current Cycle Observer Methods
    
    func getMachineCurrentCycleProperties() {
        
        let totalAddresses = MachineConstants.CurrentCycleProperties.total
        
        modbus?.readRegistersFrom(startAddress: (totalAddresses.start - 1), count: totalAddresses.count, success: { (data) in
            
            print("Received Current Cycle Data")
            
            guard let data = data as? [Int],
                let machineRealTime = self.machineRealTime else { return }
            
            let analogIOs = self.getMachineCurrentCyclePropertiesAnalogIO(startAddress: totalAddresses.start, data: data)
            machineRealTime.analogInput1IOMapping = analogIOs.0
            machineRealTime.analogInput2IOMapping = analogIOs.1
            machineRealTime.analogInput3IOMapping = analogIOs.2
            
            self.delegate?.receivedMachineRealTimeStateData(with: machineRealTime)
            
        }, failure: { (error) in
            self.getMachineCurrentCycleProperties()
            print(error.localizedDescription)
        })
        
    }
    
    private func getMachineCurrentCyclePropertiesAnalogIO(startAddress: Int32, data: [Int]) -> (Int, Int, Int) {
        
        let analog1 = MachineConstants.CurrentCycleProperties.analogInput1IOMapping
        let analog2 = MachineConstants.CurrentCycleProperties.analogInput2IOMapping
        let analog3 = MachineConstants.CurrentCycleProperties.analogInput3IOMapping
        
        let analog1Data = data[Int(analog1.start - startAddress)]
        let analog2Data = data[Int(analog2.start - startAddress)]
        let analog3Data = data[Int(analog3.start - startAddress)]
        
        return (analog1Data, analog2Data, analog3Data)
    }

}
