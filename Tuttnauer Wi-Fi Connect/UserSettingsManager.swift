//
//  UserSettingsManager.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class UserSettingsManager: NSObject {

    static let shared = UserSettingsManager()
    
    var userSettings: UserSettings!

    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        userSettings = UserSettings()
    }
    
    // MARK: - Setup Methods
    
    func firstTimeUserSettingsSetup() {
        
        // UserDefaults
        Defaults[.userTemperatureUnit] = Enums.TemperatureUnit.celsius.rawValue
        Defaults[.userPressureUnit] = Enums.PressureUnit.kpa.rawValue
        Defaults[.userLanguage] = Enums.Language.english.rawValue
        Defaults[.userReceiveLiveNotifications] = true
        Defaults[.userConnectionType] = Enums.ConnectionType.autoConnectOnStart.rawValue
        Defaults[.userLastMachineIPAddress] = ""
        
        // Also, let's populate the UserSettings object
        userSettings.temperatureUnit = .celsius
        userSettings.pressureUnit = .kpa
        userSettings.language = .english
        userSettings.receiveLiveNotifications = true
        userSettings.connectionType = .autoConnectOnStart
        userSettings.lastMachineIPAddress = ""
    }
    
    func getUserSettingsFromDefaults() {
        
        guard let temperatureUnit = Defaults[.userTemperatureUnit],
            let pressureUnit = Defaults[.userPressureUnit],
            let language = Defaults[.userLanguage],
            let liveNotifications = Defaults[.userReceiveLiveNotifications],
            let connectionType = Defaults[.userConnectionType],
            let lastMachineIP = Defaults[.userLastMachineIPAddress] else { return }
        
        userSettings.temperatureUnit = Enums.TemperatureUnit(rawValue: temperatureUnit)
        userSettings.pressureUnit = Enums.PressureUnit(rawValue: pressureUnit)
        userSettings.language = Enums.Language(rawValue: language)
        userSettings.receiveLiveNotifications = liveNotifications
        userSettings.connectionType = Enums.ConnectionType(rawValue: connectionType)
        userSettings.lastMachineIPAddress = lastMachineIP
    }

    // MARK: - Modification Methods
    
    func setUserTemperatureUnit(to unit: Enums.TemperatureUnit) {
        Defaults[.userTemperatureUnit] = unit.rawValue
        userSettings.temperatureUnit = unit
    }
    
    func setUserPressureUnit(to unit: Enums.PressureUnit) {
        Defaults[.userPressureUnit] = unit.rawValue
        userSettings.pressureUnit = unit
    }
    
    func setUserLanguage(to language: Enums.Language) {
        Defaults[.userLanguage] = language.rawValue
        userSettings.language = language
    }
    
    func setUserReceiveLiveNotifications(to receive: Bool) {
        Defaults[.userReceiveLiveNotifications] = receive
        userSettings.receiveLiveNotifications = receive
    }
    
    func setUserConnectionType(to connectionType: Enums.ConnectionType) {
        Defaults[.userConnectionType] = connectionType.rawValue
        userSettings.connectionType = connectionType
    }
    
    func setUserLastMachineIPAddress(to ipAddress: String) {
        if userSettings.lastMachineIPAddress == ipAddress { return }
        Defaults[.userLastMachineIPAddress] = ipAddress
        userSettings.lastMachineIPAddress = ipAddress
    }
    
}
