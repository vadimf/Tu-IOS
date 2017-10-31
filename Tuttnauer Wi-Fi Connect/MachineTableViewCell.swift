//
//  MachineTableViewCell.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/19/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class MachineTableViewCell: UITableViewCell {

    var machine: Machine? {
        didSet {
            setupData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cellContainerView: UIView!
    
    @IBOutlet weak var modelNameTitleLabel: UILabel!
    @IBOutlet weak var serialNumberTitleLabel: UILabel!
    @IBOutlet weak var ipTitleLabel: UILabel!
    @IBOutlet weak var bsVersionTitleLabel: UILabel!
    
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var bsVersionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLocalization()
        resetUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    // MARK: - Setup Methods
    
    private func setupLocalization() {
        modelNameTitleLabel.text = LocalString.scanMachinesScreenTableViewCellModelNameTitle
        serialNumberTitleLabel.text = LocalString.scanMachinesScreenTableViewCellSerialTitle
        ipTitleLabel.text = LocalString.scanMachinesScreenTableViewCellIPTitle
        bsVersionTitleLabel.text = LocalString.scanMachinesScreenTableViewCellBSVersionTitle
    }
    
    private func setupData() {
        guard let machine = self.machine else { return }
        modelNameLabel.text = machine.modelName
        serialNumberLabel.text = machine.serialNumber
        ipLabel.text = machine.ipAddress
        bsVersionLabel.text = machine.bsVersion
    }
    
    private func resetUI() {
        modelNameLabel.text = ""
        serialNumberLabel.text = ""
        ipLabel.text = ""
        bsVersionLabel.text = ""
    }
    
    func highlightCell() {
        cellContainerView.borderColor = UIColor.tuttnauerGreen()
    }
    
    func unHighlightCell() {
        cellContainerView.borderColor = UIColor.tuttnauerLightGreyBorder()
    }

}
