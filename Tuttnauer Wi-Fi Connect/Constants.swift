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
    static let scanMachinesToSinleMachine = "Scan Machines to Single Machine Segue"
    static let singleMachineToSettings = "Single Machine to Settings Segue"
    static let singleMachineToSideMenu = "Single Machine To Side Menu Segue"
    static let singleMachineToSystemStatusPopup = "Single Machine to System Status Popup Segue"
    static let settingsToSettingsOptions = "Settings To Settings Options Segue"
}

struct TableViewCellsIdentifiers {
    static let scanForMachinesTableViewCell = "Scan For Machines Cell"
    static let settingsOptionTableViewCell = "Settings Option Cell"
    static let sideMenuCell = "Side Menu Cell"
    static let sideMenuIconCell = "Side Menu Icon Cell"
    static let systemStatusErrorCell = "System Status Error Cell"
}

struct NotificationsIdentifiers {
    static let didFinishFetchingSingleMachineDataNotification = NSNotification.Name.init("didFinishFetchingSingleMachineDataNotification")
    static let machineDidDisconnectUserInitiated = NSNotification.Name.init("machineDidDisconnectUserInitiated")
    static let machineDidDisconnect = NSNotification.Name.init("machineDidDisconnect")
    static let reachabilityChanged = Notification.Name.reachabilityChanged
    static let didFindNewMachineOnTheNetworkNotification = NSNotification.Name.init("didFindNewMachineOnTheNetworkNotification")
}
