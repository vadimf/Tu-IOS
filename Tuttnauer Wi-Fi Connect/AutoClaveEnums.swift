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
        case noError
        case standByError
        case cycleRunning
        case cycleDone
        case cycleFail
        
        var getName: String {
            switch self {
            case .none:
                return "Ready"
            case .noError:
                return "No Error"
            case .standByError:
                return "Standby Error"
            case .cycleRunning:
                return "Cycle Running"
            case .cycleDone:
                return "Cycle Done"
            case .cycleFail:
                return "Cycle Failed"
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
                return "Door Opened"
            case .door1Closed:
                return "Door Closed"
            case .door1ClosedDoor2Closed:
                return "Door 1 Closed. Door 2 Closed"
            case .door1OpenDoor2Open:
                return "Door 1 Open. Door 2 Open"
            case .door1ClosedDoor2Opened:
                return "Door 1 Closed. Door 2 Opened"
            case .door1OpenDoor2Closed:
                return "Door 1 Open. Door 2 Closed"
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
                return "Instruments"
            case .wrappedInstruments:
                return "Wrapped Instruments"
            case .pouches:
                return "Pouches"
            case .wrappedPouches:
                return "Wrapped Pouches"
            case .delicate:
                return "Delicate"
            case .wrappedDelicate:
                return "Wrapped Delicate"
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
                return "BD Test"
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
                return "Extra Dry"
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
                return "-"
            case .errorVacuuming:
                return "Error Vacuuming"
            case .errorOpening:
                return "Error Opening"
            case .errorClosing:
                return "Error Closing"
            case .errorLocking:
                return "Error Locking"
            case .errorUnlocking:
                return "Error Unlocking"
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
                return ""
            case .global:
                return "Global"
            case .start:
                return "Stating"
            case .removeAir:
                return "Removing Air"
            case .stabilize:
                return "Stabilizing"
            case .heat:
                return "Heating"
            case .sterilization:
                return "Sterilization"
            case .cool:
                return "Cooling"
            case .exhaust:
                return "Exhaust"
            case .dry:
                return "Drying"
            case .ending:
                return "Ending"
            case .done:
                return "Done"
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
        case None = 0
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
        // If chamber pressure does not reach X kPa as defined in cycle parameter 'Pulse [A,B,C,D] Low Pressure'
        // after X minutes as defined in cycle parameter 'Pressure Time Error'
        // <see cref="ParameterNames.PressureTimeError"/>
        case VacuumTimeError = 8
        // If chamber pressure does not reach X kPa as defined in cycle parameter 'Pulse [A,B,C,D] High Pressure'
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
            case .None:
                return "None"
            case .CanceledByUser:
                return "Cancelled By User"
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
                return "Dry High Pressure"
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
    
    // MARK: - WTF?
    
    enum currentWaitingCondition {
        case none
        case waitingForNormalTemperature
        case waitingForCoolingPressure
        case cleaningJacketWater
        case waitingForFaultDry
        case waitingForNormalPressure
        case waitingForCleaningFilter
    }
    
    enum coolingFanMode: Int {
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
