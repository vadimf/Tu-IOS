//
//  Utilities.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/22/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class Utilities {
    
    // MARK: - UI Components
    
    class func contentNotAvailableLabel(for view: UIView, message: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = message
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = color
        label.textAlignment = .center
        label.sizeToFit()
        label.center = view.center
        return label
    }
    
    // MARK: - Push Notifications
    
    
    // MARK: - Languages
    
    class func getDeviceLanguageDirection() -> UIUserInterfaceLayoutDirection {
        
        return UIApplication.shared.userInterfaceLayoutDirection
    }
    
}
