//
//  Enums.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class Enums: NSObject {

    enum SettingsOptions {
        case temperatureUnit
        case pressureUnit
        case language
        case connectionType
    }
    
    enum TemperatureUnit: Int {
        case celsius = 0
        case fahrenheit
        
        static let allValues = [celsius, fahrenheit]
        
        var getName: String {
            switch self {
            case .celsius:
                return "°C"
            case .fahrenheit:
                return "°F"
            }
        }
        
        var getFullName: String {
            switch self {
            case .celsius:
                return "\(LocalString.settingsScreenCellTemperatureOptionCelcius) °C"
            case .fahrenheit:
                return "\(LocalString.settingsScreenCellTemperatureOptionFahrenheit) °F"
            }
        }
    }
    
    enum PressureUnit: Int {
        case kpa = 2
        case psia
        case psig
        case barA
        case barG
        case inhg
        case mBar
        
        static let allValues = [kpa, psia, psig, barA, barG, inhg, mBar]
        
        var getName: String {
            switch self {
            case .kpa:
                return "kPa"
            case .psia:
                return "Psia"
            case .psig:
                return "Psig"
            case .barA:
                return "BarA"
            case .barG:
                return "BarG"
            case .inhg:
                return "Inhg"
            case .mBar:
                return "Mbar"
            }
        }
    }
    
    enum Language: Int {
        case english = 0
        case spanish
        
        static let allValues = [english, spanish]
        
        var getName: String {
            switch self {
            case .english:
                return LocalString.languageEnglish
            case .spanish:
                return LocalString.languageSpanish
            }
        }
    }
    
    enum ConnectionType: Int {
        case autoConnectOnStart = 0
        case manualConnect
        case connectToLastMachine
        
        static let allValues = [autoConnectOnStart, manualConnect, connectToLastMachine]
        
        var getName: String {
            switch self {
            case .autoConnectOnStart:
                return LocalString.settingsScreenCellChooseConnectionOptionAuto
            case .manualConnect:
                return LocalString.settingsScreenCellChooseConnectionOptionManual
            case .connectToLastMachine:
                return LocalString.settingsScreenCellChooseConnectionOptionLastMachine
            }
        }
    }
    
    enum SideMenuItems {
        case privacyNotice
        case help
        case about
        
        static let allValues = [privacyNotice, help, about]
        
        var getName: String {
            switch self {
            case .privacyNotice:
                return LocalString.sideMenuItemPrivacyNoticeTitle
            case .help:
                return LocalString.sideMenuItemHelpTitle
            case .about:
                return LocalString.sideMenuItemAboutTitle
            }
        }
        
        var getValue: String {
            switch self {
            case .privacyNotice:
                return ""
            case .help:
                return ""
            case .about:
                return "https://tuttnauer.com"
            }
        }
        
        var isEnabled: Bool {
            switch self {
            case .privacyNotice:
                return false
            case .help:
                return false
            case .about:
                return true
            }
        }
    }
    
}
