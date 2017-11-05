//
//  Connection.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 11/5/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class Connection: NSObject {
    
    var modbus: SwiftLibModbus?
    var machine: Machine?
    var isConnected: Bool = false
    
    // MARK: - Initialization
    
    init(modbus: SwiftLibModbus) {
        super.init()
        self.modbus = modbus
        self.machine = Machine()
        self.machine?.realTime = MachineRealTime()
    }
    
    // MARK: - Update Methods
    
    func updateMachine(with machine: Machine) {
        self.machine = machine
    }
    
    func updateRealTime(with realTime: MachineRealTime) {
        self.machine?.realTime = realTime
    }
    
}
