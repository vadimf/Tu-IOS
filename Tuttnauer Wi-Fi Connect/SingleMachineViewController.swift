//
//  SingleMachineViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import SideMenu

class SingleMachineViewController: UIViewController {

    var machineMonitor: MachineMonitor?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var currentCycleNameLabel: UILabel!
    @IBOutlet weak var currentCycleIndicator: UIActivityIndicatorView!
    @IBOutlet weak var currentCycleIconImageView: UIImageView!
    @IBOutlet weak var currentCycleStageNameLabel: UILabel!
    @IBOutlet weak var currentCycleSubStageNameLabel: UILabel!
    
    @IBOutlet weak var sensor1TitleLabel: UILabel!
    @IBOutlet weak var sensor2TitleLabel: UILabel!
    @IBOutlet weak var sensor3TitleLabel: UILabel!
    
    @IBOutlet weak var sensor1ValueLabel: UILabel!
    @IBOutlet weak var sensor2ValueLabel: UILabel!
    @IBOutlet weak var sensor3ValueLabel: UILabel!
    
    @IBOutlet weak var systemStatusLabel: UILabel!
    @IBOutlet weak var doorStateLabel: UILabel!
    @IBOutlet weak var cycleErrorLabel: UILabel!
    
    @IBOutlet weak var parameter1TitleLabel: UILabel!
    @IBOutlet weak var parameter2TitleLabel: UILabel!
    @IBOutlet weak var parameter3TitleLabel: UILabel!
    
    @IBOutlet weak var parameter1ValueLabel: UILabel!
    @IBOutlet weak var parameter2ValueLabel: UILabel!
    @IBOutlet weak var parameter3ValueLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotifications()
        setupSideMenu()
        setupLocalization()
        resetOneTimeLabelValues()
        resetOccurrentLabelValues()
        
        machineMonitor = MachineMonitor.shared // Singleton Class
        machineMonitor?.delegate = self
        machineMonitor?.getMachineSetupData() // Request the initial machine object with data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        deRegisterNotifications()
    }
    
    // MARK: - Setup Methods
    
    private func setupLocalization() {
        
    }
    
    private func resetOneTimeLabelValues() {
        
        modelNameLabel.text = ""
        serialNumberLabel.text = ""
        ipAddressLabel.text = ""
        versionLabel.text = ""
        
        currentCycleNameLabel.text = ""
        currentCycleIconImageView.isHidden = true
        currentCycleStageNameLabel.text = ""
        currentCycleSubStageNameLabel.text = ""
        
        systemStatusLabel.text = "-"
        doorStateLabel.text = "-"
        cycleErrorLabel.text = "-"
    }
    
    fileprivate func resetOccurrentLabelValues() {
        
        sensor1TitleLabel.text = ""
        sensor2TitleLabel.text = ""
        sensor3TitleLabel.text = ""
        
        sensor1ValueLabel.text = ""
        sensor2ValueLabel.text = ""
        sensor3ValueLabel.text = ""
        
        parameter1TitleLabel.text = ""
        parameter2TitleLabel.text = ""
        parameter3TitleLabel.text = ""
        
        parameter1ValueLabel.text = "-"
        parameter2ValueLabel.text = "-"
        parameter3ValueLabel.text = "-"
    }
    
    private func setupSideMenu() {
        let menuManager = SideMenuManager.default
        menuManager.menuPresentMode = .menuSlideIn
        menuManager.menuFadeStatusBar = false
    }
    
    // MARK: - IBActions
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueIdentifiers.singleMachineToSettings, sender: self)
    }
    
}

// MARK: - Notifications

extension SingleMachineViewController {
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMachineDidDisconnectUserInitiated), name: NotificationsIdentifiers.machineDidDisconnectUserInitiated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleMachineDidDisconnect), name: NotificationsIdentifiers.machineDidDisconnect, object: nil)
    }
    
    func deRegisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: NotificationsIdentifiers.machineDidDisconnectUserInitiated, object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationsIdentifiers.machineDidDisconnect, object: nil)
    }
    
    @objc func handleMachineDidDisconnectUserInitiated(notification: Notification) {
        // User disconnected from the machine on purpose
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleMachineDidDisconnect(notification: Notification) {
        // Disconnected from the machine for unknown reasons
        dismiss(animated: true, completion: nil)
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
        currentCycleIconImageView.image = machineRealTime.cycleName?.getIcon
        currentCycleStageNameLabel.text = machineRealTime.cycleStage?.getName
        currentCycleSubStageNameLabel.text = machineRealTime.cycleSubStage?.getName
        cycleErrorLabel.text = machineRealTime.cycleError?.getName
        
        doorStateLabel.text = machineRealTime.doorState?.getName
        
        if let cycleName = machineRealTime.cycleName, cycleName == .none {
            currentCycleIconImageView.isHidden = true
        } else {
            currentCycleIconImageView.isHidden = false
        }
        
        if let systemStatus = machineRealTime.systemStatus, systemStatus != .none {
            currentCycleIndicator.startAnimating()
        } else {
            currentCycleIndicator.stopAnimating()
        }
    }
    
    func machineSensorsDataUpdated() {
        guard let machineMonitor = self.machineMonitor,
            let machineRealTime = machineMonitor.machineRealTime else { return }
        
        if let sensor1 = machineRealTime.sensor1 {
            sensor1TitleLabel.text = sensor1.name
            sensor1ValueLabel.text = sensor1.getFormattedUnit()
        } else {
            sensor1TitleLabel.text = ""
            sensor1ValueLabel.text = ""
        }
        
        if let sensor2 = machineRealTime.sensor2 {
            sensor2TitleLabel.text = sensor2.name
            sensor2ValueLabel.text = sensor2.getFormattedUnit()
        } else {
            sensor2TitleLabel.text = ""
            sensor2ValueLabel.text = ""
        }
        
        if let sensor3 = machineRealTime.sensor3 {
            sensor3TitleLabel.text = sensor3.name
            sensor3ValueLabel.text = sensor3.getFormattedUnit()
        } else {
            sensor2TitleLabel.text = ""
            sensor2ValueLabel.text = ""
        }
    }
    
    func machineParametersDataUpdated() {
        guard let machineMonitor = self.machineMonitor,
            let machineRealTime = machineMonitor.machineRealTime else { return }
        
        // TODO: Update the parameters UI components
        
        if let parameter1 = machineRealTime.parameter1 {
            parameter1TitleLabel.text = parameter1.name
            parameter1ValueLabel.text = "\(parameter1.value)"
        } else {
            parameter1TitleLabel.text = ""
            parameter1ValueLabel.text = ""
        }
        
        if let parameter2 = machineRealTime.parameter2 {
            parameter2TitleLabel.text = parameter2.name
            parameter2ValueLabel.text = "\(parameter2.value)"
        } else {
            parameter2TitleLabel.text = ""
            parameter2ValueLabel.text = ""
        }
        
        if let parameter3 = machineRealTime.parameter3 {
            parameter3TitleLabel.text = parameter3.name
            parameter3ValueLabel.text = "\(parameter3.value)"
        } else {
            parameter3TitleLabel.text = ""
            parameter3ValueLabel.text = ""
        }
    }
    
    func didDisconnectFromMachine() {
        dismiss(animated: true, completion: nil)
    }
    
    func connectionLost() {
        Alerts.alertMessageWithActions(for: self, title: "Connection Lost", message: "The machine is not responding. What do you want to do?", doneButtonTitle: "Reconnect", cancelButtonTitle: "Disconnect", doneHandler: {
            self.reconnect()
        }) {
            self.machineMonitor?.disconnect()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Non-Delegate Methods
    
    private func reconnect() {
        self.machineMonitor?.reconnect(completion: { (success, error) in
            
            guard error == nil, success else {
                self.connectionLost()
                return
            }
            
            self.machineMonitor?.getMachineSetupData()
            self.machineMonitor?.startMonitoring()
        })
    }
    
}
