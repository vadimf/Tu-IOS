//
//  MainConnectViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainConnectViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var ipAddressTextField: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        ipAddressTextField.text = "192.168.1.147" // Work IP - For dev purpose only
        //ipAddressTextField.text = "10.0.0.44" // Home IP - For dev purpose only
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func connectButtonTapped(_ sender: UIButton) {
        guard let ipAddress = ipAddressTextField.text, !ipAddress.isEmpty else { return }
        connect(to: ipAddress)
    }
    
}

extension MainConnectViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIdentifiers.mainConnectToSingleMachine {
            guard let _ = segue.destination as? SingleMachineViewController else { return }
            
        }
        
    }
    
}

// MARK: - Modbus connection & data fetch

extension MainConnectViewController {
    
    func connect(to ipAddress: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        MachineMonitor.shared.connect(to: ipAddress) { (success, error) in
            
            MBProgressHUD.hide(for: self.view, animated: false)
            
            guard error == nil, success else {
                Alerts.alertMessage(for: self, title: "Connection Failed", message: "Could not connect to \(ipAddress)", closeHandler: nil)
                return
            }
            
            self.performSegue(withIdentifier: SegueIdentifiers.mainConnectToSingleMachine, sender: self)
            
        }
    }
    
}
