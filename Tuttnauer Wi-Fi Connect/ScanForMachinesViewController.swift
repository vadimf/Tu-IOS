//
//  ScanForMachinesViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/19/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import MBProgressHUD
import MMLanScan

class ScanForMachinesViewController: UIViewController {

    var machines = [Machine]()
    var initialDataReload: Bool = false
    
    var lanScanner: MMLANScanner!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var machinesFoundTitleLabel: UILabel!
    @IBOutlet weak var chooseMachinesTitleLabel: UILabel!
    @IBOutlet weak var machinesTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        lanScanner = MMLANScanner(delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidFinishFetchingSingleMachineDataNotificaiton), name: NotificationsIdentifiers.didFinishFetchingSingleMachineDataNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scanForMachines()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Methods
    
    private func setupLocalization() {
        machinesFoundTitleLabel.text = ""
        chooseMachinesTitleLabel.text = ""
    }
    
    private func resetResults() {
        machinesFoundTitleLabel.text = ""
        chooseMachinesTitleLabel.text = ""
        machines = [Machine]()
    }
    
    // MARK: - IBOutlets
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        resetResults()
        scanForMachines()
    }
    
}

// MARK: - Navigation

extension ScanForMachinesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

// MARK: - Notifications Handling

extension ScanForMachinesViewController {
    
    func handleDidFinishFetchingSingleMachineDataNotificaiton(notification: Notification) {
        machinesTableView.reloadData()
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
        guard let cell = tableView.cellForRow(at: indexPath) as? MachineTableViewCell else { return }
        cell.highlightCell()
    }
    
}

// MARK: - Scanning for machines (MMLanScan)

extension ScanForMachinesViewController: MMLANScannerDelegate {
    
    func lanScanDidFindNewDevice(_ device: MMDevice) {
        guard device.ipAddress == "192.168.1.147" else { return }
        // TODO: Add device to array
    }
    
    func lanScanDidFinishScanning(with status: MMLanScannerStatus) {

        MBProgressHUD.hide(for : self.view, animated: true)
        
        if machines.count == 0 {
            machinesFoundTitleLabel.text = LocalString.scanMachinesScreenFoundNoneMachinesTitle
        } else if machines.count == 1 {
            machinesFoundTitleLabel.text = LocalString.scanMachinesScreenFoundOneMachineTitle
            chooseMachinesTitleLabel.text = LocalString.scanMachinesScreenFoundOneMachineChooseTitle
        } else {
            machinesFoundTitleLabel.text = LocalString.scanMachinesScreenFoundMultipleMachinesTitle
            chooseMachinesTitleLabel.text = LocalString.scanMachinesScreenFoundMultipleMachinesChooseTitle
        }
        
        machinesTableView.reloadData()
    }
    
    func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int) {
        
    }
    
    func lanScanDidFailedToScan() {
        print("lanScanDidFailedToScan")
    }
    
    func scanForMachines() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        initialDataReload = true
        lanScanner.start()
    }
    
}
