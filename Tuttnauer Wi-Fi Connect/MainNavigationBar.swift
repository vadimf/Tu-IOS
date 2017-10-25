//
//  MainNavigationBar.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class MainNavigationBar: UINavigationBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        isTranslucent = false
        barStyle = .black
        backgroundColor = UIColor.tuttnauerOrange()
        barTintColor = UIColor.tuttnauerOrange()
        tintColor = UIColor.white
        shadowImage = UIImage()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
