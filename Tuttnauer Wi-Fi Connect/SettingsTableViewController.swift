//
//  SettingsTableViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // MARK: - IBOutlets
    
    // MARK: Cell Titles
    
    @IBOutlet weak var temperatureTitleLabel: UILabel!
    @IBOutlet weak var pressureTitleLabel: UILabel!
    @IBOutlet weak var languageTitleLabel: UILabel!
    @IBOutlet weak var connectionTypeTitleLabel: UILabel!
    @IBOutlet weak var liveNotificationsTitleLabel: UILabel!
    @IBOutlet weak var liveNotificationsSubtitleLabel: UILabel!
    @IBOutlet weak var createdByTitleLabel: UILabel!
    @IBOutlet weak var createdBySubtitleLabel: UILabel!
    @IBOutlet weak var copyrightTitleLabel: UILabel!
    @IBOutlet weak var copyrightSubtitleLabel: UILabel!
    @IBOutlet weak var versionTitleLabel: UILabel!
    @IBOutlet weak var versionSubtitleLabel: UILabel!
    
    // MARK: Cell Subtitles / Values
    
    @IBOutlet weak var temperatureSignLabel: UILabel!
    @IBOutlet weak var pressureSignLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var connectionTypeLabel: UILabel!
    @IBOutlet weak var liveNotificationsSwitch: UISwitch!
    
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = true
        setupLocalization()
        resetCellTitlesValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Methods
    
    private func setupLocalization() {
        temperatureTitleLabel.text = LocalString.settingsScreenCellTemperatureTitle
        pressureTitleLabel.text = LocalString.settingsScreenCellPressureTitle
        languageTitleLabel.text = LocalString.settingsScreenCellLanguageTitle
        connectionTypeTitleLabel.text = LocalString.settingsScreenCellChooseConnectionTitle
        liveNotificationsTitleLabel.text = LocalString.settingsScreenCellNotificationsTitle
        liveNotificationsSubtitleLabel.text = LocalString.settingsScreenCellNotificationsSubtitle
        createdByTitleLabel.text = LocalString.settingsScreenCellCreatedByTitle
        createdBySubtitleLabel.text = LocalString.settingsScreenCellCreatedBySubtitle
        copyrightTitleLabel.text = LocalString.settingsScreenCellCopyrightTitle
        copyrightSubtitleLabel.text = LocalString.settingsScreenCellCopyrightSubtitle
        versionTitleLabel.text = LocalString.settingsScreenCellVersionTitle
    }
    
    private func resetCellTitlesValues() {
        temperatureSignLabel.text = ""
        pressureSignLabel.text = ""
        languageLabel.text = ""
        connectionTypeLabel.text = ""
        versionSubtitleLabel.text = ""
        liveNotificationsSwitch.isOn = false
    }
    
    // MARK: - IBActions
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - Navigation

extension SettingsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

// MARK: - TableView Data source & Delegate

extension SettingsTableViewController {
    
    // MARK: Data Source
    
    // MARK: Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: What to do when a cell is selected?
    }
    
}
