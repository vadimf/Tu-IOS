//
//  AppDelegate.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 9/4/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyUserDefaults
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let settingsManager = UserSettingsManager.shared
        
        // Check if this is the App's first run
        if Defaults[.isFirstRun] == nil {
            // This is the first run
            Defaults[.isFirstRun] = false
            settingsManager.firstTimeUserSettingsSetup()
        } else {
            settingsManager.getUserSettingsFromDefaults()
        }
        
        // Check the app version and sync everything if needed
        if let appVersion = Defaults[.appVersion] {
            // If the Defaults AppVersion is different, than we should sync and update
            if appVersion != AppConstants.version {
                // TODO: Do necessary stuff if app version is different
            }
        } else {
            // If no appVersion in Defaults, than let's set one up and sync the data
            Defaults[.appVersion] = AppConstants.version
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        // MachineMonitor.shared.disconnect()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    }


}

