//
//  LocalString.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 10/14/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

class LocalString: NSObject {
    
    // MARK: - General
    
    static let appName = "app_name".localized

    // MARK: - Alert Dialog Buttons
    
    static let alertDialogButtonClose = "alert_dialog_button_close".localized
    static let alertDialogButtonDone = "alert_dialog_button_done".localized
    static let alertDialogButtonCancel = "alert_dialog_button_cancel".localized
    static let alertDialogButtonYes = "alert_dialog_button_yes".localized
    static let alertDialogButtonNo = "alert_dialog_button_no".localized
    static let alertDialogButtonConnect = "alert_dialog_button_connect".localized
    static let alertDialogButtonReconnect = "alert_dialog_button_reconnect".localized
    static let alertDialogButtonDisconnect = "alert_dialog_button_disconnect".localized
    
    // MARK: - Alert Dialog Messages
    
    static let alertDialogConnectionFailedTitle = "alert_dialog_connection_failed_title".localized
    static let alertDialogConnectionFailedMessage = "alert_dialog_connection_failed_message".localized
    static let alertDialogConnectionLostTitle = "alert_dialog_connection_lost_title".localized
    static let alertDialogConnectionLostMesssage = "alert_dialog_connection_lost_message".localized
    static let alertDialogCouldNotActivateNotificationsTitle = "alert_dialog_could_not_activate_notifications_title".localized
    static let alertDialogCouldNotActivateNotificationsMessage = "alert_dialog_could_not_activate_notifications_message".localized
    
    // MARK: - Progress HUD titles
    
    static let progressHUDConnecting = "progress_hud_connecting".localized
    static let progressHUDConnectingTo = "progress_hud_connecting_to".localized
    static let progressHUDSearching = "progress_hud_searching".localized
    
    // MARK: - Scan For Machines Screen
    
    static let scanMachinesScreenTitle = "scan_machines_screen_title".localized
    static let scanMachinesScreenFoundMultipleMachinesTitle = "scan_machines_screen_found_multiple_machines_title".localized
    static let scanMachinesScreenFoundOneMachineTitle = "scan_machines_screen_found_one_machine_title".localized
    static let scanMachinesScreenFoundMultipleMachinesChooseTitle = "scan_machines_screen_found_multiple_machines_choose_title".localized
    static let scanMachinesScreenFoundOneMachineChooseTitle = "scan_machines_screen_found_one_machine_choose_title".localized
    static let scanMachinesScreenFoundNoneMachinesTitle = "scan_machines_screen_found_none_machines_title".localized
    
    static let scanMachinesScreenTableViewCellModelNameTitle = "scan_machines_screen_tableview_cell_model_name_title".localized
    static let scanMachinesScreenTableViewCellSerialTitle = "scan_machines_screen_tableview_cell_serial_title".localized
    static let scanMachinesScreenTableViewCellIPTitle = "scan_machines_screen_tableview_cell_ip_title".localized
    static let scanMachinesScreenTableViewCellBSVersionTitle = "scan_machines_screen_tableview_cell_bsversion_title".localized
    static let scanMachinesScreenTableViewCellConnectedTitle = "scan_machines_screen_tableview_cell_connected_title".localized
    
    // MARK: - Single Machine Screen
    
    static let singleMachineScreenModelNameTitle = "single_machine_screen_model_name_title".localized
    static let singleMachineScreenSerialNumberTitle = "single_machine_screen_serial_number_title".localized
    static let singleMachineScreenIPAddressTitle = "single_machine_screen_ip_address_title".localized
    static let singleMachineScreenVersionTitle = "single_machine_screen_version_title".localized
    
    static let singleMachineScreenCurrentStageTitle = "single_machine_screen_current_stage_title".localized
    static let singleMachineScreenCurrentCycleNameTitle = "single_machine_screen_current_cycle_name".localized
    static let singleMachineScreenParametersTitle = "single_machine_screen_parameters_title_label".localized
    
    static let singleMachineScreenSystemStatusTitle = "single_machine_screen_system_status_title".localized
    static let singleMachineScreenDoorStateTitle = "single_machine_screen_door_state".localized
    static let singleMachineScreenCycleErrorTitle = "single_machine_screen_cycle_error_title".localized
    
    // MARK: - Settings Screen
    
    static let settingsScreenTitle = "settings_screen_title".localized
    
    static let settingsScreenGroupTitlePreferences = "settings_screen_group_title_preferences".localized
    static let settingsScreenGroupTitleNotifications =  "settings_screen_group_title_notifications".localized
    static let settingsScreenGroupTitleAbout = "settings_screen_group_title_about".localized
    
    static let settingsScreenCellTemperatureTitle = "settings_screen_cell_temperature_title".localized
    static let settingsScreenCellTemperatureOptionCelcius = "settings_screen_cell_temperature_option_celcius".localized
    static let settingsScreenCellTemperatureOptionFahrenheit = "settings_screen_cell_temperature_option_fahrenheit".localized
    
    static let settingsScreenCellPressureTitle = "settings_screen_cell_pressure_title".localized
    static let settingsScreenCellPressureKpa = "settings_screen_cell_pressure_kpa".localized
    
    static let settingsScreenCellLanguageTitle = "settings_screen_cell_language_title".localized
    static let settingsScreenCellLanguageOptionEnglish = "settings_screen_cell_language_option_english".localized
    
    static let settingsScreenCellChooseConnectionTitle = "settings_screen_cell_choose_connection_title".localized
    static let settingsScreenCellChooseConnectionOptionAuto = "settings_screen_cell_choose_connection_option_auto".localized
    
    static let settingsScreenCellNotificationsTitle = "settings_screen_cell_notifications_title".localized
    static let settingsScreenCellNotificationsSubtitle = "settings_screen_cell_notifications_subtitle".localized
    
    static let settingsScreenCellCreatedByTitle = "settings_screen_cell_created_by_title".localized
    static let settingsScreenCellCreatedBySubtitle = "settings_screen_cell_created_by_subtitle".localized
    
    static let settingsScreenCellCopyrightTitle = "settings_screen_cell_copyright_title".localized
    static let settingsScreenCellCopyrightSubtitle = "settings_screen_cell_copyright_subtitle".localized
    
    static let settingsScreenCellVersionTitle = "settings_screen_cell_version_title".localized
    
    
    // MARK: - Languages
    
    static let languageEnglish = "English".localized
    static let languageSpanish = "Spanish".localized
    
}
