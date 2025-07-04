//
//  SingleMachineViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import SideMenu
import MBProgressHUD
import SwiftGifOrigin

class SingleMachineViewController: UIViewController {
    
    var monitor: MachineMonitoring?
    var systemStatusPopup: SystemStatusViewController?
    var cycleIndicator: UIImageView!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var modelNameTitleLabel: UILabel!
    @IBOutlet weak var serialNumberTitleLabel: UILabel!
    @IBOutlet weak var ipAddressTitleLabel: UILabel!
    @IBOutlet weak var versionTitleLabel: UILabel!
    
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var currentCycleNameTitleLabel: UILabel!
    @IBOutlet weak var currentStageTitleLabel: UILabel!
    
    @IBOutlet weak var currentCycleNameLabel: UILabel!
    @IBOutlet weak var currentCycleIndicatorView: UIView!
    @IBOutlet weak var currentCycleIconImageView: UIImageView!
    @IBOutlet weak var currentCycleStageNameLabel: UILabel!
    @IBOutlet weak var currentCycleSubStageNameLabel: UILabel!
    @IBOutlet weak var currentCycleStageTimerLabel: UILabel!
    
    @IBOutlet weak var sensor1TitleLabel: UILabel!
    @IBOutlet weak var sensor2TitleLabel: UILabel!
    @IBOutlet weak var sensor3TitleLabel: UILabel!
    
    @IBOutlet weak var sensor1ValueLabel: UILabel!
    @IBOutlet weak var sensor2ValueLabel: UILabel!
    @IBOutlet weak var sensor3ValueLabel: UILabel!
    
    @IBOutlet weak var systemStatusTitleLabel: UILabel!
    @IBOutlet weak var doorStateTitleLabel: UILabel!
    @IBOutlet weak var cycleErrorTitleLabel: UILabel!
    
    @IBOutlet weak var systemStatusButton: UIButton!
    @IBOutlet weak var doorStateLabel: UILabel!
    @IBOutlet weak var cycleErrorLabel: UILabel!
    
    @IBOutlet weak var parametersTitleLabel: UILabel!
    
    @IBOutlet weak var parameter1TitleLabel: UILabel!
    @IBOutlet weak var parameter2TitleLabel: UILabel!
    @IBOutlet weak var parameter3TitleLabel: UILabel!
    
    @IBOutlet weak var parameter1ValueLabel: UILabel!
    @IBOutlet weak var parameter2ValueLabel: UILabel!
    @IBOutlet weak var parameter3ValueLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gifIndicator = UIImageView()
        gifIndicator.contentMode = .scaleAspectFit
        gifIndicator.loadGif(name: "gif-load")
        gifIndicator.translatesAutoresizingMaskIntoConstraints = false
        cycleIndicator = gifIndicator
        cycleIndicator.isHidden = true
        
        registerNotifications()
        setupSideMenu()
        setupLocalization()
        resetOneTimeLabelValues()
        resetOccurrentLabelValues()
        
        NotificationsManager.shared.registerForNotifications()
        
        monitor = MachineMonitoring.shared
        monitor?.delegate = self
        monitor?.startMonitoringAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCycleIndicator()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        deRegisterNotifications()
    }
    
    // MARK: - Setup Methods
    
    private func setupCycleIndicator() {
        cycleIndicator.frame = currentCycleIndicatorView.frame
        currentCycleIndicatorView.addSubview(cycleIndicator)
        cycleIndicator.topAnchor.constraint(equalTo: currentCycleIndicatorView.topAnchor).isActive = true
        cycleIndicator.rightAnchor.constraint(equalTo: currentCycleIndicatorView.rightAnchor).isActive = true
        cycleIndicator.leftAnchor.constraint(equalTo: currentCycleIndicatorView.leftAnchor).isActive = true
        cycleIndicator.bottomAnchor.constraint(equalTo: currentCycleIndicatorView.bottomAnchor).isActive = true
        currentCycleIndicatorView.bringSubview(toFront: cycleIndicator)
    }
    
    fileprivate func setupLocalization() {
        modelNameTitleLabel.text = LocalString.singleMachineScreenModelNameTitle
        serialNumberTitleLabel.text = LocalString.singleMachineScreenSerialNumberTitle
        ipAddressTitleLabel.text = LocalString.singleMachineScreenIPAddressTitle
        versionTitleLabel.text = LocalString.singleMachineScreenVersionTitle
        
        currentCycleNameTitleLabel.text = LocalString.singleMachineScreenCurrentCycleNameTitle
        currentStageTitleLabel.text = LocalString.singleMachineScreenCurrentStageTitle
        
        parametersTitleLabel.text = LocalString.singleMachineScreenParametersTitle
        
        systemStatusTitleLabel.text = LocalString.singleMachineScreenSystemStatusTitle
        doorStateTitleLabel.text = LocalString.singleMachineScreenDoorStateTitle
    }
    
    fileprivate func resetOneTimeLabelValues() {
        
        modelNameLabel.text = ""
        serialNumberLabel.text = ""
        ipAddressLabel.text = ""
        versionLabel.text = ""
        
        currentStageTitleLabel.text = ""
        currentCycleStageTimerLabel.text = ""
        
        currentCycleNameLabel.text = ""
        currentCycleIconImageView.isHidden = true
        currentCycleStageNameLabel.text = ""
        currentCycleSubStageNameLabel.text = ""
        
        cycleErrorTitleLabel.text = ""
        
        systemStatusButton.setTitle("-", for: .normal)
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
    
    fileprivate func setupSideMenu() {
        let menuManager = SideMenuManager.default
        menuManager.menuPresentMode = .menuSlideIn
        menuManager.menuFadeStatusBar = false
        if let menuVC = menuManager.menuLeftNavigationController?.viewControllers.first as? SideMenuViewController {
            menuVC.delegate = self
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueIdentifiers.singleMachineToSettings, sender: self)
    }
    
    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func systemStatusButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifiers.singleMachineToSystemStatusPopup, sender: self)
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
    
    func handleMachineDidDisconnectUserInitiated(notification: Notification) {
        // User disconnected from the machine on purpose
        guard let monitor = self.monitor,
            let currentConnection = monitor.currentConnection else { return }
        
        monitor.disconnect(from: currentConnection)
        
        if monitor.connections.count > 0 {
            // Switch to another connected machine (the first in the connections array)
            guard let connection = monitor.connections.first else { return }
            monitor.switchCurrentConnection(to: connection)
        } else {
            // Go back to the login screen
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func handleMachineDidDisconnect(notification: Notification) {
        // Disconnected from the machine for unknown reasons
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Navigation

extension SingleMachineViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIdentifiers.singleMachineToSideMenu {
            
            guard let vc = segue.destination as? UISideMenuNavigationController,
                let sideMenuVC = vc.viewControllers.first as? SideMenuViewController else { return }
            
            sideMenuVC.delegate = self
            
        } else if segue.identifier == SegueIdentifiers.singleMachineToSystemStatusPopup {
            
            guard let vc = segue.destination as? SystemStatusViewController,
                let machine = self.monitor?.currentConnection?.machine else { return }
            
            vc.statuses = machine.realTime.backgroundStatus
            systemStatusPopup = vc
            
        }
        
    }
    
}

// MARK: - Side Menu Delegate

extension SingleMachineViewController: SideMenuDelegate {
    
    func didChooseDifferentMachine(ipAddress: String) {
        
        guard let monitor = self.monitor else { return }
        
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = String(format: LocalString.progressHUDConnectingTo, ipAddress)
        
        monitor.createConnection(to: ipAddress) { (success, error) in
            
            guard error == nil else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Could not connect:", error!.localizedDescription)
                return
            }
            
            UserSettingsManager.shared.setUserLastMachineIPAddress(to: ipAddress)
            
            self.setupLocalization()
            self.resetOneTimeLabelValues()
            self.resetOccurrentLabelValues()
            if let machine = MachineMonitoring.shared.currentConnection?.machine {
                self.updateSetupData(with: machine)
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}

// MARK: - New Machine Monitoring Delegate

extension SingleMachineViewController: MachineMonitoringDelegate {
    
    func didConnect(to connection: MachineConnection, success: Bool) {
        
    }
    
    func didDisconnect(from connection: MachineConnection) {
        dismiss(animated: true, completion: nil)
    }
    
    func didLoseConnection(to connection: MachineConnection) {
        Alerts.alertMessageWithActions(for: self, title: LocalString.alertDialogConnectionLostTitle, message: String(format: LocalString.alertDialogConnectionLostMesssage, connection.machine!.modelName), doneButtonTitle: LocalString.alertDialogButtonConnect, cancelButtonTitle: LocalString.alertDialogButtonDisconnect, doneHandler: {
            self.monitor?.reconnect(to: connection)
        }) {
            self.monitor?.disconnect(from: connection)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func didChangeConnection(to connection: MachineConnection) {
        
    }
    
    func didUpdateSetupData(for machine: Machine) {
        updateSetupData(with: machine)
    }
    
    func didUpdateRealTimeData(for machine: Machine) {
        updateRealTimeData(with: machine)
        updateSensorsData(with: machine)
        updateCycleInfoData(with: machine)
        updateParametersData(with: machine)
    }
    
    // MARK: UI Update Methods
    
    fileprivate func updateSetupData(with machine: Machine) {
        modelNameLabel.text = machine.modelName
        serialNumberLabel.text = machine.serialNumber
        ipAddressLabel.text = machine.ipAddress
        versionLabel.text = machine.bsVersion
    }
    
    private func updateRealTimeData(with machine: Machine) {
        
        guard let currentCycleStage = machine.realTime.cycleStage?.getName,
            let cycleError = machine.realTime.cycleError?.getName else { return }
        
        let currentCycleStageTimerIsOn = machine.realTime.cycleStageTimerIsOn
        
        systemStatusButton.setTitle(machine.realTime.systemStatus?.getName, for: .normal)
        currentCycleIconImageView.image = machine.realTime.cycleIcon
        
        if let systemStatusPopup = self.systemStatusPopup {
            let currentStatus = machine.realTime.backgroundStatus
            if !currentStatus.containsSameElements(as: systemStatusPopup.statuses) {
                systemStatusPopup.updateStatuses(with: currentStatus)
            }
        }
        
        if currentCycleStage.isEmpty {
            currentStageTitleLabel.text = ""
            currentCycleStageNameLabel.text = ""
        } else {
            currentStageTitleLabel.text = LocalString.singleMachineScreenCurrentStageTitle
            if let currentCycleSubStage = machine.realTime.cycleSubStage?.getName,
                !currentCycleSubStage.isEmpty {
                currentCycleStageNameLabel.text = currentCycleSubStage
            } else {
                currentCycleStageNameLabel.text = machine.realTime.cycleStage?.getName
            }
            
        }
        
        if cycleError.isEmpty  {
            cycleErrorTitleLabel.text = ""
            cycleErrorLabel.text = ""
        } else {
            cycleErrorTitleLabel.text = LocalString.singleMachineScreenCycleErrorTitle
            cycleErrorLabel.text = cycleError
        }
        
        doorStateLabel.text = machine.realTime.doorState?.getName
        
        if let cycleName = machine.realTime.cycleID, cycleName == .none {
            currentCycleIconImageView.isHidden = true
        } else {
            currentCycleIconImageView.isHidden = false
        }
        
        // MARK: Timer & Cycle indicator animation
        
        if currentCycleStageTimerIsOn {
            currentCycleStageTimerLabel.text = machine.realTime.cycleStageTimer
            currentCycleStageTimerLabel.isHidden = false
        } else {
            currentCycleStageTimerLabel.text = ""
            currentCycleStageTimerLabel.isHidden = true
        }
        
        if let systemStatus = machine.realTime.systemStatus,
            systemStatus != .none && systemStatus != .notReady && systemStatus != .cycleDone,
            !currentCycleStageTimerIsOn, machine.realTime.cycleStage != .done {
            cycleIndicator.isHidden = false
        } else {
            cycleIndicator.isHidden = true
        }
    }
    
    private func updateSensorsData(with machine: Machine) {
        
        if let sensor1 = machine.realTime.sensor1 {
            sensor1TitleLabel.text = sensor1.name
            sensor1ValueLabel.text = sensor1.getFormattedUnit()
        } else {
            sensor1TitleLabel.text = ""
            sensor1ValueLabel.text = ""
        }
        
        if let sensor2 = machine.realTime.sensor2 {
            sensor2TitleLabel.text = sensor2.name
            sensor2ValueLabel.text = sensor2.getFormattedUnit()
        } else {
            sensor2TitleLabel.text = ""
            sensor2ValueLabel.text = ""
        }
        
        if let sensor3 = machine.realTime.sensor3 {
            sensor3TitleLabel.text = sensor3.name
            sensor3ValueLabel.text = sensor3.getFormattedUnit()
        } else {
            sensor3TitleLabel.text = ""
            sensor3ValueLabel.text = ""
        }
    }
    
    private func updateCycleInfoData(with machine: Machine) {
        if let cycleName = machine.realTime.cycleName {
            currentCycleNameLabel.text = cycleName
        } else {
            currentCycleNameLabel.text = ""
        }
    }
    
    private func updateParametersData(with machine: Machine) {
        if let parameter1 = machine.realTime.parameter1 {
            parameter1TitleLabel.text = parameter1.name
            parameter1ValueLabel.text = parameter1.getFormattedUnit()
        } else {
            parameter1TitleLabel.text = ""
            parameter1ValueLabel.text = ""
        }
        
        if let parameter2 = machine.realTime.parameter2 {
            parameter2TitleLabel.text = parameter2.name
            parameter2ValueLabel.text = parameter2.getFormattedUnit()
        } else {
            parameter2TitleLabel.text = ""
            parameter2ValueLabel.text = ""
        }
        
        if let parameter3 = machine.realTime.parameter3 {
            parameter3TitleLabel.text = parameter3.name
            parameter3ValueLabel.text = parameter3.getFormattedUnit()
        } else {
            parameter3TitleLabel.text = ""
            parameter3ValueLabel.text = ""
        }
    }
    
}
