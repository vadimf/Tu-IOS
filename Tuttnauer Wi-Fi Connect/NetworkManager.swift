//
//  NetworkManager.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/30/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import CocoaAsyncSocket
import Reachability

protocol NetworkManagerDelegate {
    func didUpdateMachineList(list: [Machine])
}

class NetworkManager: NSObject {
    
    // This manager class is used to find & manage machines on the network
    
    static let shared = NetworkManager()
    
    var delegate: NetworkManagerDelegate?
    
    var reachability: Reachability?
    
    var isConnceted: Bool = false
    
    var udpListenerSocket: GCDAsyncUdpSocket?
    var udpListenerQueue: DispatchQueue?
    
    var udpBroadcasterSocket: GCDAsyncUdpSocket?
    var udpBroadcasterQueue: DispatchQueue?
    
    var udpClientListeningPort: UInt16 = 9050
    var udpPLCListeningPort: UInt16 = 9051
    var udpSocketTimeOut: TimeInterval = 5
    
    var myIPAddress: String = ""
    var netMaskAddress: String = "255.255.255.255"
    
    var foundIPAddresses = [String]()
    
    var machines = [Machine]()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        setupReachability()
        updateMyDeviceIP()
        setupSockets()
    }
    
    // MARK: - Methods
    
    fileprivate func setupSockets() {
        // Setup sockets
        udpListenerQueue = DispatchQueue.main
        udpListenerSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: udpListenerQueue)
        udpBroadcasterQueue = DispatchQueue.main
        udpBroadcasterSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: udpBroadcasterQueue)
        
        // Setup listeners
        setupListenerSocket()
        setupBroadcasterSocket()
    }
    
    fileprivate func updateMyDeviceIP() {
        guard let ipAddress = Utilities.getWiFiAddress() else { return }
        myIPAddress = ipAddress
    }
    
    func scanForMachinesOnNetwork() {
        
        // Clear previous results first
        machines.removeAll()

        // Send a broadcaster call
        if let data = myIPAddress.data(using: .utf8) {
            udpBroadcasterSocket?.send(data, toHost: netMaskAddress, port: udpClientListeningPort, withTimeout: udpSocketTimeOut, tag: 0)
        }
    }
    
    // MARK: - Setup Methods
    
    fileprivate func setupListenerSocket() {
        udpListenerSocket?.setIPv4Enabled(true)
        udpListenerSocket?.setIPv6Enabled(false)
        do {
            try udpListenerSocket?.bind(toPort: udpPLCListeningPort)
            try udpListenerSocket?.beginReceiving()
            isConnceted = true
        } catch let error {
            udpListenerSocket?.close()
            udpBroadcasterSocket?.close()
            disconnect()
            print("Cannot accept on socket:", error.localizedDescription)
        }
    }
    
    fileprivate func setupBroadcasterSocket() {
        udpBroadcasterSocket?.setIPv4Enabled(true)
        udpBroadcasterSocket?.setIPv6Enabled(false)
        do {
            try udpBroadcasterSocket?.bind(toPort: udpClientListeningPort)
            try udpBroadcasterSocket?.enableBroadcast(true)
            isConnceted = true
        } catch let error {
            udpListenerSocket?.close()
            udpBroadcasterSocket?.close()
            disconnect()
            print("Cannot setup UDP socket:", error.localizedDescription)
        }
    }
    
    // MARK: - Parse Machine Data
    
    fileprivate func parseMachineData(data: String) {
        
        let split = data.split(separator: ",").map(String.init)
        
        guard split.count == 5 else { return } // Receiving 5 comma separated elements from the machine. If not 5, don't add it
        
        let machine = Machine()
        machine.modelName = split[3]
        machine.serialNumber = split[4]
        machine.bsVersion = split[1]
        machine.ipAddress = split[0]
        
        machines.append(machine)
        
        delegate?.didUpdateMachineList(list: machines)
    }
    
}

// MARK: - Public Network Cycle Methods

extension NetworkManager {
    
    func connect() {
        setupSockets()
        isConnceted = true
    }
    
    func disconnect() {
        udpBroadcasterSocket?.close()
        udpListenerSocket?.close()
        udpBroadcasterSocket = nil
        udpListenerSocket = nil
        isConnceted = false
    }
    
}

// MARK: - GCDAsyncUdpSocketDelegate Methods

extension NetworkManager: GCDAsyncUdpSocketDelegate {
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        guard let machineData = String(data: data, encoding: .utf8) else { return }
        parseMachineData(data: machineData)
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
        print("didNotConnect")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        print("didSendDataWithTag")
    }
    
    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        print("udpSocketDidClose")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didConnectToAddress address: Data) {
        print("didConnectToAddress")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotSendDataWithTag tag: Int, dueToError error: Error?) {
        print("didNotSendDataWithTag")
    }
    
}

// MARK: - Reachablity

extension NetworkManager {
    
    fileprivate func setupReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: NotificationsIdentifiers.reachabilityChanged, object: nil)
        reachability = Reachability()
        do {
            try reachability?.startNotifier()
        } catch let error {
            reachability?.stopNotifier()
            print("Could not start reachability notifier:", error.localizedDescription)
        }
    }
    
    @objc fileprivate func reachabilityChanged(notification: Notification) {
        
        var topViewController = UIViewController()
        
        if let topVC = UIApplication.shared.delegate?.window??.rootViewController {
            topViewController = topVC
        }
        
        let reachability = notification.object as! Reachability
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                updateMyDeviceIP()
                if !isConnceted {
                    setupSockets()
                }
            } else {
                Alerts.alertMessage(for: topViewController, title: "Network Error", message: "You are not connected to a Wi-Fi network", closeHandler: nil)
            }
        } else {
            Alerts.alertMessage(for: topViewController, title: "Network Error", message: "Network not available", closeHandler: nil)
            print("Network not reachable")
        }
    }
    
}

