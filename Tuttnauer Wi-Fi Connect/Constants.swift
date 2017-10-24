//
//  Constants.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

struct AppConstants {
    static let version = "1.0"
}

struct SegueIdentifiers {
    static let mainConnectToSingleMachine = "Main Connect to Single Machine Segue"
    static let singleMachineToSettings = "Single Machine to Settings Segue"
}

struct TableViewCellsIdentifiers {
    static let scanForMachinesTableViewCell = "Scan For Machines Cell"
}

struct NotificationsIdentifiers {
    static let didFinishFetchingSingleMachineDataNotification = NSNotification.Name.init("didFinishFetchingSingleMachineDataNotification")
}
