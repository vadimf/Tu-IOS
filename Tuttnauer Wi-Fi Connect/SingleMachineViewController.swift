//
//  SingleMachineViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class SingleMachineViewController: UIViewController {

    var machineMonitor: MachineMonitor?
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        machineMonitor = MachineMonitor.shared // Singleton Class
        machineMonitor?.delegate = self
        machineMonitor?.getMachineSetupData() // Request the initial machine object with data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Methods
    
    private func setupLocalization() {
        modelNameLabel.text = ""
        serialNumberLabel.text = ""
        ipAddressLabel.text = ""
        versionLabel.text = ""
    }
    
    // MARK: - IBActions
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueIdentifiers.singleMachineToSettings, sender: self)
    }
    
}

extension SingleMachineViewController: MachineMonitorDelegate {
    func machineSetupDataUpdated() {
        guard let machineMonitor = self.machineMonitor,
            let machine = machineMonitor.machine else { return }
        modelNameLabel.text = machine.modelName
        serialNumberLabel.text = machine.serialNumber
        ipAddressLabel.text = machine.ipAddress
        versionLabel.text = machine.bsVersion
    }
    
    
    func initialMachineDataReceived() {
        
    }

    func receivedMachineSetupData(with machine: Machine) {

    }
    
    func machineDataUpdated(modelName: String, serialNumber: String) {
        print("Model Name =", modelName, "Serial Number =", serialNumber)
    }
    
    func lostConnection() {
        
    }
    
}
