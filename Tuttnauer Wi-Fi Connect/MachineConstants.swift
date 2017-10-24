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
    
    struct Size {
        
        static let int16Size: Int32 = 1;
        static let int32Size: Int32 = 2;
        static let int64Size: Int32 = 4;
        
        static let doubleValueSize: Int32 = 4;
        static let smallEnumSize: Int32 = 1;
        static let bigEnumSize: Int32 = 2;
        
        static let timeStampSize: Int32 = 4;
        
    }
    
    // MARK: - Version Constants
    
    struct Versions {
        static let startAddress: Int32 = 0
        static let magicNumber = ModbusAddress(start: 1, end: 1, count: Size.int16Size)
        static let versionMajor = ModbusAddress(start: 2, end: 2, count: Size.int16Size)
        static let versionMinor = ModbusAddress(start: 3, end: 3, count: Size.int16Size)
        static let versionRevision = ModbusAddress(start: 4, end: 4, count: Size.int16Size)
        static let versionBuild =  ModbusAddress(start: 5, end: 5, count: Size.int16Size)
    }
    
    // MARK: - Machine Setup Definitions
    
    struct Setup {
        static let startAddress: Int32 = 120
        static let modelName = ModbusAddress(start: 120, end: 134, count: 15)
        static let serialNumber = ModbusAddress(start: 135, end: 138, count: Size.int64Size)
        static let currentLanguage = ModbusAddress(start: 139, end: 139, count: Size.int16Size)
        static let currentPressureUnits = ModbusAddress(start: 140, end: 140, count: Size.int16Size)
        static let currentTemperatureUnits = ModbusAddress(start: 141, end: 141, count: Size.int16Size)
        static let useDHCP = ModbusAddress(start: 142, end: 142, count: Size.int16Size)
        static let doorType = ModbusAddress(start: 143, end: 143, count: Size.int16Size)
        static let bioHazardType = ModbusAddress(start: 144, end: 144, count: Size.int16Size)
        static let machineTraceLevel = ModbusAddress(start: 145, end: 145, count: Size.int16Size)
        static let externalIPAddress = ModbusAddress(start: 146, end: 149, count: Size.int64Size)
        static let supportInternalIP = ModbusAddress(start: 150, end: 150, count: Size.int16Size)
        static let internalIPAddress = ModbusAddress(start: 151, end: 154, count: Size.int64Size)
        static let supportScreen1IP = ModbusAddress(start: 155, end: 155, count: Size.int16Size)
        static let screen1IPAddress = ModbusAddress(start: 156, end: 159, count: Size.int64Size)
        static let supportScreen2IP = ModbusAddress(start: 160, end: 160, count: Size.int16Size)
        static let screen2IPAddress = ModbusAddress(start: 161, end: 164, count: Size.int64Size)
        static let supportAdam6017IP = ModbusAddress(start: 165, end: 165, count: Size.int16Size)
        static let adam6017IPAdderss = ModbusAddress(start: 166, end: 169, count: Size.int64Size)
        static let supportAdam6060IP = ModbusAddress(start: 170, end: 170, count: Size.int16Size)
        static let adam6060IPAddress = ModbusAddress(start: 171, end: 174, count: Size.int64Size)
    }
    
    // MARK: - Machine Real Time State
    
    struct RealTime {
        static let total = ModbusAddress(start: 30, end: 109, count: 79)
        static let systemStatus = ModbusAddress(start: 30, end: 33, count: Size.int64Size)
        static let screenSaverOn = ModbusAddress(start: 34, end: 34, count: Size.int16Size)
        static let doorState = ModbusAddress(start: 35, end: 35, count: Size.int16Size)
        static let canOpenDoor1 = ModbusAddress(start: 36, end: 36, count: Size.int16Size)
        static let canOpenDoor2 = ModbusAddress(start: 37, end: 37, count: Size.int16Size)
        static let canCloseDoor1 = ModbusAddress(start: 38, end: 38, count: Size.int16Size)
        static let canCloseDoor2 = ModbusAddress(start: 39, end: 39, count: Size.int16Size)
        static let exportingImportingError = ModbusAddress(start: 40, end: 40, count: Size.int16Size)
        static let exportImportCurrentStep = ModbusAddress(start: 41, end: 41, count: Size.int16Size)
        static let exportImportStatus = ModbusAddress(start: 42, end: 42, count: Size.int16Size)
        static let door1Error = ModbusAddress(start: 43, end: 43, count: Size.int16Size)
        static let door2Error = ModbusAddress(start: 44, end: 44, count: Size.int16Size)
        static let cycleStartTime = ModbusAddress(start: 45, end: 48, count: Size.int64Size)
        static let cycleError = ModbusAddress(start: 49, end: 49, count: Size.int16Size)
        static let cycleStage = ModbusAddress(start: 50, end: 50, count: Size.int16Size)
        static let cycleSterilizationStatus = ModbusAddress(start: 51, end: 51, count: Size.int16Size)
        static let cycleThreadState = ModbusAddress(start: 52, end: 52, count: Size.int16Size)
        static let cycleID = ModbusAddress(start: 53, end: 53, count: Size.int16Size)
        static let atmospherePressure = ModbusAddress(start: 54, end: 57, count: Size.int64Size)
        static let cycleNumber = ModbusAddress(start: 58, end: 59, count: Size.int32Size)
        static let cycleCounter = ModbusAddress(start: 60, end: 60, count: Size.int16Size)
        static let lastServiceTime = ModbusAddress(start: 61, end: 64, count: Size.int64Size)
        static let isStageTimerOn = ModbusAddress(start: 65, end: 65, count: Size.int16Size)
        static let systemParametersTimeStamp = ModbusAddress(start: 66, end: 69, count: Size.int64Size)
        static let inputsOutputsTimeStamp = ModbusAddress(start: 70, end: 73, count: Size.int64Size)
        static let cycleParametersTimeStamp = ModbusAddress(start: 74, end: 77, count: Size.int64Size)
        static let usersTimeStamp = ModbusAddress(start: 78, end: 81, count: Size.int64Size)
        static let systemTime = ModbusAddress(start: 82, end: 85, count: Size.int64Size)
        static let cyclePropsCheckSum = ModbusAddress(start: 86, end: 87, count: Size.int32Size)
        static let cycleSubStage = ModbusAddress(start: 88, end: 88, count: Size.int16Size)
        static let stageStartTime = ModbusAddress(start: 89, end: 92, count: Size.int64Size)
        static let stageEndTime = ModbusAddress(start: 93, end: 96, count: Size.int64Size)
        static let totalIteration = ModbusAddress(start: 97, end: 97, count: Size.int16Size)
        static let currentIteration = ModbusAddress(start: 98, end: 98, count: Size.int16Size)
        static let totalBioHazardCycleCounter = ModbusAddress(start: 99, end: 99, count: Size.int16Size)
        static let standByCycleTime = ModbusAddress(start: 100, end: 103, count: Size.int64Size)
        static let connectedToRooster = ModbusAddress(start: 104, end: 104, count: Size.int16Size)
        static let currentCycleEndTime = ModbusAddress(start: 105, end: 108, count: Size.int64Size)
        static let currentCyclePercents = ModbusAddress(start: 109, end: 109, count: Size.int16Size)
    }
    
    // MARK: - Machine Current Cycle Properties
    
    struct CurrentCycleProperties {
        static let total = ModbusAddress(start: 110, end: 117, count: 7)
        static let analogInput1IOMapping = ModbusAddress(start: 110, end: 110, count: Size.int16Size)
        static let analogInput2IOMapping = ModbusAddress(start: 111, end: 111, count: Size.int16Size)
        static let analogInput3IOMapping = ModbusAddress(start: 112, end: 112, count: Size.int16Size)
        static let cycleTemperatureSensor1 = ModbusAddress(start: 113, end: 113, count: Size.int16Size)
        static let cycleTemperatureSensor2 = ModbusAddress(start: 114, end: 114, count: Size.int16Size)
        static let cycleTemperatureSensor3 = ModbusAddress(start: 115, end: 115, count: Size.int16Size)
        static let cycleTemperatureSensor4 = ModbusAddress(start: 116, end: 116, count: Size.int16Size)
        static let cycleIcon = ModbusAddress(start: 117, end: 117, count: Size.int16Size)
    }
    
}


