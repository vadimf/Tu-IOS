//
//  MainViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 9/4/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import SwiftSocket
import CocoaAsyncSocket
import NetUtils

class MainViewController: UIViewController {

    var modbus: SwiftLibModbus?
    var client: GCDAsyncUdpSocket?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func discoverButtonTapped(_ sender: Any) {
        guard modbus == nil else { return }
        modbus = SwiftLibModbus(ipAddress: "192.168.1.147", port: 502, device: 1)
        modbus?.connect(
            success: { () -> Void in
                //connected and ready to do modbus calls
                print("Connected to: 192.168.1.147")
        },
            failure: { (error: NSError) -> Void in
                //Handle error
                print("\(error.localizedDescription)")
        })
    }
    
    @IBAction func makeModbusCallTapped(_ sender: Any) {
        modbusCall()
    }
    
    @IBAction func closeModbusConnectionTapped(_ sender: Any) {
        guard modbus != nil else { return }
        modbus?.disconnect()
        modbus = nil
    }
    
    @IBAction func discoverNetworkDevicesTapped(_ sender: Any) {
        discoverNetworkDevices()
    }
    
    func modbusCall() {
        guard modbus != nil else { return }
        modbus?.readRegistersFrom(startAddress: 0, count: 100,
            success: { (array: [AnyObject]) -> Void in
                /*if let array = array as? [Int] {
                    let modelName = ModbusUtilities.getStringFromIntArray(array: array)
                    print("Model Name:", modelName)
                }*/
                print(array)
        },
            failure:  { (error: NSError) -> Void in
                //Handle error
                print("\(error.localizedDescription)")
        })
    }

}

extension MainViewController: GCDAsyncUdpSocketDelegate {
    
    func discoverNetworkDevices() {
        
        let message = "".data(using: .utf8)!
        let address = "192.168.1.147".data(using: .utf8)!
        
        client = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        do {
            try client?.bind(toPort: 80)
            try client?.enableBroadcast(true)
            client?.send(message, toAddress: address, withTimeout: 1000, tag: 0)
        } catch let error {
            print("Error:", error)
        }
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didConnectToAddress address: Data) {
        print("didConnectToAddress")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        print("didSendDataWithTag")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
        print("didNotConnect")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotSendDataWithTag tag: Int, dueToError error: Error?) {
        print("didNotSendDataWithTag")
    }
    
    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        print(error!)
    }
    
}
