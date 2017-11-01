//
//  SideMenuViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/25/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit
import SideMenu

struct MenuItem {
    let name: String
    let value: String
    let type: MenuItemType
    let enabled: Bool
}

struct MenuItemMachine {
    let name: String
    let ipAddress: String
    let enabled: Bool
}

enum MenuItemType {
    case machine
    case button
}

protocol SideMenuDelegate {
    func didChooseDifferentMachine(ipAddress: String)
}

class SideMenuViewController: UIViewController {

    var networkManager: NetworkManager?
    
    var delegate: SideMenuDelegate?
    
    var dataSource = [MenuItem]()
    var machines = [Machine]()
    let sideMenuItems = Enums.SideMenuItems.allValues
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManager.shared
        networkManager?.delegate = self
        
        if networkManager!.machines.isEmpty {
            networkManager?.scanForMachinesOnNetwork()
        }
        
        updateDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func disconnectButtonTapped(_ sender: UIButton) {
        MachineMonitor.shared.disconnect()
        NotificationCenter.default.post(name: NotificationsIdentifiers.machineDidDisconnectUserInitiated, object: nil)
    }

}

// MARK: - NetworkManager Delegate

extension SideMenuViewController: NetworkManagerDelegate {
    
    func didUpdateMachineList(list: [Machine]) {
        self.machines = list
        updateDataSource()
    }
    
}

// MARK: - Setup & Update Methods

extension SideMenuViewController {
    
    fileprivate func updateMachineList() {
        for machine in machines {
            dataSource.append(MenuItem(name: machine.modelName, value: machine.ipAddress, type: .machine, enabled: true))
        }
    }
    
    fileprivate func updateMenuItemsList() {
        for item in sideMenuItems {
            dataSource.append(MenuItem(name: item.getName, value: item.getValue, type: .button, enabled: item.isEnabled))
        }
    }
    
    fileprivate func updateDataSource() {

        if !dataSource.isEmpty {
            dataSource.removeAll()
        }
        
        if let networkManager = self.networkManager {
            machines = networkManager.machines
        }
        
        updateMachineList()
        updateMenuItemsList()
        
        itemsTableView.reloadData()
    }
    
}

// MARK: - Table View Data Source & Delegate

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = dataSource[indexPath.row]
        
        if item.type == .machine {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.sideMenuIconCell) as! SideMenuIconTableViewCell
            
            cell.titleLabel.text = item.name
            cell.subtitleLabel.text = item.value
            
            if !item.enabled {
                cell.titleLabel.textColor = UIColor.lightGray
                cell.selectionStyle = .none
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.sideMenuCell) as! SideMenuTableViewCell
        
        cell.titleLabel.text = item.name
        
        if !item.enabled {
            cell.titleLabel.textColor = UIColor.lightGray
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = dataSource[indexPath.row]
        
        guard item.enabled else { return }
        
        if item.type == .machine {
            let currentMachineIPAddress = MachineMonitor.shared.machine!.ipAddress
            if item.value == currentMachineIPAddress {
                dismiss(animated: true, completion: nil)
            } else {
                delegate?.didChooseDifferentMachine(ipAddress: item.value)
                dismiss(animated: true, completion: nil)
            }
        }
        
        UIApplication.shared.open(URL(string: item.value)!, options: [:], completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = dataSource[indexPath.row]
        
        if item.type == .machine {
            return 60
        }
        
        return 44
    }
    
}
