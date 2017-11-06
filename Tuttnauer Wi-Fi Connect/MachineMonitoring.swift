//
//  MachineMonitoring.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 11/6/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

protocol MachineMonitoringDelegate {
    func didConnect(to connection: MachineConnection, success: Bool)
    func didDisconnect(from connection: MachineConnection)
    func didLoseConnection(to connection: MachineConnection)
    func didUpdateSetupData(for machine: Machine)
    func didUpdateRealTimeData(for machine: Machine)
}

class MachineMonitoring: NSObject {

    static let shared = MachineMonitoring()
    
    var delegate: MachineMonitoringDelegate?
    
    var connections = [MachineConnection]() // Machine connections
    var currentConnection: MachineConnection? // The current connection in session
    var cycleErrorNotified: Bool = false
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
    }
    
    // MARK: Connecting
    
    func createConnection(to ipAddress: String) {
        let _ = MachineConnection(ipAddress: ipAddress, delegate: self) // Auto-connects on init
    }
    
    func removeConnection(to connection: MachineConnection) {
        guard let index = connections.index(of: connection) else { return }
        connections.remove(at: index)
    }
    
    // MARK: Start, Stop & Resume Monitoring
    
    func startMonitoringAll() {
        for connection in connections {
            connection.startFetching()
        }
    }
    
    func stopMonitoringAll() {
        for connection in connections {
            connection.stopFetching()
        }
    }
    
}

// MARK: - Machine Connection Delegate

extension MachineMonitoring: MachineConnectionDelegate {
    
    func didConnect(to connection: MachineConnection, success: Bool) {
        if success {
            self.connections.append(connection)
            connection.startFetching()
            print("Connected to:", connection.ipAddress)
        } else {
            print("Could not connect to:", connection.ipAddress)
        }
    }
    
    func didDisconnect(from connection: MachineConnection) {
        print("Disconnected from:", connection.ipAddress)
    }
    
    func didLoseConnection(to connection: MachineConnection) {
        print("Lost connection to:", connection.ipAddress)
    }
    
    func didUpdateSetupData(for connection: MachineConnection, machine: Machine) {
        guard connection == currentConnection else { return }
        delegate?.didUpdateSetupData(for: machine)
    }
    
    func didUpdateRealTimeData(for connection: MachineConnection, machine: Machine) {
        guard connection == currentConnection else { return }
        delegate?.didUpdateRealTimeData(for: machine)
    }
    
}
