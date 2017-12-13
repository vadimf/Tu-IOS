//
//  AutoClaveEnums.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/21/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class AutoClaveEnums {
        
    enum SystemCurrentStatus: Int {
        case none = 0
        case noError
        case standByError
        case cycleRunning
        case cycleDone
        case cycleFail
        case notReady
        
        var getName: String {
            switch self {
            case .none:
                return LocalString.enumSystemCurrentStatusNone
            case .noError:
                return LocalString.enumSystemCurrentStatusNoError
            case .standByError:
                return LocalString.enumSystemCurrentStatusStandbyError
            case .cycleRunning:
                return LocalString.enumSystemCurrentStatusRunning
            case .cycleDone:
                return LocalString.enumSystemCurrentStatusCycleDone
            case .cycleFail:
                return LocalString.enumSystemCurrentStatusCycleFailed
            case .notReady:
                return LocalString.enumSystemCurrentStatusNotReady
            }
        }
    }
    
    enum BackgroundStatus: Int {
        case none = 0
        case preHeating = 1
        case hotWater
        /// Water are detected in the chamber
        case waterInChamber
        /// Door is open
        case doorOpen
        /// Waste water Reservoir full
        case wasteWaterReservoirFull
        /// mineral free water Reservoir empty
        case mineralFreeWaterReservoirEmpty
        /// Stand by cycle is schedualed  to be run
        case standByCycle
        /// Jacket is cool
        case jacketIsCool
        /// Clean water tank
        case emptyReservoirVacuumPump
        /// Steam generatore pressure is too low
        case steamGeneratorLowPressure
        /// Drain is too hot
        case drainHot
        /// Low gasket pressure
        case lowGasketPressure
        /// Io Extension Not Connected (in case IoExtension defined)
        case adam6060NotConnected
        /// VHP Cycle High Start Temperature
        case vhpCycleHighStartTemperature
        /// VHP Cycle VhpIn Not Read (value = 1)
        case vhpInNotReady
        /// Unable to heta bio filter
        case bioFilterTimeOut
        /// Thermo bio filter is too cold
        case bioFilterIsCool
        /// Printer port is not valid
        case printerPortInvalid
        /// Door is in opening progress
        case doorOpening
        /// Door is in closing progress
        case doorClosing
        /// time out while trying to cool darin
        case coolDrainTimeOut
        /// time out while trying to heat jacket
        case jacketTimeOut
        /// No supply is detected
        case supplyError
        /// No water supply is detected
        case supplyWaterError
        /// no water to vacuum pump
        case waterToVacuumPumpError
        /// no water to generator
        case waterToGeneratorError
        /// No supply distilled water is detected
        case supplyDistilledWaterError
        /// No compressed air supply is detected
        case compressedAirSupplyError
        /// mo water detected in steam generator
        case steamGeneratorNoWaterError
        /// Chamber pressure is out of range
        case chamberPressureNotInRange
        /// Chamber temperature is out of range
        case chamberTemperatureNotInRange
        /// Atmosphereic pressure is not set
        case atmospherePressureNotSet
        /// Invalid door state
        case doorError
        /// Emergency Stop buuton is pressed
        case emergencyStop
        /// Tset mode is active
        case testModeIsActive
        /// Analog input sensot is out of range
        case analogInputError
        /// Adam 6017 device Not Connected (in case Air detector or external reference defined)
        case adam6017NotConnected
        /// Fail to connect with I/O card
        case inputOutputCardNotConnected
        /// RTC is either disabled or not working
        case timeError
        //* Statuses that are displayed by message
        /// I/O card protocol port is not valid
        case protocolPortInValid
        /// Razed only if value of parameter 'unlockDoorOnCycleEnd' is 1 and cycle ended successfuly
        case cycleEnded
        
        static var count: Int {
            return (BackgroundStatus.cycleEnded.hashValue + 1)
        }
        
        var getName: String {
            switch self {
            case .none:
                return "System Ready"
            case .preHeating:
                return "Pre Heating"
            case .hotWater:
                return "Hot water in chamber"
            case .waterInChamber:
                return "Water in chamber"
            case .doorOpen:
                return "Door open"
            case .wasteWaterReservoirFull:
                return "Waste water reservoir"
            case .mineralFreeWaterReservoirEmpty:
                return "Mineral free water reservoir empty"
            case .standByCycle:
                return "Stand by cycle"
            case .jacketIsCool:
                return "Jacket is cool"
            case .emptyReservoirVacuumPump:
                return "Empty reservoir vacuum pup"
            case .steamGeneratorLowPressure:
                return "Steam generator low pressure"
            case .drainHot:
                return "Drain hot"
            case .lowGasketPressure:
                return "Low gasket pressure"
            case .adam6060NotConnected:
                return "IO Extension device not connected"
            case .vhpCycleHighStartTemperature:
                return "High start temperature"
            case .vhpInNotReady:
                return "Vhp input not ready"
            case .bioFilterTimeOut:
                return "Bio filter timeout"
            case .bioFilterIsCool:
                return "Bio filter is cool"
            case .printerPortInvalid:
                return "Printer port is not valid"
            case .doorOpening:
                return "Wait... Door Opening"
            case .doorClosing:
                return "Wait... Door Closing"
            case .coolDrainTimeOut:
                return "Cool drain time out"
            case .jacketTimeOut:
                return "Jacket time out"
            case .supplyError:
                return "Supply error"
            case .supplyWaterError:
                return "Supply water error"
            case .waterToVacuumPumpError:
                return "No water in reservoir vacuum pump"
            case .waterToGeneratorError:
                return "No water in reservoir generator"
            case .supplyDistilledWaterError:
                return "Supply distilled water error"
            case .compressedAirSupplyError:
                return "Compressed air supply error"
            case .steamGeneratorNoWaterError:
                return "Steam generator no water"
            case .chamberPressureNotInRange:
                return "Chamber pressure not in range"
            case .chamberTemperatureNotInRange:
                return "Chamber temperature not in range"
            case .atmospherePressureNotSet:
                return "Atmospheric pressure not set"
            case .doorError:
                return "Door error"
            case .emergencyStop:
                return "Emergency Stop"
            case .testModeIsActive:
                return "Test Mode Is Active"
            case .analogInputError:
                return "Analog input error"
            case .adam6017NotConnected:
                return "Air detector is not connected"
            case .inputOutputCardNotConnected:
                return "I/O card is not connected"
            case .timeError:
                return "Time error"
            case .protocolPortInValid:
                return "Protocol port is not valid"
            case .cycleEnded:
                return "Cycle ended"
            }
        }
    }
    
    enum DoorState: Int {
        case door1Opened = 0
        case door1Closed
        case door1ClosedDoor2Closed
        case door1OpenDoor2Open
        case door1ClosedDoor2Opened
        case door1OpenDoor2Closed
        
        var getName: String {
            switch self {
            case .door1Opened:
                return LocalString.enumDoorStateDoorOpen
            case .door1Closed:
                return LocalString.enumDoorStateDoorClosed
            case .door1ClosedDoor2Closed:
                return LocalString.enumDoorStateDoor1ClosedDoor2Closed
            case .door1OpenDoor2Open:
                return LocalString.enumDoorStateDoor1OpenDoor2Open
            case .door1ClosedDoor2Opened:
                return LocalString.enumDoorStateDoor1ClosedDoor2Open
            case .door1OpenDoor2Closed:
                return LocalString.enumDoorStateDoorDoor1OpenDoor2Closed
            }
        }
    }
    
    enum CycleID: Int {
        case instruments = 0
        case wrappedInstruments
        case pouches
        case wrappedPouches
        case delicate
        case wrappedDelicate
        case liquids1
        case liquids2
        case bigPackages
        case bioHazard1
        case bioHazard2
        case vacuumTest
        case bdTest
        case pasteurization = 33
        case vhp
        case warmUp
        case isothermal
        case glass
        case plastic
        case liquidRegular
        case liquid2Waste
        case liquid1Cooling
        case liquid2WasteCooling
        case waste
        case hollowLoad
        case bioHazardLiquids
        case unwrapped134
        case wrapped134
        case unwrapped121
        case wrapped121
        case prion134
        case extraDry
        case airSteamMixture
        case glassTest
        case custom1 = 100
        case custom2
        case custom3
        case custom4
        case custom5
        case custom6
        case custom7
        case custom8
        case custom9
        case custom10
        case custom11
        case custom12
        case custom13
        case custom14
        case custom15
        case custom16
        case custom17
        case custom18
        case custom19
        case custom20
        
        var getName: String {
            switch self {
            case .instruments:
                return "Unwrapped instruments"
            case .wrappedInstruments:
                return "Wrapped Instruments"
            case .pouches:
                return "Pouches"
            case .wrappedPouches:
                return "Wrapped Pouches"
            case .delicate:
                return "Unwrapped delicate inst."
            case .wrappedDelicate:
                return "Wrapped delicate inst."
            case .liquids1:
                return "Liquids A"
            case .liquids2:
                return "Liquids B"
            case .bigPackages:
                return "Big Packages"
            case .bioHazard1:
                return "Bio Hazard A"
            case .bioHazard2:
                return "Bio Hazard B"
            case .vacuumTest:
                return "Vacuum Test"
            case .bdTest:
                return "Bowie and Dick"
            case .pasteurization:
                return "Pasteurization"
            case .vhp:
                return "Vhp"
            case .warmUp:
                return "Warm Up"
            case .isothermal:
                return "Isothermal"
            case .glass:
                return "Glass"
            case .plastic:
                return "Plastic"
            case .liquidRegular:
                return "Liquid A"
            case .liquid2Waste:
                return "Liquid B Waste"
            case .liquid1Cooling:
                return "Liquid A Cooling"
            case .liquid2WasteCooling:
                return "Liquid B Waste Cooling"
            case .waste:
                return "Waste"
            case .hollowLoad:
                return "Hollow Load"
            case .bioHazardLiquids:
                return "BioHazard Liquids"
            case .unwrapped134:
                return "Unwrapped 134"
            case .wrapped134:
                return "Wrapped 134"
            case .unwrapped121:
                return "Unwrapped 121"
            case .wrapped121:
                return "Wrapped 121"
            case .prion134:
                return "Prion 134"
            case .extraDry:
                return "Extra Drying Time"
            case .airSteamMixture:
                return "Air Steam Mixture"
            case .glassTest:
                return "Glass Test"
            case .custom1:
                return "Custom 1"
            case .custom2:
                return "Custom 2"
            case .custom3:
                return "Custom 3"
            case .custom4:
                return "Custom 4"
            case .custom5:
                return "Custom 5"
            case .custom6:
                return "Custom 6"
            case .custom7:
                return "Custom 7"
            case .custom8:
                return "Custom 8"
            case .custom9:
                return "Custom 9"
            case .custom10:
                return "Custom 10"
            case .custom11:
                return "Custom 11"
            case .custom12:
                return "Custom 12"
            case .custom13:
                return "Custom 13"
            case .custom14:
                return "Custom 14"
            case .custom15:
                return "Custom 15"
            case .custom16:
                return "Custom 16"
            case .custom17:
                return "Custom 17"
            case .custom18:
                return "Custom 18"
            case .custom19:
                return "Custom 19"
            case .custom20:
                return "Custom 20"
            }
        }
    }
    
    enum DoorError: Int {
        case none = 0
        case errorVacuuming
        case errorOpening
        case errorClosing
        case errorLocking
        case errorUnlocking
        
        var getName: String {
            switch self {
            case .none:
                return LocalString.enumDoorErrorNone
            case .errorVacuuming:
                return LocalString.enumDoorErrorVacuuming
            case .errorOpening:
                return LocalString.enumDoorErrorOpening
            case .errorClosing:
                return LocalString.enumDoorErrorClosing
            case .errorLocking:
                return LocalString.enumDoorErrorLocking
            case .errorUnlocking:
                return LocalString.enumDoorErrorUnlocking
            }
        }
    }
    
    enum CycleStage: Int {
        case none = 0
        case global
        case start
        case removeAir
        case stabilize
        case heat
        case sterilization
        case cool
        case exhaust
        case dry
        case ending
        case done
        
        var getName: String {
            switch self {
            case .none:
                return LocalString.enumCycleStageNone
            case .global:
                return LocalString.enumCycleStageGlobal
            case .start:
                return LocalString.enumCycleStageStart
            case .removeAir:
                return LocalString.enumCycleStageRemoveAir
            case .stabilize:
                return LocalString.enumCycleStageStabilize
            case .heat:
                return LocalString.enumCycleStageHeat
            case .sterilization:
                return LocalString.enumCycleStageSterilization
            case .cool:
                return LocalString.enumCycleStageCool
            case .exhaust:
                return LocalString.enumCycleStageExhaust
            case .dry:
                return LocalString.enumCycleStageDry
            case .ending:
                return LocalString.enumCycleStageEnding
            case .done:
                return LocalString.enumCycleStageDone
            }
        }
    }
    
    enum CycleSubStage: Int {
        case none = 0
        case purge = 1
        case insertWater = 2
        case steamFlush = 3
        case createPulse = 4
        case pulseH = 5
        case pulseL = 6
        case vacuum = 7
        case stay1 = 8
        case stay2 = 9
        case vhpWait = 10
        case vhpRunning = 11
        case vhpEnding = 12
        case stableBeforSter = 13
        case stableAfterSter = 14
        case waitForOpenDoor = 15
        case preStableBeforSter = 16
        case preStableAfterSter = 17
        case preHeat = 18
        case filterTestInsertWater = 19
        case filterTestCreatePressure = 20
        case filterTestStable = 21
        case filterTestTesting = 22
        case filterTestExhaust = 23
        case cool1
        case cool2
        case cool3
        case exhust1
        case exhust2
        
        var getName: String {
            switch self {
            case .none:
                return ""
            case .purge:
                return "Purge"
            case .insertWater:
                return "Insert Water"
            case .steamFlush:
                return "Steam Flush"
            case .createPulse:
                return "Create Pulse"
            case .pulseH:
                return "Pulse H"
            case .pulseL:
                return "Pulse L"
            case .vacuum:
                return "vacuum"
            case .stay1:
                return "Stay A"
            case .stay2:
                return "Stay B"
            case .vhpWait:
                return "Vhp Wait"
            case .vhpRunning:
                return "Vhp Running"
            case .vhpEnding:
                return "Vhp Ending"
            case .stableBeforSter:
                return "Stable before Ster"
            case .stableAfterSter:
                return "Stabel after Ster"
            case .waitForOpenDoor:
                return "Wait for open door"
            case .preStableBeforSter:
                return "Pre-Stable before Ster"
            case .preStableAfterSter:
                return "Pre-Stable after Ster"
            case .preHeat:
                return "Pre-Heat"
            case .filterTestInsertWater:
                return "Filter test insert water"
            case .filterTestCreatePressure:
                return "Filter test create pressure"
            case .filterTestStable:
                return "Filter test stable"
            case .filterTestTesting:
                return "Filter test testing"
            case .filterTestExhaust:
                return "Filter test exhaust"
            case .cool1:
                return "Cool A"
            case .cool2:
                return "Cool B"
            case .cool3:
                return "Cool C"
            case .exhust1:
                return "Exhaust A"
            case .exhust2:
                return "Exhaust B"
            }
        }
    }
    
    enum CycleError: Int {
        // No error
        case none = 0
        // User has pushed the stop button and canceled the cycle
        case CanceledByUser = 1
        // Door has been manually opened during cycle
        case DoorIsOpen = 2
        // a analog input has been detected to be out of range
        case AnalogInputError = 3
        // Connection with the I/) card has been lost
        case InputOutputCardNotConnected = 4
        // Electric power down accord while cycle was running
        case PowerDown = 5
        // If water has not been detected (water level sensor is bigger than 3000) after X seconds as
        // defined in parameter <see cref="ParameterNames.WaterTimeError"/>
        case InsertWaterTimeError = 6
        // If chamber temperature does not reach X�c as defined in parameter <see cref="ParameterNames.ExhaustTopTemperature"/>
        // after X minutes as defined in parameter <see cref="ParameterNames.HeatTimeError"/>
        case HeatBeforePressureTimeError = 7
        // If chamber pressure does not reach X kPa as defined in cycle parameter 'Pulse [ABCD] Low Pressure'
        // after X minutes as defined in cycle parameter 'Pressure Time Error'
        // <see cref="ParameterNames.PressureTimeError"/>
        case VacuumTimeError = 8
        // If chamber pressure does not reach X kPa as defined in cycle parameter 'Pulse [ABCD] High Pressure'
        // after X minutes as defined in cycle parameter 'Pressure Time Error'
        case PressureTimeError = 9
        // If chamber temperature does not reach X�c as defined in parameter <see cref="ParameterNames.Temperature1Stay"/>
        // or in parameter <see cref="ParameterNames.Temperature2Stay"/> after X minutes as defined in parameter
        // <see cref="ParameterNames.HeatTimeError"/>
        case KeepHeatTimeError = 10
        // If chamber temperature does not reach X�c as defined in parameter <see cref="ParameterNames.SterilizationTemperature"/>
        // after X minutes as defined in parameter <see cref="ParameterNames.HeatTimeError"/>
        case HeatToSterilizationTimeError = 11
        // If chamber pressure goes below the minimum valid sterilization pressure.
        case SterilizationLowPressure = 12
        // If chamber pressure goes above the maximum valid sterilization pressure.
        case SterilizationHighPressure = 13
        // If chamber temperature goes below the sterilization temperature as defined in parameter
        // <see cref="ParameterNames.SterilizationTemperature"/>
        case SterilizationLowTemperature = 14
        // If chamber temperature goes 3�c above the value defined in parameter
        // <see cref="ParameterNames.SterilizationTemperature"/>
        case SterilizationHighTemperature = 15
        // If there is a gap in sterilization time of more then 3 seconds between the two clocks of the machine
        case RtcTimeError = 16
        // If chamber pressure does not reach X kPa as defined in parameter <see cref="ParameterNames.CoolPressure"/>
        // after 10 minutes
        case CoolingLowPressure = 17
        // If chamber temperature does not goes below X�c as defined in parameter <see cref="ParameterNames.EndTemperature"/>
        // after X minutes as defined in parameter <see cref="ParameterNames.CoolError"/>
        case CoolingHighTemperature = 18
        // If chamber pressure does not goes below atmospheric pressure + 10 kPa after 10 minutes
        case ExhaustHighPressure = 19
        // If chamber pressure does is above atmospheric pressure + 10 kPa when staring dry stage
        case DryHighPressure = 20
        // If chamber pressure is above atmospheric pressure + 5 kPa 10 minutes after the end stage begins
        case EndingHighPressure = 21
        // If chamber pressure is below atmospheric pressure - 5kpa 10 minutes after the end stage begins
        case AirError = 22
        // If chamber temperature does not reach X�c as defined in parameter
        // <see cref="ParameterNames.EndTemperature"/>'' 120 minutes after the end stage begins
        case EndingHighTemperature = 23
        // Used only in 'Sliding Door Test Cycle' if unable to open door between multipul cycles test
        case ErrorOpenDoor = 24
        // Used only in 'Sliding Door Test Cycle' if unable to close door between multipul cycles test
        case ErrorCloseDoor = 25
        // In VHP cycle - If Digital input VhsCoplete value == 0 after x minutes as defined in parameter VhpCompleteTimeout
        case VhpTimeout = 26
        // If emergency stop has been pushed during cyle (If Digital input 'Emergency Stop' value is '0')
        case EmergencyStop = 27
        // If bio hazard fillter is not ready after 2 minutes from the start of stage 'Purge'
        case ThermoBioFilterTimeOut = 28
        // If chamber temperature did is below  X�c as defined in cycle parameter 'Purge Temperature' X minutes (as defined in cycle parameter 'Purge Time Out) after the purge stage begins
        case PurgeTimeOut = 29
        // if value of  'Air Detctor Pressure' is bigger then  value defined in cycle parameter 'Air Detector'
        case AirDetctor = 30
        // In case an unexpected software bug have been created during cycle
        case InternalError = 31
        // in case vacuum test cycle fail
        case Leak = 32
        case VhpFail = 33
        case PreHeatTimeOut = 34
        case JacketIsCool = 35
        // Filter test cycle
        case WaterHighTemperature = 36
        // Filter test cycle
        case LowWaterPressure = 37
        // Filter test cycle
        case PipingError = 38
        // Filter test cycle
        case FaultFilter = 39
        
        ///////////////////////////////////////////////////////////////
        //
        //  PLAZMAX !!!
        //
        ///////////////////////////////////////////////////////////////
        
        case P_AirRemovalVacuumFailure = 1000
        
        case P_Leak
        
        case P_PrepareAirInletFailure
        case P_PrepareVacuumFailure
        case P_BurnerNotReady
        
        case P_Diffusion1LowPressure
        case P_Diffusion1HighPressure
        case P_Diffusion1HighRate
        case P_Diffusion1AirInletFailure
        
        case P_Plazma1VacuumFailure
        
        case P_Diffusion2LowPressure
        case P_Diffusion2HighPressure
        case P_Diffusion2HighRate
        case P_Diffusion2AirInletFailure
        
        case P_Plazma2VacuumFailure
        
        case P_AerationVacuumFailure
        case P_AerationAirInletFailure
        case P_NormalPressure
        
        case P_CanceledByUser
        case P_EmergencyStop
        case P_InputOutputCardNotConnected
        case P_AnalogInputError
        case P_PowerDown
        case P_DoorIsOpen
        case P_CanceledByAdmin
        case P_InternalError
        
        ///////////////////////////////////////////////////////////////
        //
        //  OzMAX !!!
        //
        ///////////////////////////////////////////////////////////////
        case O_VacuumFail = 2000
        case O_Leak
        case O_SteamError
        case O_O3TimeOut
        case O_O3LowConcentration
        case O_ExhaustVacuumFail
        case O_ExhaustPressureFail
        case O_NormalPressure
        case O_O3HighConcentration
        
        case O_O3Leaks
        case O_O3Dis
        case O_NoO2Supply
        case O_NoSteam
        case O_AnalogInputError
        case O_DoorIsOpen
        case O_CanceledByUser
        case O_InputOutputCardNotConnected
        case O_PowerDown
        case O_InternalError
        
        var getName: String {
            switch self {
            case .none:
                return ""
            case .CanceledByUser:
                return "Cancelled by user"
            case .DoorIsOpen:
                return "Door Is Open"
            case .AnalogInputError:
                return "Analog Input Error"
            case .InputOutputCardNotConnected:
                return "IO Card Not Connected"
            case .PowerDown:
                return "Power Down"
            case .InsertWaterTimeError:
                return "Insert Water Time Error"
            case .HeatBeforePressureTimeError:
                return "Heat Before Pressure Time Error"
            case .VacuumTimeError:
                return "Vacuum Time Error"
            case .PressureTimeError:
                return "Pressure Time Error"
            case .KeepHeatTimeError:
                return "Keep Heat Time Error"
            case .HeatToSterilizationTimeError:
                return "Heat To Sterilization Time Error"
            case .SterilizationLowPressure:
                return "Sterilization Low Pressure"
            case .SterilizationHighPressure:
                return "Sterilization High Pressure"
            case .SterilizationLowTemperature:
                return "Sterilization Low Temp"
            case .SterilizationHighTemperature:
                return "Sterilization High Temp"
            case .RtcTimeError:
                return "Rtc Timer Error"
            case .CoolingLowPressure:
                return "Cooling Low Pressure"
            case .CoolingHighTemperature:
                return "Cooling High Temp"
            case .ExhaustHighPressure:
                return "Exhaust High Pressure"
            case .DryHighPressure:
                return "High Pressure (Dry)"
            case .EndingHighPressure:
                return "Ending High Pressure"
            case .AirError:
                return "Air Error"
            case .EndingHighTemperature:
                return "Ending High Temperature"
            case .ErrorOpenDoor:
                return "Error Open Door"
            case .ErrorCloseDoor:
                return "Error Close Door"
            case .VhpTimeout:
                return "Vhp Timeout"
            case .EmergencyStop:
                return "Emergency Stop"
            case .ThermoBioFilterTimeOut:
                return "Thermo Bio Filter Timeout"
            case .PurgeTimeOut:
                return "Purge Timeout"
            case .AirDetctor:
                return "Air Detector"
            case .InternalError:
                return "Internal Error"
            case .Leak:
                return "Leak"
            case .VhpFail:
                return "Vhp Fail"
            case .PreHeatTimeOut:
                return "Pre Heat Timeout"
            case .JacketIsCool:
                return "Jacket Is Cool"
            case .WaterHighTemperature:
                return "Water High Temp"
            case .LowWaterPressure:
                return "Low Water Pressure"
            case .PipingError:
                return "Piping Error"
            case .FaultFilter:
                return "Fault Filter"
            case .P_AirRemovalVacuumFailure:
                return "P Air Removal Vacuum Failure"
            case .P_Leak:
                return "P Leak"
            case .P_PrepareAirInletFailure:
                return "P Prepare Air Inlet Failure"
            case .P_PrepareVacuumFailure:
                return "P Prepare Vacuum Failure"
            case .P_BurnerNotReady:
                return "P Burner Not Ready"
            case .P_Diffusion1LowPressure:
                return "P Diffusion 1 Low Pressure"
            case .P_Diffusion1HighPressure:
                return "P Diffusion 1 High Pressure"
            case .P_Diffusion1HighRate:
                return "P Diffusion 1 High Rate"
            case .P_Diffusion1AirInletFailure:
                return "P Diffusion 1 Air Inlet Failure"
            case .P_Plazma1VacuumFailure:
                return "P Plazma 1 Vacuum Failure"
            case .P_Diffusion2LowPressure:
                return "P Diffusion 2 Low Pressure"
            case .P_Diffusion2HighPressure:
                return "P Diffusion 2 High Pressure"
            case .P_Diffusion2HighRate:
                return "P Diffusion 2 High Rate"
            case .P_Diffusion2AirInletFailure:
                return "P Diffusion 2 Air Inlet Failure"
            case .P_Plazma2VacuumFailure:
                return "P Plazma 2 Vacuum Failure"
            case .P_AerationVacuumFailure:
                return "P Aeration Vacuum Failure"
            case .P_AerationAirInletFailure:
                return "P Aeration Air Inlet Failure"
            case .P_NormalPressure:
                return "P Normal Pressure"
            case .P_CanceledByUser:
                return "P Cancelled By User"
            case .P_EmergencyStop:
                return "P Emergency Stop"
            case .P_InputOutputCardNotConnected:
                return "P IO Card Not Connected"
            case .P_AnalogInputError:
                return "P Analog Input Error"
            case .P_PowerDown:
                return "P Power Down"
            case .P_DoorIsOpen:
                return "P Door Is Open"
            case .P_CanceledByAdmin:
                return "P Cancelled By Admin"
            case .P_InternalError:
                return "P Internal Error"
            case .O_VacuumFail:
                return "0 Vacuum Fail"
            case .O_Leak:
                return "0 Leak"
            case .O_SteamError:
                return "0 Steam Error"
            case .O_O3TimeOut:
                return "0 03 Timeout"
            case .O_O3LowConcentration:
                return "0 03 Low Concentration"
            case .O_ExhaustVacuumFail:
                return "0 Exhaust Vacuum Fail"
            case .O_ExhaustPressureFail:
                return "0 Exhaust Pressure Fail"
            case .O_NormalPressure:
                return "0 Normal Pressure"
            case .O_O3HighConcentration:
                return "0 03 High Concentration"
            case .O_O3Leaks:
                return "0 03 Leaks"
            case .O_O3Dis:
                return "0 03 Dis"
            case .O_NoO2Supply:
                return "0 No 02 Supply"
            case .O_NoSteam:
                return "0 No Steam"
            case .O_AnalogInputError:
                return "0 Analog Input Error"
            case .O_DoorIsOpen:
                return "0 Door Is Open"
            case .O_CanceledByUser:
                return "0 Cancelled By User"
            case .O_InputOutputCardNotConnected:
                return "0 IO Card Not Connected"
            case .O_PowerDown:
                return "0 Power Down"
            case .O_InternalError:
                return "0 Internal Error"
            }
        }
    }
    
    enum AnalogInputShorNames: Int {
        case none = -1
        case door1 = 0
        case door2
        case chamberTemperature
        case refChamberTemperature1
        case bioHazardTemperature
        case chamberPressure
        case water
        case jacketPressure
        case jacketTemperature
        case generator
        case drainTemperature
        case refChamberTemperature2
        case generatorWater
        case waterWaste
        case waterDistillled
        case airDetectorPressure
        case bioJacket
        case externalTemperature
        case externalPressure
        case refChamberTemperature3
        case refChamberTemperature4
        case refChamberTemperature5
        case filterPressure
        case filterTemperature
        
        var getName: String {
            switch self {
            case .none:
                return LocalString.enumAnalogInputNameNone
            case .door1:
                return LocalString.enumAnalogInputNameDoor1
            case .door2:
                return LocalString.enumAnalogInputNameDoor2
            case .chamberTemperature:
                return LocalString.enumAnalogInputNameTemperature
            case .refChamberTemperature1:
                return LocalString.enumAnalogInputNameTemp1
            case .bioHazardTemperature:
                return LocalString.enumAnalogInputNameBioTemp
            case .chamberPressure:
                return LocalString.enumAnalogInputNamePressure
            case .water:
                return LocalString.enumAnalogInputNameWater
            case .jacketPressure:
                return LocalString.enumAnalogInputNameJacketPressure
            case .jacketTemperature:
                return LocalString.enumAnalogInputNameJacketTemperature
            case .generator:
                return LocalString.enumAnalogInputNameGenerator
            case .drainTemperature:
                return LocalString.enumAnalogInputNameDrainTemperature
            case .refChamberTemperature2:
                return LocalString.enumAnalogInputNameTemp2
            case .generatorWater:
                return LocalString.enumAnalogInputNameGeneratorWater
            case .waterWaste:
                return LocalString.enumAnalogInputNameWaterWaste
            case .waterDistillled:
                return LocalString.enumAnalogInputNameDistilledWater
            case .airDetectorPressure:
                return LocalString.enumAnalogInputNameAirPressureDetector
            case .bioJacket:
                return LocalString.enumAnalogInputNameBioJacket
            case .externalTemperature:
                return LocalString.enumAnalogInputNameExtTemperature
            case .externalPressure:
                return LocalString.enumAnalogInputNameExtPressure
            case .refChamberTemperature3:
                return LocalString.enumAnalogInputNameTemp3
            case .refChamberTemperature4:
                return LocalString.enumAnalogInputNameTemp4
            case .refChamberTemperature5:
                return LocalString.enumAnalogInputNameTemp5
            case .filterPressure:
                return LocalString.enumAnalogInputNameFilterPressure
            case .filterTemperature:
                return LocalString.enumAnalogInputNameFilterTemperature
            }
        }
    }
    
    enum MainParametersNames: Int {
        case none = -1
        case sterTemperature = 0
        case sterTime
        case dryTime
        case stable1Temperature = 12
        case stable1Time
        case stable2Temperature
        case stable2Time
        case requestPressure = 56
        case vacuumTime1
        case vacuumTime2
        case filterTestTime = 131
        case dryPulses = 136
        
        var getName: String {
            switch self {
            case .none:
                return LocalString.enumMainParameterNameNone
            case .sterTemperature:
                return LocalString.enumMainParameterNameSterTemp
            case .sterTime:
                return LocalString.enumMainParameterNameSterTime
            case .dryTime:
                return LocalString.enumMainParameterNameDryTime
            case .stable1Temperature:
                return LocalString.enumMainParameterNameStable1Temperature
            case .stable1Time:
                return LocalString.enumMainParameterNameStable1Time
            case .stable2Temperature:
                return LocalString.enumMainParameterNameStable2Temperature
            case .stable2Time:
                return LocalString.enumMainParameterNameStable2Time
            case .requestPressure:
                return LocalString.enumMainParameterNameVacPres
            case .vacuumTime1:
                return LocalString.enumMainParameterNameVacTime1
            case .vacuumTime2:
                return LocalString.enumMainParameterNameVacTime2
            case .filterTestTime:
                return LocalString.enumMainParameterNameTestTime
            case .dryPulses:
                return LocalString.enumMainParameterNameDryPulses
            }
        }
    }
    
    enum MainParametersUnits: Int {
        case none = -1
        case temperature = 0
        case time
    }
    
    enum AnalogUnitsTypes {
        case temperature
        case pressure
    }
    
    enum AnalogUnits: Int {
        case celsius = 0
        case fahrenheit
        case kpa
        case psia
        case psig
        case barA
        case barG
        case inhg
        case mbar
    }
    
}
