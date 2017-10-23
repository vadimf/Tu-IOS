//
//  HA+UITextField.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

extension UITextField {
    
    func placeHolderTextAndColor(_ text: String, color: UIColor){
        attributedPlaceholder = NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: color])
    }
    
    func setBottomBorder(color: UIColor , size: CGFloat) {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: size)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
}
