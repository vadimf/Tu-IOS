//
//  MainConnectViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import MBProgressHUD

class MainConnectViewController: UIViewController {

    var previouslyConnected: Bool = false
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var ipAddressTextField: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let _ = NetworkManager.shared
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        autoConnectIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func connectButtonTapped(_ sender: UIButton) {
        guard let ipAddress = ipAddressTextField.text, !ipAddress.isEmpty else {
            ipAddressTextField.shakeView()
            return
        }
        connect(to: ipAddress)
    }
    
}

// MARK: - Modbus connection & data fetch

extension MainConnectViewController {
    
    func connect(to ipAddress: String, loaderMessage: String = "Connecting...") {
        
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = loaderMessage
        
        // It's connecting to the machine too fast XD
        // We'll dispatch this call after 2 seconds just so the user can experience the awesome MBProgressHUD
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            MachineMonitoring.shared.createConnection(to: ipAddress) { (success, error) in
                
                MBProgressHUD.hide(for: self.view, animated: false)
                
                guard error == nil else {
                    Alerts.alertMessage(for: self, title: "Connection Failed", message: "Could not connect to \(ipAddress)", closeHandler: nil)
                    return
                }
                
                self.previouslyConnected = true
                UserSettingsManager.shared.setUserLastMachineIPAddress(to: ipAddress)
                
                self.performSegue(withIdentifier: SegueIdentifiers.mainConnectToSingleMachine, sender: self)
                
            }
        }
    }
    
    func autoConnectIfNeeded() {
        
        guard !previouslyConnected else { return }
        guard let autoConnectSettings = Defaults[.userConnectionType] else { return }
        
        let types = Enums.ConnectionType.self
        
        switch autoConnectSettings {
        case types.autoConnectOnStart.rawValue:
            NetworkManager.shared.scanForMachinesOnNetwork()
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = "Searching..."
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                MBProgressHUD.hide(for: self.view, animated: false)
                if let machine = NetworkManager.shared.machines.first {
                    self.connect(to: machine.ipAddress, loaderMessage: "Connecting: \(machine.ipAddress)")
                }
            })
            return
        case types.connectToLastMachine.rawValue:
            guard let lastMachineIP = UserSettingsManager.shared.userSettings.lastMachineIPAddress, !lastMachineIP.isEmpty else { return }
            connect(to: lastMachineIP, loaderMessage: "Connecting: \(lastMachineIP)")
        case types.manualConnect.rawValue:
            return
        default:
            return
        }
    }
    
}
