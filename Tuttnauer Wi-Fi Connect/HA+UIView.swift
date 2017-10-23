//
//  HA+UIView.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - IBInspectables
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            return layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            return layer.borderColor = newValue.cgColor
        }
    }
    
    // MARK: - Extra Methods
    
    func shakeView() {
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint: CGPoint = CGPoint(x: self.center.x - 5, y: self.center.y)
        let fromValue:NSValue = NSValue(cgPoint: fromPoint)
        
        let toPoint: CGPoint = CGPoint(x: self.center.x + 5, y: self.center.y)
        let toValue:NSValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        self.layer.add(shake, forKey: "position")
    }
    
    func addBorderLine(color: UIColor, width: CGFloat){
        let border = CALayer()
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
