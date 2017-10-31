//
//  NetworkManager.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/30/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

protocol NetworkManagerDelegate {
    func didUpdateMachineList(list: [Machine])
}

class NetworkManager: NSObject, GCDAsyncUdpSocketDelegate {
    
    // This manager class is used to find & manage machines on the network
    
    static let shared = NetworkManager()
    
    var delegate: NetworkManagerDelegate?
    
    var udpListenerSocket: GCDAsyncUdpSocket?
    var udpListenerQueue: DispatchQueue?
    
    var udpBroadcasterSocket: GCDAsyncUdpSocket?
    var udpBroadcasterQueue: DispatchQueue?
    
    var udpClientListeningPort: UInt16 = 9050
    var udpPLCListeningPort: UInt16 = 9051
    var udpSocketTimeOut: TimeInterval = 5
    
    var myIPAddress: String = "10.0.0.36"
    var netMaskAddress: String = "255.255.255.255"
    
    var foundIPAddresses = [String]()
    
    var machines = [Machine]()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
//        DispatchQueue(label: "com.cocoaAsyncSocket.listener", qos: .utility)
//        DispatchQueue(label: "com.cocoaAsyncSocket.broadcaster", qos: .utility)
        udpListenerQueue = DispatchQueue.main
        udpListenerSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: udpListenerQueue)
        udpBroadcasterQueue = DispatchQueue.main
        udpBroadcasterSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: udpBroadcasterQueue)
        
        // Setup Listeners
        setupListenerSocket()
        setupBroadcasterSocket()
    }
    
    // MARK: - Methods
    
    func scanForMachinesOnNetwork() {
        
        // Clear previous results first
        machines = [Machine]()

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
        } catch let error {
            print("Cannot accept on socket:", error.localizedDescription)
        }
    }
    
    fileprivate func setupBroadcasterSocket() {
        udpBroadcasterSocket?.setIPv4Enabled(true)
        udpBroadcasterSocket?.setIPv6Enabled(false)
        do {
            try udpBroadcasterSocket?.bind(toPort: udpClientListeningPort)
            try udpBroadcasterSocket?.enableBroadcast(true)
            try udpBroadcasterSocket?.beginReceiving()
        } catch let error {
            print("Cannot setup UDP socket:", error.localizedDescription)
        }
    }
    
    // MARK: - Parse Machine Data
    
    fileprivate func parseMachineData(data: String) {
        
        let split = data.characters.split{$0 == ","}.map(String.init)
        
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

// MARK: - GCDAsyncUdpSocketDelegate Methods

extension NetworkManager {
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        guard let machineData = String(data: data, encoding: .utf8) else { return }
        parseMachineData(data: machineData)
    }
    
}
