//
//  SettingsOptionsTableViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

struct SettingsOption {
    let name: String
    let value: Int
    let isSelected: Bool
}

protocol SettingsOptionsTableViewControllerDelegate {
    func didSelect(option: SettingsOption)
}

class SettingsOptionsTableViewController: UITableViewController {

    var delegate: SettingsOptionsTableViewControllerDelegate?
    
    var optionsType: Enums.SettingsOptions!
    
    var options = [SettingsOption]()
    
    var selectedCellIndexPath: IndexPath?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = true
        getOptionsFromEnum()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Methods
    
    private func getOptionsFromEnum() {
        switch optionsType {
        case .temperatureUnit:
            populateTemperatureOptions()
        case .pressureUnit:
            populatePressureOptions()
        case .language:
            populateLanguageOptions()
        case .connectionType:
            populateChooseConnectionOptions()
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    private func populateTemperatureOptions() {
        for item in Enums.TemperatureUnit.allValues {
            let selected = UserSettingsManager.shared.userSettings!.temperatureUnit == item
            let option = SettingsOption(name: item.getFullName, value: item.rawValue, isSelected: selected)
            options.append(option)
        }
    }
    
    private func populatePressureOptions() {
        for item in Enums.PressureUnit.allValues {
            let selected = UserSettingsManager.shared.userSettings!.pressureUnit == item
            let option = SettingsOption(name: item.getName, value: item.rawValue, isSelected: selected)
            options.append(option)
        }
    }
    
    private func populateLanguageOptions() {
        for item in Enums.Language.allValues {
            let selected = UserSettingsManager.shared.userSettings!.language == item
            let option = SettingsOption(name: item.getName, value: item.rawValue, isSelected: selected)
            options.append(option)
        }
    }
    
    private func populateChooseConnectionOptions() {
        for item in Enums.ConnectionType.allValues {
            let selected = UserSettingsManager.shared.userSettings!.connectionType == item
            let option = SettingsOption(name: item.getName, value: item.rawValue, isSelected: selected)
            options.append(option)
        }
    }
    
}

// MARK: - Table View Data Source & Delegate

extension SettingsOptionsTableViewController {
    
    // MARK: Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.settingsOptionTableViewCell)!
        
        let option = options[indexPath.row]
        
        cell.textLabel?.text = option.name
        
        if option.isSelected {
            selectedCellIndexPath = indexPath
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 || indexPath.section == 2 { return }
        
        guard let checkedCell = tableView.cellForRow(at: selectedCellIndexPath!),
            let currentCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let selectedOption = options[indexPath.row]
        
        checkedCell.accessoryType = .none
        currentCell.accessoryType = .checkmark
        
        delegate?.didSelect(option: selectedOption)
        
        navigationController?.popViewController(animated: true)
    }
    
}
