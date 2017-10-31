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
        if initialDataReload {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            initialDataReload = false
        }
        networkManager?.scanForMachinesOnNetwork()
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
        initialDataReload = true
    }
    
    // MARK: - IBOutlets
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        resetResults()
        networkManager?.scanForMachinesOnNetwork()
    }
    
}

// MARK: - Navigation

extension ScanForMachinesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
