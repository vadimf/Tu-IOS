//
//  SideMenuIconTableViewCell.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/25/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class SideMenuIconTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetUI()
        tintColor = UIColor.tuttnauerGreen()
        let separatorView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: frame.size.height - 1), size: CGSize(width: frame.size.width, height: 1)))
        separatorView.backgroundColor = UIColor.tuttnauerGrey()
        addSubview(separatorView)
        bringSubview(toFront: separatorView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    private func resetUI() {
        titleLabel.text = ""
        subtitleLabel.text = ""
    }

}
