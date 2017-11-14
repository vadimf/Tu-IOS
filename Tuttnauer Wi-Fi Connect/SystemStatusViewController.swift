//
//  SystemStatusViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 11/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class SystemStatusViewController: UIViewController {

    var errors = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var popupContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errors = ["Analog input error", "Chamber pressure not in range"]
        popupContainerView.layer.shadowColor = UIColor.black.cgColor
        popupContainerView.layer.shadowOpacity = 0.2
        popupContainerView.layer.shadowOffset = CGSize.zero
        popupContainerView.layer.shadowRadius = 10
        popupContainerView.layer.shadowPath = UIBezierPath(rect: popupContainerView.bounds).cgPath
        popupContainerView.layer.shouldRasterize = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        return errors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.systemStatusErrorCell, for: indexPath)
        
        cell.textLabel?.text = errors[indexPath.row]
        
        return cell
    }
    
}
