//: Playground - noun: a place where people can play

import UIKit

//static var count: Int {
//    return (BackgroundStatus.cycleEnded.hashValue + 1)
//}

enum CycleError: Int {
    // No error
    case none = 0
    // User has pushed the stop button and canceled the cycle
    case CanceledByUser
    // Door has been manually opened during cycle
    case DoorIsOpen
    // a analog input has been detected to be out of range
    case AnalogInputError
    // Connection with the I/) card has been lost
    case InputOutputCardNotConnected
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
    
    case P_AirRemovalVacuumFailure
    
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
    case O_VacuumFail
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
    
    static var count: Int {
        return (CycleError.O_InternalError.hashValue + 1)
    }
    
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

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    var camelCasedString: String {
        return self.components(separatedBy: " ")
            .map { return $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }

}

for value in 0..<CycleError.count {
    let name = CycleError.init(rawValue: value)!.getName
    let nameLowerCased = name.lowercased().replacingOccurrences(of: " ", with: "_")
    let finalString = "\"enum_cycle_error_\(nameLowerCased)\" = \"\(name)\";"
    print(finalString)
}

print("----------------------------------")

for value in 0..<CycleError.count {
    let name = CycleError.init(rawValue: value)!.getName
    let nameLowerCased = name.lowercased().replacingOccurrences(of: " ", with: "_")
    let nameCamelCased = name.camelCasedString.replacingOccurrences(of: " ", with: "")
    let finalString = "static let enumCycleError\(nameCamelCased) = \"enum_cycle_error_\(nameLowerCased)\".localized"
    print(finalString)
}


