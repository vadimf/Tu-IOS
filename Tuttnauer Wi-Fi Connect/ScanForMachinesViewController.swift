//
//  ScanForMachinesViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/19/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import MBProgressHUD

class ScanForMachinesViewController: UIViewController {
    
    var machines = [Machine]() {
        didSet {
            machinesTableView.reloadData()
        }
    }
    
    var initialDataReload: Bool = true
    var selectedCellIndexPath: IndexPath?
    
    var networkManager: NetworkManager?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var machinesFoundTitleLabel: UILabel!
    @IBOutlet weak var chooseMachinesTitleLabel: UILabel!
    @IBOutlet weak var machinesTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        networkManager = NetworkManager.shared
        networkManager?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedCellIndexPath = self.selectedCellIndexPath,
            let selectedCell = machinesTableView.cellForRow(at: selectedCellIndexPath) as? MachineTableViewCell {
            selectedCell.unHighlightCell()
        }
        
        networkManager?.delegate = self
        reloadButtonTapped(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Methods
    
    private func setupLocalization() {
        title = LocalString.scanMachinesScreenTitle
        machinesFoundTitleLabel.text = ""
        chooseMachinesTitleLabel.text = ""
    }
    
    private func resetResults() {
        machinesFoundTitleLabel.text = ""
        chooseMachinesTitleLabel.text = ""
        machines = [Machine]()
        initialDataReload = true
    }
    
    // MARK: - IBOutlets
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        resetResults()
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = LocalString.progressHUDSearching
        networkManager?.scanForMachinesOnNetwork()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10, execute: {
            MBProgressHUD.hide(for: self.view, animated: true)
            if self.machines.isEmpty {
                self.didUpdateMachineList(list: [])
            }
        })
    }
    
}

// MARK: - TableView Data Source & Delegate

extension ScanForMachinesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return machines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.scanForMachinesTableViewCell) as! MachineTableViewCell
        
        cell.machine = machines[indexPath.row]
        
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedCellIndexPath = self.selectedCellIndexPath,
            let selectedCell = tableView.cellForRow(at: selectedCellIndexPath) as? MachineTableViewCell {
            selectedCell.unHighlightCell()
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MachineTableViewCell else { return }
        cell.highlightCell()
        selectedCellIndexPath = indexPath
        
        let machine = machines[indexPath.row]
        
        connect(to: machine.ipAddress)
    }
    
}

// MARK: - NetworkManager Delegate

extension ScanForMachinesViewController: NetworkManagerDelegate {
    
    func didUpdateMachineList(list: [Machine]) {
        
        MBProgressHUD.hide(for: self.view, animated: true)
        
        if list.count == 0 {
            machinesFoundTitleLabel.text = LocalString.scanMachinesScreenFoundNoneMachinesTitle
        } else if list.count == 1 {
            machinesFoundTitleLabel.text = LocalString.scanMachinesScreenFoundOneMachineTitle
            chooseMachinesTitleLabel.text = LocalString.scanMachinesScreenFoundOneMachineChooseTitle
        } else {
            machinesFoundTitleLabel.text = LocalString.scanMachinesScreenFoundMultipleMachinesTitle
            chooseMachinesTitleLabel.text = LocalString.scanMachinesScreenFoundMultipleMachinesChooseTitle
        }
        
        self.machines = list
    }
    
}

// MARK: - Connections

extension ScanForMachinesViewController {
    
    fileprivate func connect(to ipAddress: String, loaderMessage: String = LocalString.progressHUDSearching) {
        
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = loaderMessage
        
        // It's connecting to the machine too fast XD
        // We'll dispatch this call after 2 seconds just so the user can experience the awesome MBProgressHUD
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            
            MachineMonitoring.shared.createConnection(to: ipAddress, completion: { (success, error) in
                
                MBProgressHUD.hide(for: self.view, animated: false)
                
                guard error == nil else {
                     Alerts.alertMessage(for: self, title: LocalString.alertDialogConnectionFailedTitle, message: String(format: LocalString.alertDialogConnectionLostTitle, ipAddress), closeHandler: nil)
                    return
                }
                
                UserSettingsManager.shared.setUserLastMachineIPAddress(to: ipAddress)
                
                self.performSegue(withIdentifier: SegueIdentifiers.scanMachinesToSinleMachine, sender: self)
                
            })
        }
    }
    
}
