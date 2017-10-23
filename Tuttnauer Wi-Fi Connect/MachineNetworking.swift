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
    func machineNewData(modelName: String, serialNumber: String)
    func disconnect()
    func connectionLost()
}

class MachineNetworking: NSObject {
    
    var delegate: MachineNetworkingDelegate?
    
    private var modbus: SwiftLibModbus?
    
    
    // MARK: - Connecting & Disconnecting
    
    func connect(ipAddress: String, completion: MachineConnectCompletionHandler?) {
        
        // Create a new Modbus instance
        modbus = SwiftLibModbus(ipAddress: ipAddress as NSString, port: 502, device: 1)
        
        // Connect
        modbus?.connect(success: {
            completion?(true, nil)
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
        
        let machine = Machine()
        
        let versionMajorAddress = MachineConstants.versions.versionMajor
        let versionMinorAddress = MachineConstants.versions.versionMinor
        let versionRevisionAddress = MachineConstants.versions.versionRevision
        let versionBuildAddress = MachineConstants.versions.versionBuild
        
        let modelNameAddress = MachineConstants.setup.modelName
        let serialNumberAddress = MachineConstants.setup.serialNumber
        
        let versionTotalAddresses = (versionMajorAddress.count + versionMinorAddress.count + versionRevisionAddress.count + versionBuildAddress.count)
        let modelTotalAddresses = (modelNameAddress.count + serialNumberAddress.count)
        
        // Get Version Number
        modbus?.readRegistersFrom(startAddress: (versionMajorAddress.start - 1), count: versionTotalAddresses, success: { (data) in
            
            guard let data = data as? [Int] else { return }
            
            let version: String = "\(data[0]).\(data[1]).\(data[3]).\(data[2])"
            machine.bsVersion = version
            
            self.delegate?.receivedMachineSetupData(with: machine)
            
        }, failure: { (error) in
            self.getMachineSetupData()
            print(error.localizedDescription)
        })
        
        // Get Model Name & Serial Number
        modbus?.readRegistersFrom(startAddress: (modelNameAddress.start - 1), count: modelTotalAddresses, success: { (data) in
            
            guard let data = data as? [Int] else { return }
            
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
            // TODO: Retry after X seconds instead of forcing immediately
            self.getMachineSetupData()
            print(error.localizedDescription)
        })
        
    }
    
}
