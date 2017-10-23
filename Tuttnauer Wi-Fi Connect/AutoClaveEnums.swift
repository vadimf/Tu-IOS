//
//  AutoClaveEnums.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/21/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class AutoClaveEnums {
 
    enum SystemCurrentStatus: Int {
        case none = 0
        case noError = 1
        case standByError
        case cycleRunning
        case cycleDone
        case cycleFail
    }
    
    enum CurrentWaitingCondition {
        case none
        case waitingForNormalTemperature
        case waitingForCoolingPressure
        case cleaningJacketWater
        case waitingForFaultDry
        case waitingForNormalPressure
        case waitingForCleaningFilter
    }
    
    enum CoolingFanMode: Int {
        case none = 0
        case removeAir = 1
        case stabilize = 2
        case heat = 4
        case sterilization = 8
        case cool = 16
        case exhaust = 32
        case dry = 64
        case ending = 128
    }
    
    enum IOExtensionType: Int {
        case none = 0
        case adam6060 = 1
        case adam6017AirDetector = 2
        case adam6017ExtermnalReference = 4
        case adam6017FilterTestCycle = 8
    }
    
    enum CoolingType {
        case none
        case waterCooling
        case airCooling
        case jetSpray
    }
    
    struct BackgroundStatus {
        // Statuses that are displayed by icons
        static let none = 0 // No error is detected
        static let preHeating = 1
        static let hotWater = BackgroundStatus.preHeating * 2
        static let waterInChamber = BackgroundStatus.hotWater * 2 // Water are detected in the chamber
        static let doorOpen = BackgroundStatus.waterInChamber * 2 // Door is open
        static let wasteWaterReservoirFull = BackgroundStatus.doorOpen * 2 // Waste water Reservoir full
        static let mineralFreeWaterReservoirEmpty = BackgroundStatus.wasteWaterReservoirFull * 2 // mineral free water Reservoir empty
        static let standByCycle = BackgroundStatus.mineralFreeWaterReservoirEmpty * 2 // Stand by cycle is schedualed  to be run
        static let jacketIsCool = BackgroundStatus.standByCycle * 2 // Jacket is cool
        static let emptyReservoirVacuumPump = BackgroundStatus.jacketIsCool * 2 // Clean water tank
        static let steamGeneratorLowPressure = BackgroundStatus.emptyReservoirVacuumPump * 2 // Steam generatore pressure is too low
        static let drainHot = BackgroundStatus.steamGeneratorLowPressure * 2 // Drain is too hot
        static let adam6060NotConnected = BackgroundStatus.drainHot * 2 // Io Extension Not Connected (in static let IoExtension defined)
        static let vhpCycleHighStartTemperature = BackgroundStatus.adam6060NotConnected * 2 // VHP Cycle High Start Temperature
        static let vhpInNotReady = BackgroundStatus.vhpCycleHighStartTemperature * 2 // VHP Cycle VhpIn Not Read (value = 1)
        static let bioFilterTimeOut = BackgroundStatus.vhpInNotReady * 2 // Unable to heta bio filter
        static let bioFilterIsCool = BackgroundStatus.bioFilterTimeOut * 2 // Thermo bio filter is too cold
        static let printerPortInvalid = BackgroundStatus.bioFilterIsCool * 2 // Printer port is not valid
        static let doorOpening = BackgroundStatus.printerPortInvalid * 2 // Door is in opening progress
        static let doorClosing = BackgroundStatus.doorOpening * 2 // Door is in closing progress
        static let coolDrainTimeOut = BackgroundStatus.doorClosing * 2 // Time out while trying to cool darin
        static let jacketTimeOut = BackgroundStatus.coolDrainTimeOut * 2 // time out while trying to heat jacket
        static let supplyError = BackgroundStatus.jacketTimeOut * 2 // No supply is detected
        static let supplyWaterError = BackgroundStatus.supplyError * 2 // No water supply is detected
        static let waterToVacuumPumpError = BackgroundStatus.supplyWaterError * 2 // no water to vacuum pump
        static let waterToGeneratorError = BackgroundStatus.waterToVacuumPumpError * 2 // no water to generator
        static let supplyDistilledWaterError = BackgroundStatus.waterToGeneratorError * 2 // No supply distilled water is detected
        static let compressedAirSupplyError = BackgroundStatus.supplyDistilledWaterError * 2 // No compressed air supply is detected
        static let steamGeneratorNoWaterError = BackgroundStatus.compressedAirSupplyError * 2 // mo water detected in steam generator
        static let chamberPressureNotInRange = BackgroundStatus.steamGeneratorNoWaterError * 2 // Chamber pressure is out of range
        static let chamberTemperatureNotInRange = BackgroundStatus.chamberPressureNotInRange * 2 // Chamber temperature is out of range
        static let atmospherePressureNotSet = BackgroundStatus.chamberTemperatureNotInRange * 2 // Atmosphereic pressure is not set
        static let doorError = BackgroundStatus.atmospherePressureNotSet * 2 // Invalid door state
        static let emergencyStop = BackgroundStatus.doorError * 2 // Emergency Stop buuton is pressed
        static let testModeIsActive = BackgroundStatus.emergencyStop * 2 // Tset mode is active
        static let analogInputError = BackgroundStatus.testModeIsActive * 2 // Analog input sensot is out of range
        static let adam6017NotConnected = BackgroundStatus.analogInputError * 2 // Adam 6017 device Not Connected (in static let Air detector or external reference defined)
        static let inputOutputCardNotConnected = BackgroundStatus.adam6017NotConnected * 2 // Fail to connect with I/O card
        static let timeError = BackgroundStatus.inputOutputCardNotConnected * 2 // RTC is either disabled or not working
        
        // Statuses that are displayed by message
        static let protocolPortInValid = BackgroundStatus.timeError * 2 // I/O card protocol port is not valid
        static let cycleEnded = BackgroundStatus.protocolPortInValid * 2 // Razed only if value of parameter 'unlockDoorOnCycleEnd' is 1 and cycle ended successfully
    }
    
    enum VacuumType: Int {
        case none = 0
        case airPump
        case waterRingPump
        case pistonVacuumPump
    }
    
    enum HeatingType {
        case waterHeat
        case internalSteamGenerator
        case externalSteamGenerator
    }
    
    enum JacketType {
        case none
        case doubleWallIsolated
        case heater
        case coil
        case doubleWallIntegrated
    }
    
    enum PhysicalDimension {
        case none
        case horizontal
        case vertical
    }
    
    enum GeneralIndicators {
        case supplyWaterIndicator
        case supplyDistilledWaterIndicator
        case compressedAirIndicator
        case wasteWaterLevel
        case mineralFreeWaterLevel
        case mainExhaust
        case emergencyStop
        case buzzer
        case atmosphericAirValve
        case supplyIndicator
        case propSteamToChamber
        case propExhaust
        case waterToVacuumPumpIndicator
        case waterToGeneratorIndicator
        case wasteWaterIndicator
        case externalOpenCloseDoor1
        case externalOpenCloseDoor2
        case startStopCycle1
        case emptyReservoirVacuumPump
        case coolingFan
        case startStopCycle2
        case vhpOut
        case emergencyStop2
        case steamToChamber2
        case cleanFilter
        case airToDoor
    }
    
    enum DisplaySequence {
        case none
        case first
        case second
        case third
    }
    
    enum BioHazard {
        case none
        case internalFilter
        case thermo
        case externalFilter
        case jacketFilter
    }
    
    enum ConfigutationStatus {
        case none
        // Digital Output 3: ChamberHeat SteamToBio
        case errorWaterHeatBio
        // Digital Output 8: GeneratorHeater MainExhaust
        case errorInternalSteamGeneratorBio
        // Digital Output 6: Air Pump Door Vacuum Pump
        case errorDoorAirPump
        // Digital Output 14: AirToVacuumPump CoolDrain
        case errorDrainTemperaturePistonVacuumPump
        // Digital output 10: CompressedAirToChamber VhpOut
        case errorVhpWithCooling
        // Temperature 6:    Jacket Temperature Bio Jacket
        case errorFilterJacketWithTemperatureJacket
        // Pressure 2:    Jacket Pressure Generator Pressure
        case errorDoubleWallInternalSteamGenerator
        // if water heat is defined - a slow exhaust must also be defined.
        case errorWaterHeatHasSlowExhaust
        // if Air cooling is defined double wall jacket must be defined as well.
        case errorAirCoolingNoJacket
        // DigitalInput 8: DoorLocked VhpIn
        case errorVhpWithHingeOrMotorDoor
        // DigitalInput 2: SupplyWaterIndicator WaterToVacuumPumpIndicator
        // DigitalInput 3: SupplyDistilledWaterIndicator WaterToGeneratorIndicator SupplyIndicator StartStopCycle1
        // DigitalInput 4: CompressedAirIndicator WasteWaterIndicator EmergencyStop StartStopCycle2
        // DigitalInput 8: VhpIn ExternalOpenCloseDoor1
        case errorDuplicatedInput
        case errorDoubleDoorWithEmptyReservoirVacuumPump
        case errorDoubleDoorWithCoolingFan
        // DigitalInput 8: DoorLocked ExternalOpenCloseDoor1
        // DigitalInput 9: Door2Locked EmergencyStop2 ExternalOpenCloseDoor2
        case errorDoorWithExternalOpen
        case errorInternalSteamGeneratorMainExhust
        case errorDoorWithEmergencyStop2
        case errorWaterHeatSteamToChamber2
        case errorDrainWithRef3
        case errorBioWithRef4
        case errorJacketFilterWithRef5
        case errorTemperatureJacketWithRef5
        case errorWaterHeatCleanFilter
        case errorCleanFilterSteamToChamber2
        case errorInternalSteamGeneratorSteamToChamber2
        case errorInternalSteamGeneratorCleanFilter
        case errorAirToDoor
    }
    
}
