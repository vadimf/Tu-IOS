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
    let type: Int
}

class SideMenuViewController: UIViewController {

    var dataSource = [MenuItem]()
    
    var machines: [[String: String]]?
    let sideMenuItems = Enums.SideMenuItems.allValues
    
    let typeMachine = 0
    let typeMenuitem = 1
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        machines = [
            [
                "name": MachineMonitor.shared.machine!.modelName,
                "ipAddress": MachineMonitor.shared.machine!.ipAddress
            ]
        ]
        
        for machine in machines! {
            dataSource.append(MenuItem(name: machine["name"]!, value: machine["ipAddress"]!, type: typeMachine))
        }
        
        for item in sideMenuItems {
            dataSource.append(MenuItem(name: item.getName, value: "", type: typeMenuitem))
        }
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
        
        if item.type == typeMachine {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.sideMenuIconCell) as! SideMenuIconTableViewCell
            
            cell.titleLabel.text = item.name
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.sideMenuCell) as! SideMenuTableViewCell
        
        cell.titleLabel.text = item.name
        
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
