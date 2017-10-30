//
//  MachineMonitor.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/23/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

protocol MachineMonitorDelegate {
    func machineSetupDataUpdated()
    func machineRealTimeDataUpdated()
    func machineSensorsDataUpdated()
    func machineParametersDataUpdated()
    func didDisconnectFromMachine()
    func connectionLost()
}

class MachineMonitor: NSObject {
    
    static let shared = MachineMonitor()
    
    var delegate: MachineMonitorDelegate?
    
    var machine: Machine?
    var machineRealTime: MachineRealTime?
    var networkManager: MachineNetworking?
    
    var isConnected: Bool = false
    
    var timer: Timer?
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        machine = Machine()
        machineRealTime = MachineRealTime()
        networkManager = MachineNetworking.shared
        networkManager?.delegate = self
    }
    
    // MARK: - Connect & Disconnect
    
    func connect(to ipAddress: String, completion: MachineConnectCompletionHandler?) {
        
        guard let networkManager = self.networkManager else { return }
        
        networkManager.connect(ipAddress: ipAddress) { (success, error) in
            
            guard error == nil, success else {
                self.isConnected = false
                completion?(false, error!)
                return
            }
            
            self.isConnected = true
            self.machine?.ipAddress = ipAddress
            
            self.startMonitoring()
            
            completion?(success, nil)
            
            NotificationsManager.shared.scheduleLocalNotification(in: 1, title: "Tuttnauer", body: "Connected to: \(ipAddress)")
        }
    }
    
    func reconnect(completion: MachineConnectCompletionHandler?) {
        
        guard let networkManager = self.networkManager else { return }
        
        networkManager.reconnect { (success, error) in
            
            guard error == nil, success else {
                self.isConnected = false
                completion?(false, error!)
                return
            }
            
            self.isConnected = true
            completion?(success, nil)
        }
        
    }
    
    func disconnect() {
        guard let networkManager = self.networkManager else { return }
        stopMonitoring()
        networkManager.disconnect()
    }
    
    // MARK: - Manipulation Methods
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getMachineRealTimeData), userInfo: nil, repeats: true)
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
    
    @objc private func getMachineRealTimeData() {
        guard let networkManager = self.networkManager else { return }
        networkManager.getMachineRealTimeStateData()
        networkManager.getMachineSensorsData()
        networkManager.getMachineCycleParametersData()
    }
    
    // TODO - Handle lost connections / errors
    
}

// MARK: - Machine Networking Delegate

extension MachineMonitor: MachineNetworkingDelegate {

    func receivedMachineSetupData(with machine: Machine) {
       self.machine = machine
       delegate?.machineSetupDataUpdated()
    }
    
    func receivedMachineRealTimeStateData(with machineRealTimeState: MachineRealTime) {
        self.machineRealTime = machineRealTimeState
        delegate?.machineRealTimeDataUpdated()
    }
    
    func receivedMachineSensorsData(with machineRealTimeState: MachineRealTime) {
        self.machineRealTime = machineRealTimeState
        delegate?.machineSensorsDataUpdated()
    }
    
    func receivedMachineParametersData(with machineRealTimeState: MachineRealTime) {
        self.machineRealTime = machineRealTimeState
        delegate?.machineParametersDataUpdated()
    }
    
    func didDisconnectFromMachine() {
        isConnected = false
        delegate?.didDisconnectFromMachine()
    }
    
    func connectionLost() {
        isConnected = false
        stopMonitoring()
        delegate?.connectionLost()
    }
    
}
