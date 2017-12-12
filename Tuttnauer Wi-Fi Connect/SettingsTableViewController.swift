//
//  SettingsTableViewController.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var selectedOptions: Enums.SettingsOptions!
    
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
    
    internal func resetCellTitlesValues() {
        let settings = UserSettingsManager.shared.userSettings!
        temperatureSignLabel.text = settings.temperatureUnit?.getName
        pressureSignLabel.text = settings.pressureUnit?.getName
        languageLabel.text = settings.language?.getName
        connectionTypeLabel.text = settings.connectionType?.getName
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            versionSubtitleLabel.text = "\(appVersion).\(appBuild)"
        }
        liveNotificationsSwitch.isOn = UserSettingsManager.shared.userSettings.receiveLiveNotifications!
    }
    
    // MARK: - IBActions
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func liveNotificationsSwitchTapped(_ sender: UISwitch) {
        
        NotificationsManager.shared.checkNotificationsAuthorizationStatus { (authorized) in
            DispatchQueue.main.sync {
                guard authorized else {
                    if sender.isOn {
                        Alerts.alertMessage(for: self, title: LocalString.alertDialogCouldNotActivateNotificationsTitle, message: LocalString.alertDialogCouldNotActivateNotificationsMessage, closeHandler: {
                            sender.setOn(false, animated: true)
                        })
                    }
                    return
                }
                UserSettingsManager.shared.setUserReceiveLiveNotifications(to: sender.isOn)
            }
        }
    }
}

// MARK: - Navigation

extension SettingsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIdentifiers.settingsToSettingsOptions {
            guard let vc = segue.destination as? SettingsOptionsTableViewController else { return }
            vc.delegate = self
            vc.optionsType = selectedOptions
        }
        
    }
    
}

// MARK: - TableView Data source & Delegate

extension SettingsTableViewController {
    
    // MARK: Data Source
    
    
    // MARK: Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                selectedOptions = Enums.SettingsOptions.temperatureUnit
            case 1:
                selectedOptions = Enums.SettingsOptions.pressureUnit
            case 2:
                selectedOptions = Enums.SettingsOptions.language
            case 3:
                selectedOptions = Enums.SettingsOptions.connectionType
            default:
                return
            }
            
            performSegue(withIdentifier: SegueIdentifiers.settingsToSettingsOptions, sender: self)
        }
        
    }
    
}

extension SettingsTableViewController: SettingsOptionsTableViewControllerDelegate {
    
    func didSelect(option: SettingsOption) {
        switch selectedOptions! {
            case .temperatureUnit:
                let unit = Enums.TemperatureUnit(rawValue: option.value)
                UserSettingsManager.shared.setUserTemperatureUnit(to: unit!)
            case .pressureUnit:
                let unit = Enums.PressureUnit(rawValue: option.value)
                UserSettingsManager.shared.setUserPressureUnit(to: unit!)
            case .language:
                let language = Enums.Language(rawValue: option.value)
                UserSettingsManager.shared.setUserLanguage(to: language!)
            case .connectionType:
                let type = Enums.ConnectionType(rawValue: option.value)
                UserSettingsManager.shared.setUserConnectionType(to: type!)
        }
        resetCellTitlesValues()
    }
    
}
