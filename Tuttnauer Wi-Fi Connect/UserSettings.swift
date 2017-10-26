//
//  UserSettings.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class UserSettings: NSObject {

    var temperatureUnit: Enums.TemperatureUnit?
    var pressureUnit: Enums.PressureUnit?
    var language: Enums.Language?
    var connectionType: Enums.ConnectionType?
    var receiveLiveNotifications: Bool?
    var lastMachineIPAddress: String?
    
}
