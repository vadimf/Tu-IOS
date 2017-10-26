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
        //ipAddressTextField.text = "192.168.1.147" // Work IP - For dev purpose only
        //ipAddressTextField.text = "10.0.0.44" // Home IP - For dev purpose only
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

// MARK: - Navigation

extension MainConnectViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIdentifiers.mainConnectToSingleMachine {
            guard let _ = segue.destination as? SingleMachineViewController else { return }
            
        }
        
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
            MachineMonitor.shared.connect(to: ipAddress) { (success, error) in
                
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
            // Just temporary until I fix the machine discovery feature
            guard let lastMachineIP = UserSettingsManager.shared.userSettings.lastMachineIPAddress, !lastMachineIP.isEmpty else { return }
            connect(to: lastMachineIP, loaderMessage: "Connecting: \(lastMachineIP)")
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
