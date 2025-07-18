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
    func didChangeConnection(to connection: MachineConnection)
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
    
    // MARK: Create, Remove & Verify Connections
    
    func createConnection(to ipAddress: String, completion: MachineConnectCompletionHandler?) {
        let checkConnection = isConnected(to: ipAddress)
        if checkConnection.connected {
            currentConnection = checkConnection.connection
            completion?(true, nil)
        } else if !checkConnection.connected, let connection = checkConnection.connection {
            connection.connect(completion: { (success, error) in
                completion?(success, error)
            })
        } else {
            let connection = MachineConnection(ipAddress: ipAddress, delegate: self) // Auto-connects on init
            currentConnection = connection
            completion?(true, nil)
        }
    }
    
    func switchCurrentConnection(to connection: MachineConnection) {
        currentConnection = connection
        currentConnection?.fetchMachineSetupData()
    }
    
    func reconnect(to connection: MachineConnection) {
        
        // Check if WiFi is available first
        guard NetworkManager.shared.reachability!.isReachableViaWiFi else {
            delegate?.didLoseConnection(to: connection)
            currentConnection?.isConnected = false
            return
        }
        
        // Check if this machine is even connected to the network anymore
        NetworkManager.shared.scanForMachinesOnNetwork()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: { // Delayed so scanForMachinesOnNetwork() can finish its work
            let machines = NetworkManager.shared.machines
            guard machines.count > 0 else {
                self.delegate?.didLoseConnection(to: connection)
                return
            }
            for machine in machines {
                if machine.ipAddress == connection.ipAddress {
                    // Try to connect again
                    connection.connect { (success, error) in
                        if success {
                            self.delegate?.didConnect(to: connection, success: true)
                        } else {
                            self.delegate?.didLoseConnection(to: connection)
                        }
                        self.currentConnection?.isConnected = success
                    }
                } else {
                    self.delegate?.didLoseConnection(to: connection)
                }
            }
        })
    }
    
    func disconnect(from connection: MachineConnection) {
        connection.disconnect()
        removeConnection(to: connection)
        print("* Connections in stack:", self.connections)
    }
    
    func removeConnection(to connection: MachineConnection) {
        guard let index = connections.index(of: connection) else { return }
        connections.remove(at: index)
    }
    
    // Returns if a machine with an ip address is already connected + already exists in our connections array
    func isConnected(to ipAddress: String) -> (connected: Bool, connection: MachineConnection?) {
        for connection in connections {
            if connection.ipAddress == ipAddress {
                return (connection.isConnected, connection)
            }
        }
        return (false, nil)
    }
    
    // MARK: Start, Stop & Resume Monitoring
    
    func startMonitoring(connection: MachineConnection) {
        guard connection.isConnected else { return }
        connection.startFetching()
    }
    
    func stopMonitoring(connection: MachineConnection) {
        connection.stopFetching()
    }
    
    func startMonitoringAll() {
        guard !connections.isEmpty else { return }
        for connection in connections {
            connection.startFetching()
        }
    }
    
    func stopMonitoringAll(shouldDisconnect: Bool = false) {
        guard !connections.isEmpty else { return }
        for connection in connections {
            connection.stopFetching(shouldDisconnect: shouldDisconnect)
        }
    }
    
}

// MARK: - Machine Connection Delegate

extension MachineMonitoring: MachineConnectionDelegate {    
    
    func didConnect(to connection: MachineConnection, success: Bool) {
        if success {
            if !self.connections.contains(connection) {
                self.connections.append(connection)
            }
            connection.startFetching()
            print("Connected to:", connection.ipAddress)
            NotificationsManager.shared.scheduleLocalNotification(in: 1, title: "Tuttnauer", body: "Connected to: \(connection.machine!.ipAddress)")
        } else {
            print("Could not connect to:", connection.ipAddress)
            NotificationsManager.shared.scheduleLocalNotification(in: 1, title: "Tuttnauer", body: "Connection failed: \(connection.machine!.ipAddress)")
        }
        print("* Connections in stack:", self.connections)
    }
    
    func didDisconnect(from connection: MachineConnection) {
        print("Disconnected from:", connection.ipAddress)
        NotificationsManager.shared.scheduleLocalNotification(in: 1, title: "Tuttnauer", body: "Disconnected from: \(connection.machine!.ipAddress)")
        print("* Connections in stack:", self.connections)
    }
    
    func didLoseConnection(to connection: MachineConnection) {
        print("Lost connection to:", connection.ipAddress)
        if connection == currentConnection {
            delegate?.didLoseConnection(to: connection)
        } else {
            NotificationsManager.shared.scheduleLocalNotification(in: 1, title: "Tuttnauer", body: "Lost connection to: \(connection.machine!.ipAddress)")
            disconnect(from: connection)
        }
        print("* Connections in stack:", self.connections)
    }
    
    func didUpdateSetupData(for connection: MachineConnection, machine: Machine) {
        guard connection == currentConnection else { return }
        delegate?.didUpdateSetupData(for: machine)
    }
    
    func didUpdateRealTimeData(for connection: MachineConnection, machine: Machine) {
        guard connection == currentConnection else { return }
        
        if let cycleError = machine.realTime.cycleError, cycleError != .none {
            if !cycleErrorNotified {
                cycleErrorNotified = true
                NotificationsManager.shared.scheduleLocalNotification(in: 1, title: "Tuttnauer", body: "\(machine.modelName) cycle error: \(cycleError.getName)")
            }
        } else {
            cycleErrorNotified = false
        }
        
        delegate?.didUpdateRealTimeData(for: machine)
    }
    
}
