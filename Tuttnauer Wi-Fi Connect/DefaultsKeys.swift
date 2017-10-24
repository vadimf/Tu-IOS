//
//  DefaultsKeys.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {

    // General
    
    static let isFirstRun = DefaultsKey<Bool?>("isFirstRun")
    static let appVersion = DefaultsKey<String?>("appVersion")
    
    // User Settings
    
    static let userTemperatureUnit = DefaultsKey<Int?>("userTemperatureUnit")
    static let userPressureUnit = DefaultsKey<Int?>("userPressureUnit")
    static let userLanguage = DefaultsKey<Int?>("userPressureUnit")
    static let userConnectionType = DefaultsKey<Int?>("userConnectionType")
    static let userReceiveLiveNotifications = DefaultsKey<Bool?>("userReceiveLiveNotifications")
    
}
