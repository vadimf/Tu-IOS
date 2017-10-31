
//
//  NotificationsManager.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/30/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import UserNotifications
import UserNotificationsUI

typealias NotificationsAuthorizedCompletionHandler = (_ authorized: Bool) -> Void

class NotificationsManager: NSObject {

    static let shared = NotificationsManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        notificationCenter.delegate = self
        checkNotificationsAuthorizationStatus(completion: nil)
    }
    
    // MARK: - Register For Notifications
    
    func registerForNotifications() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            
            guard error == nil else {
                print("Error occured requesting notifications authorization:", error!.localizedDescription)
                return
            }
            
            guard granted else {
                UserSettingsManager.shared.setUserReceiveLiveNotifications(to: false)
                print("Notifications permissions was not granted")
                return
            }
            
            self.checkNotificationsAuthorizationStatus(completion: nil)
            
        }
        
    }
    
    func checkNotificationsAuthorizationStatus(completion: NotificationsAuthorizedCompletionHandler?) {
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                print("Notifications are not authorized")
                completion?(false)
                UserSettingsManager.shared.setUserReceiveLiveNotifications(to: false)
            }
            completion?(true)
        }
    }
    
    // MARK: Creating & Scheduling Notifications
    
    func scheduleLocalNotification(in seconds: TimeInterval, title: String, body: String, sound: UNNotificationSound = .default()) {
        
        guard UserSettingsManager.shared.userSettings.receiveLiveNotifications! else {
            print("Notification blocked. The user doesn't want to receive them")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = sound
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: { (error) in
            guard error == nil else {
                print("Could not create local notification:", error!.localizedDescription)
                return
            }
            print("Notification created")
        })
    }
    
}

// MARK: - UNUserNotificationCenterDelegate Methods

extension NotificationsManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
}
