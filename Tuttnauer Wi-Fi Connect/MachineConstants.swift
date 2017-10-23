//
//  MachineConstants.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/23/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

struct ModbusAddress {
    let start: Int32
    let end: Int32
    let count: Int32
}

class MachineConstants: NSObject {

    /*
     * Modbus addresses constants
     * Imported from the Excel table
     */
    
    // MARK: - Size Definitions
    
    struct size {
        
        static let int16Size: Int32 = 1;
        static let int32Size: Int32 = 2;
        static let int64Size: Int32 = 4;
        
        static let doubleValueSize: Int32 = 4;
        static let smallEnumSize: Int32 = 1;
        static let bigEnumSize: Int32 = 2;
        
        static let timeStampSize: Int32 = 4;
        
    }
    
    // MARK: - Version Constants
    
    struct versions {
        static let startAddress = 0
        static let magicNumber = ModbusAddress(start: 1, end: 1, count: size.int16Size)
        static let versionMajor = ModbusAddress(start: 2, end: 2, count: size.int16Size)
        static let versionMinor = ModbusAddress(start: 3, end: 3, count: size.int16Size)
        static let versionRevision = ModbusAddress(start: 4, end: 4, count: size.int16Size)
        static let versionBuild =  ModbusAddress(start: 5, end: 5, count: size.int16Size)
    }
    
    // MARK: - Machine Setup Definitions
    
    struct setup {
        static let startAddress = 120
        static let modelName = ModbusAddress(start: 120, end: 134, count: 15)
        static let serialNumber = ModbusAddress(start: 135, end: 138, count: size.int64Size)
        static let currentLanguage = ModbusAddress(start: 139, end: 139, count: size.int16Size)
        static let currentPressureUnits = ModbusAddress(start: 140, end: 140, count: size.int16Size)
        static let currentTemperatureUnits = ModbusAddress(start: 141, end: 141, count: size.int16Size)
        static let useDHCP = ModbusAddress(start: 142, end: 142, count: size.int16Size)
        static let doorType = ModbusAddress(start: 143, end: 143, count: size.int16Size)
        static let bioHazardType = ModbusAddress(start: 144, end: 144, count: size.int16Size)
        static let machineTraceLevel = ModbusAddress(start: 145, end: 145, count: size.int16Size)
        static let externalIPAddress = ModbusAddress(start: 146, end: 149, count: size.int64Size)
        static let supportInternalIP = ModbusAddress(start: 150, end: 150, count: size.int16Size)
        static let internalIPAddress = ModbusAddress(start: 151, end: 154, count: size.int64Size)
        static let supportScreen1IP = ModbusAddress(start: 155, end: 155, count: size.int16Size)
        static let screen1IPAddress = ModbusAddress(start: 156, end: 159, count: size.int64Size)
        static let supportScreen2IP = ModbusAddress(start: 160, end: 160, count: size.int16Size)
        static let screen2IPAddress = ModbusAddress(start: 161, end: 164, count: size.int64Size)
        static let supportAdam6017IP = ModbusAddress(start: 165, end: 165, count: size.int16Size)
        static let adam6017IPAdderss = ModbusAddress(start: 166, end: 169, count: size.int64Size)
        static let supportAdam6060IP = ModbusAddress(start: 170, end: 170, count: size.int16Size)
        static let adam6060IPAddress = ModbusAddress(start: 171, end: 174, count: size.int64Size)
    }
    
}


