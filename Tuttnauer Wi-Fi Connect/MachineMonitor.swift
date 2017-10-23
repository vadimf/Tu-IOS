//
//  MachineMonitor.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/23/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

protocol MachineMonitorDelegate {
    func machineSetupDataUpdated()
    func initialMachineDataReceived()
    func machineDataUpdated(modelName: String, serialNumber: String)
    func lostConnection()
}

class MachineMonitor: NSObject {
    
    static let shared = MachineMonitor()
    
    var delegate: MachineMonitorDelegate?
    
    var machine: Machine?
    var networkManager: MachineNetworking?
    
    var isConnected: Bool = false
    
    var timer: Timer?
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        machine = Machine()
        networkManager = MachineNetworking()
        networkManager?.delegate = self
        startMonitoring()
    }
    
    // MARK: - Connect & Disconnect
    
    func connect(to ipAddress: String, completion: MachineConnectCompletionHandler?) {
        
        guard let networkManager = self.networkManager else { return }
        
        networkManager.connect(ipAddress: ipAddress) { (success, error) in
            
            guard error == nil, success else {
                completion?(false, error!)
                return
            }
            
            self.machine?.ipAddress = ipAddress
            
            completion?(success, nil)
        }
    }
    
    // MARK: - Manipulation Methods
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getMachineObservableData), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
    
    func clearData() {
        // TODO: Do we need to clear data when screen closes or in any other scenario?
    }
    
    // MARK: - Requesting Data from Machine Networking
    
    func getMachineSetupData() {
        guard let networkManager = self.networkManager else { return }
        networkManager.getMachineSetupData()
    }
    
    @objc private func getMachineObservableData() {
        // TODO: Observables
    }
    
    // TODO - Handle lost connections / errors
    
}

// MARK: - Machine Networking Delegate

extension MachineMonitor: MachineNetworkingDelegate {
    
    func receivedMachineSetupData(with machine: Machine) {
       self.machine = machine
       delegate?.machineSetupDataUpdated()
    }
    
    func machineNewData(modelName: String, serialNumber: String) {
        delegate?.machineDataUpdated(modelName: modelName, serialNumber: serialNumber)
    }
    
    func disconnect() {
        
    }
    
    func connectionLost() {
        
    }
    
}
