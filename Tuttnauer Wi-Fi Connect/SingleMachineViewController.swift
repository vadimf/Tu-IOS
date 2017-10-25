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
    
    @IBOutlet weak var currentCycleNameLabel: UILabel!
    @IBOutlet weak var currentCycleIndicator: UIActivityIndicatorView!
    @IBOutlet weak var currentCycleStageNameLabel: UILabel!
    @IBOutlet weak var currentCycleSubStageNameLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temp1Label: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var systemStatusLabel: UILabel!
    @IBOutlet weak var doorStateLabel: UILabel!
    @IBOutlet weak var cycleErrorLabel: UILabel!
    
    @IBOutlet weak var cycleParameterSterTempLabel: UILabel!
    @IBOutlet weak var cycleParameterSterTimeLabel: UILabel!
    @IBOutlet weak var cycleParameterDryTimeLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        resetLabelsValues()
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
        
    }
    
    private func resetLabelsValues() {
        modelNameLabel.text = ""
        serialNumberLabel.text = ""
        ipAddressLabel.text = ""
        versionLabel.text = ""
        
        currentCycleNameLabel.text = ""
        currentCycleStageNameLabel.text = ""
        currentCycleSubStageNameLabel.text = ""
        
        temperatureLabel.text = "-"
        temp1Label.text = "-"
        pressureLabel.text = "-"
        
        systemStatusLabel.text = "-"
        doorStateLabel.text = "-"
        cycleErrorLabel.text = "-"
        
        cycleParameterSterTempLabel.text = "-"
        cycleParameterSterTimeLabel.text = "-"
        cycleParameterDryTimeLabel.text = "-"
    }
    
    // MARK: - IBActions
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueIdentifiers.singleMachineToSettings, sender: self)
    }
    
}

// MARK: - Machine Monitor Delegate

extension SingleMachineViewController: MachineMonitorDelegate {
    
    func machineSetupDataUpdated() {
        guard let machineMonitor = self.machineMonitor,
            let machine = machineMonitor.machine else { return }
        modelNameLabel.text = machine.modelName
        serialNumberLabel.text = machine.serialNumber
        ipAddressLabel.text = machine.ipAddress
        versionLabel.text = machine.bsVersion
    }
    
    func machineRealTimeDataUpdated() {
        guard let machineMonitor = self.machineMonitor,
            let machineRealTime = machineMonitor.machineRealTime else { return }
        
        systemStatusLabel.text = machineRealTime.systemStatus?.getName
        currentCycleNameLabel.text = machineRealTime.cycleName?.getName
        currentCycleStageNameLabel.text = machineRealTime.cycleStage?.getName
        currentCycleSubStageNameLabel.text = machineRealTime.cycleSubStage?.getName
        cycleErrorLabel.text = machineRealTime.cycleError?.getName
        
        doorStateLabel.text = machineRealTime.doorState?.getName
        temperatureLabel.text = "\(machineRealTime.analogInput1IOMapping)"
        
        if machineRealTime.systemStatus! != .none {
            currentCycleIndicator.startAnimating()
        } else {
            currentCycleIndicator.stopAnimating()
        }
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
