//
//  MachineRealTime.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/24/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class MachineRealTime: NSObject {

    // Real Time State
    var systemStatus: Int = 0
    var cycleName: AutoClaveEnums.CycleIDs?
    var screenSaverOn: Int = 0
    var doorState: Int = 0
    
}
