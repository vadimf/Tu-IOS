//
//  Utilities.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/22/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class Alerts: NSObject {
    
    class func alertMessage(for viewController: UIViewController, title: String?, message: String?, closeHandler: (()->())?) {
        
        var message = message
        var title = title
        
        if title == nil {
            title = "Error Occured"
        }
        
        if message == nil {
            message = "Whoops.. Something went wrong"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionClose = UIAlertAction(title: LocalString.alertDialogButtonClose, style: .default, handler: { _ in
            closeHandler?()
        })
        
        alert.addAction(actionClose)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func alertMessageWithActions(for viewController: UIViewController, title: String?, message: String?, doneButtonTitle: String = LocalString.alertDialogButtonDone, cancelButtonTitle: String = LocalString.alertDialogButtonCancel, doneHandler: (()->())?, cancelHandler: (()->())?) {
        
        var message = message
        var title = title
        
        if title == nil {
            title = "Error Occured"
        }
        
        if message == nil {
            message = "Whoops.. Something went wrong"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionDone = UIAlertAction(title: doneButtonTitle, style: .default, handler: { _ in
            doneHandler?()
        })
        
        let actionCancel = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler:  { _ in
            cancelHandler?()
        })
        
        alert.addAction(actionDone)
        alert.addAction(actionCancel)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
