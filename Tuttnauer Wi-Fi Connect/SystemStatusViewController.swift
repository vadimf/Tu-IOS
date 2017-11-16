//
//  SystemStatusViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 11/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class SystemStatusViewController: UIViewController {

    var statuses = [String]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var popupContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        popupContainerView.layer.shadowColor = UIColor.black.cgColor
        popupContainerView.layer.shadowOpacity = 0.3
        popupContainerView.layer.shadowOffset = CGSize.zero
        popupContainerView.layer.shadowRadius = 10
        popupContainerView.layer.shadowPath = UIBezierPath(rect: popupContainerView.bounds).cgPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Update Methods
    
    func updateStatuses(with statuses:[String]) {
        self.statuses = statuses
        tableView.reloadData()
    }

    // MARK: - IBActions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table View Data Source & Delegate

extension SystemStatusViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.systemStatusErrorCell, for: indexPath)
        
        cell.textLabel?.text = statuses[indexPath.row]
        
        return cell
    }
    
}
