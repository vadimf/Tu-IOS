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
    static let settingsScreenCellChooseConnectionOptionManual = "settings_screen_cell_choose_connection_option_manual".localized
    static let settingsScreenCellChooseConnectionOptionLastMachine = "settings_screen_cell_choose_connection_option_last_machine".localized
    
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
    
    // MARK: - Side Menu items
    
    static let sideMenuItemPrivacyNoticeTitle = "side_menu_item_privacy_notice_title".localized
    static let sideMenuItemHelpTitle = "side_menu_item_help_title".localized
    static let sideMenuItemAboutTitle = "side_menu_item_about_title".localized
    
    // MARK: - AutoClave Enums Values
    
    // Current Status
    
    static let enumSystemCurrentStatusNone = "enum_system_current_status_none".localized
    static let enumSystemCurrentStatusNoError = "enum_system_current_status_no_error".localized
    static let enumSystemCurrentStatusStandbyError = "enum_system_current_status_standby_error".localized
    static let enumSystemCurrentStatusRunning = "enum_system_current_status_cycle_running".localized
    static let enumSystemCurrentStatusCycleDone = "enum_system_current_status_cycle_done" .localized
    static let enumSystemCurrentStatusCycleFailed = "enum_system_current_status_cycle_failed".localized
    static let enumSystemCurrentStatusNotReady = "enum_system_current_status_not_ready".localized
    
    // Door State
    
    static let enumDoorStateDoorOpen = "enum_door_state_door_open".localized
    static let enumDoorStateDoorClosed = "enum_door_state_door_closed".localized
    static let enumDoorStateDoor1ClosedDoor2Closed = "enum_door_state_door1closed_door2closed".localized
    static let enumDoorStateDoor1OpenDoor2Open = "enum_door_state_door1open_door2open".localized
    static let enumDoorStateDoor1ClosedDoor2Open = "enum_door_state_door1closed_door2open".localized
    static let enumDoorStateDoorDoor1OpenDoor2Closed = "enum_door_state_door1open_door2closed".localized
    
    // Door Error
    
    static let enumDoorErrorNone = "enum_door_error_none".localized
    static let enumDoorErrorVacuuming = "enum_door_error_vacuuming".localized
    static let enumDoorErrorOpening = "enum_door_error_opening".localized
    static let enumDoorErrorClosing = "enum_door_error_closing".localized
    static let enumDoorErrorLocking = "enum_door_error_locking".localized
    static let enumDoorErrorUnlocking = "enum_door_error_unlocking".localized
    
    // Cycle Stage
    
    static let enumCycleStageNone = "enum_cycle_stage_none".localized
    static let enumCycleStageGlobal = "enum_cycle_stage_global".localized
    static let enumCycleStageStart = "enum_cycle_stage_start".localized
    static let enumCycleStageRemoveAir = "enum_cycle_stage_remove_air".localized
    static let enumCycleStageStabilize = "enum_cycle_stage_stabilize".localized
    static let enumCycleStageHeat = "enum_cycle_stage_heat".localized
    static let enumCycleStageSterilization = "enum_cycle_stage_sterilization".localized
    static let enumCycleStageCool = "enum_cycle_stage_cool".localized
    static let enumCycleStageExhaust = "enum_cycle_stage_exhaust".localized
    static let enumCycleStageDry = "enum_cycle_stage_dry".localized
    static let enumCycleStageEnding = "enum_cycle_stage_ending".localized
    static let enumCycleStageDone = "enum_cycle_stage_done".localized
    
    // Background Status
    
    static let enumBackgroundStatusSystemReady = "enum_background_status_system_ready".localized
    static let enumBackgroundStatusPreHeating = "enum_background_status_pre_heating".localized
    static let enumBackgroundStatusHotWaterInChamber = "enum_background_status_hot_water_in_chamber".localized
    static let enumBackgroundStatusWaterInChamber = "enum_background_status_water_in_chamber".localized
    static let enumBackgroundStatusDoorOpen = "enum_background_status_door_open".localized
    static let enumBackgroundStatusWasteWaterReservoir = "enum_background_status_waste_water_reservoir".localized
    static let enumBackgroundStatusMineralFreeWaterReservoirEmpty = "enum_background_status_mineral_free_water_reservoir_empty".localized
    static let enumBackgroundStatusStandByCycle = "enum_background_status_stand_by_cycle".localized
    static let enumBackgroundStatusJacketIsCool = "enum_background_status_jacket_is_cool".localized
    static let enumBackgroundStatusEmptyReservoirVacuumPup = "enum_background_status_empty_reservoir_vacuum_pup".localized
    static let enumBackgroundStatusSteamGeneratorLowPressure = "enum_background_status_steam_generator_low_pressure".localized
    static let enumBackgroundStatusDrainHot = "enum_background_status_drain_hot".localized
    static let enumBackgroundStatusLowGasketPressure = "enum_background_status_low_gasket_pressure".localized
    static let enumBackgroundStatusIoExtensionDeviceNotConnected = "enum_background_status_io_extension_device_not_connected".localized
    static let enumBackgroundStatusHighStartTemperature = "enum_background_status_high_start_temperature".localized
    static let enumBackgroundStatusVhpInputNotReady = "enum_background_status_vhp_input_not_ready".localized
    static let enumBackgroundStatusBioFilterTimeout = "enum_background_status_bio_filter_timeout".localized
    static let enumBackgroundStatusBioFilterIsCool = "enum_background_status_bio_filter_is_cool".localized
    static let enumBackgroundStatusPrinterPortIsNotValid = "enum_background_status_printer_port_is_not_valid".localized
    static let enumBackgroundStatusWaitDoorOpening = "enum_background_status_wait..._door_opening".localized
    static let enumBackgroundStatusWaitDoorClosing = "enum_background_status_wait..._door_closing".localized
    static let enumBackgroundStatusCoolDrainTimeOut = "enum_background_status_cool_drain_time_out".localized
    static let enumBackgroundStatusJacketTimeOut = "enum_background_status_jacket_time_out".localized
    static let enumBackgroundStatusSupplyError = "enum_background_status_supply_error".localized
    static let enumBackgroundStatusSupplyWaterError = "enum_background_status_supply_water_error".localized
    static let enumBackgroundStatusNoWaterInReservoirVacuumPump = "enum_background_status_no_water_in_reservoir_vacuum_pump".localized
    static let enumBackgroundStatusNoWaterInReservoirGenerator = "enum_background_status_no_water_in_reservoir_generator".localized
    static let enumBackgroundStatusSupplyDistilledWaterError = "enum_background_status_supply_distilled_water_error".localized
    static let enumBackgroundStatusCompressedAirSupplyError = "enum_background_status_compressed_air_supply_error".localized
    static let enumBackgroundStatusSteamGeneratorNoWater = "enum_background_status_steam_generator_no_water".localized
    static let enumBackgroundStatusChamberPressureNotInRange = "enum_background_status_chamber_pressure_not_in_range".localized
    static let enumBackgroundStatusChamberTemperatureNotInRange = "enum_background_status_chamber_temperature_not_in_range".localized
    static let enumBackgroundStatusAtmosphericPressureNotSet = "enum_background_status_atmospheric_pressure_not_set".localized
    static let enumBackgroundStatusDoorError = "enum_background_status_door_error".localized
    static let enumBackgroundStatusEmergencyStop = "enum_background_status_emergency_stop".localized
    static let enumBackgroundStatusTestModeIsActive = "enum_background_status_test_mode_is_active".localized
    static let enumBackgroundStatusAnalogInputError = "enum_background_status_analog_input_error".localized
    static let enumBackgroundStatusAirDetectorIsNotConnected = "enum_background_status_air_detector_is_not_connected".localized
    static let enumBackgroundStatusIoCardIsNotConnected = "enum_background_status_i/o_card_is_not_connected".localized
    static let enumBackgroundStatusTimeError = "enum_background_status_time_error".localized
    static let enumBackgroundStatusProtocolPortIsNotValid = "enum_background_status_protocol_port_is_not_valid".localized
    static let enumBackgroundStatusCycleEnded = "enum_background_status_cycle_ended".localized
    
    // Cycle ID
    
    static let enumCycleIDUnwrappedInstruments = "enum_cycle_id_unwrapped_instruments".localized
    static let enumCycleIDWrappedInstruments = "enum_cycle_id_wrapped_instruments".localized
    static let enumCycleIDPouches = "enum_cycle_id_pouches".localized
    static let enumCycleIDWrappedPouches = "enum_cycle_id_wrapped_pouches".localized
    static let enumCycleIDUnwrappedDelicateInst = "enum_cycle_id_unwrapped_delicate_inst.".localized
    static let enumCycleIDWrappedDelicateInst = "enum_cycle_id_wrapped_delicate_inst.".localized
    static let enumCycleIDLiquidsA = "enum_cycle_id_liquids_a".localized
    static let enumCycleIDLiquidsB = "enum_cycle_id_liquids_b".localized
    static let enumCycleIDBigPackages = "enum_cycle_id_big_packages".localized
    static let enumCycleIDBioHazardA = "enum_cycle_id_bio_hazard_a".localized
    static let enumCycleIDBioHazardB = "enum_cycle_id_bio_hazard_b".localized
    static let enumCycleIDVacuumTest = "enum_cycle_id_vacuum_test".localized
    static let enumCycleIDBowieAndDick = "enum_cycle_id_bowie_and_dick".localized
    static let enumCycleIDPasteurization = "enum_cycle_id_pasteurization".localized
    static let enumCycleIDVhp = "enum_cycle_id_vhp".localized
    static let enumCycleIDWarmUp = "enum_cycle_id_warm_up".localized
    static let enumCycleIDIsothermal = "enum_cycle_id_isothermal".localized
    static let enumCycleIDGlass = "enum_cycle_id_glass".localized
    static let enumCycleIDPlastic = "enum_cycle_id_plastic".localized
    static let enumCycleIDLiquidA = "enum_cycle_id_liquid_a".localized
    static let enumCycleIDLiquidBWaste = "enum_cycle_id_liquid_b_waste".localized
    static let enumCycleIDLiquidACooling = "enum_cycle_id_liquid_a_cooling".localized
    static let enumCycleIDLiquidBWasteCooling = "enum_cycle_id_liquid_b_waste_cooling".localized
    static let enumCycleIDWaste = "enum_cycle_id_waste".localized
    static let enumCycleIDHollowLoad = "enum_cycle_id_hollow_load".localized
    static let enumCycleIDBiohazardLiquids = "enum_cycle_id_biohazard_liquids".localized
    static let enumCycleIDUnwrapped134 = "enum_cycle_id_unwrapped_134".localized
    static let enumCycleIDWrapped134 = "enum_cycle_id_wrapped_134".localized
    static let enumCycleIDUnwrapped121 = "enum_cycle_id_unwrapped_121".localized
    static let enumCycleIDWrapped121 = "enum_cycle_id_wrapped_121".localized
    static let enumCycleIDPrion134 = "enum_cycle_id_prion_134".localized
    static let enumCycleIDExtraDryingTime = "enum_cycle_id_extra_drying_time".localized
    static let enumCycleIDAirSteamMixture = "enum_cycle_id_air_steam_mixture".localized
    static let enumCycleIDGlassTest = "enum_cycle_id_glass_test".localized
    static let enumCycleIDCustom1 = "enum_cycle_id_custom_1".localized
    static let enumCycleIDCustom2 = "enum_cycle_id_custom_2".localized
    static let enumCycleIDCustom3 = "enum_cycle_id_custom_3".localized
    static let enumCycleIDCustom4 = "enum_cycle_id_custom_4".localized
    static let enumCycleIDCustom5 = "enum_cycle_id_custom_5".localized
    static let enumCycleIDCustom6 = "enum_cycle_id_custom_6".localized
    static let enumCycleIDCustom7 = "enum_cycle_id_custom_7".localized
    static let enumCycleIDCustom8 = "enum_cycle_id_custom_8".localized
    static let enumCycleIDCustom9 = "enum_cycle_id_custom_9".localized
    static let enumCycleIDCustom10 = "enum_cycle_id_custom_10".localized
    static let enumCycleIDCustom11 = "enum_cycle_id_custom_11".localized
    static let enumCycleIDCustom12 = "enum_cycle_id_custom_12".localized
    static let enumCycleIDCustom13 = "enum_cycle_id_custom_13".localized
    static let enumCycleIDCustom14 = "enum_cycle_id_custom_14".localized
    static let enumCycleIDCustom15 = "enum_cycle_id_custom_15".localized
    static let enumCycleIDCustom16 = "enum_cycle_id_custom_16".localized
    static let enumCycleIDCustom17 = "enum_cycle_id_custom_17".localized
    static let enumCycleIDCustom18 = "enum_cycle_id_custom_18".localized
    static let enumCycleIDCustom19 = "enum_cycle_id_custom_19".localized
    static let enumCycleIDCustom20 = "enum_cycle_id_custom_20".localized
    
    // Cycle Sub Stage
    
    static let enumCycleSubStageNone = "enum_cycle_sub_stage_none".localized
    static let enumCycleSubStagePurge = "enum_cycle_sub_stage_purge".localized
    static let enumCycleSubStageInsertWater = "enum_cycle_sub_stage_insert_water".localized
    static let enumCycleSubStageSteamFlush = "enum_cycle_sub_stage_steam_flush".localized
    static let enumCycleSubStageCreatePulse = "enum_cycle_sub_stage_create_pulse".localized
    static let enumCycleSubStagePulseH = "enum_cycle_sub_stage_pulse_h".localized
    static let enumCycleSubStagePulseL = "enum_cycle_sub_stage_pulse_l".localized
    static let enumCycleSubStageVacuum = "enum_cycle_sub_stage_vacuum".localized
    static let enumCycleSubStageStayA = "enum_cycle_sub_stage_stay_a".localized
    static let enumCycleSubStageStayB = "enum_cycle_sub_stage_stay_b".localized
    static let enumCycleSubStageVhpWait = "enum_cycle_sub_stage_vhp_wait".localized
    static let enumCycleSubStageVhpRunning = "enum_cycle_sub_stage_vhp_running".localized
    static let enumCycleSubStageVhpEnding = "enum_cycle_sub_stage_vhp_ending".localized
    static let enumCycleSubStageStableBeforeSter = "enum_cycle_sub_stage_stable_before_ster".localized
    static let enumCycleSubStageStabelAfterSter = "enum_cycle_sub_stage_stabel_after_ster".localized
    static let enumCycleSubStageWaitForOpenDoor = "enum_cycle_sub_stage_wait_for_open_door".localized
    static let enumCycleSubStagePrestableBeforeSter = "enum_cycle_sub_stage_pre-stable_before_ster".localized
    static let enumCycleSubStagePrestableAfterSter = "enum_cycle_sub_stage_pre-stable_after_ster".localized
    static let enumCycleSubStagePreheat = "enum_cycle_sub_stage_pre-heat".localized
    static let enumCycleSubStageFilterTestInsertWater = "enum_cycle_sub_stage_filter_test_insert_water".localized
    static let enumCycleSubStageFilterTestCreatePressure = "enum_cycle_sub_stage_filter_test_create_pressure".localized
    static let enumCycleSubStageFilterTestStable = "enum_cycle_sub_stage_filter_test_stable".localized
    static let enumCycleSubStageFilterTestTesting = "enum_cycle_sub_stage_filter_test_testing".localized
    static let enumCycleSubStageFilterTestExhaust = "enum_cycle_sub_stage_filter_test_exhaust".localized
    static let enumCycleSubStageCoolA = "enum_cycle_sub_stage_cool_a".localized
    static let enumCycleSubStageCoolB = "enum_cycle_sub_stage_cool_b".localized
    static let enumCycleSubStageCoolC = "enum_cycle_sub_stage_cool_c".localized
    static let enumCycleSubStageExhaustA = "enum_cycle_sub_stage_exhaust_a".localized
    static let enumCycleSubStageExhaustB = "enum_cycle_sub_stage_exhaust_b".localized
    
    // Cycle Error
    
    static let enumCycleErrorNone = "enum_cycle_error_none".localized
    static let enumCycleErrorCancelledByUser = "enum_cycle_error_cancelled_by_user".localized
    static let enumCycleErrorDoorIsOpen = "enum_cycle_error_door_is_open".localized
    static let enumCycleErrorAnalogInputError = "enum_cycle_error_analog_input_error".localized
    static let enumCycleErrorIoCardNotConnected = "enum_cycle_error_io_card_not_connected".localized
    static let enumCycleErrorPowerDown = "enum_cycle_error_power_down".localized
    static let enumCycleErrorInsertWaterTimeError = "enum_cycle_error_insert_water_time_error".localized
    static let enumCycleErrorHeatBeforePressureTimeError = "enum_cycle_error_heat_before_pressure_time_error".localized
    static let enumCycleErrorVacuumTimeError = "enum_cycle_error_vacuum_time_error".localized
    static let enumCycleErrorPressureTimeError = "enum_cycle_error_pressure_time_error".localized
    static let enumCycleErrorKeepHeatTimeError = "enum_cycle_error_keep_heat_time_error".localized
    static let enumCycleErrorHeatToSterilizationTimeError = "enum_cycle_error_heat_to_sterilization_time_error".localized
    static let enumCycleErrorSterilizationLowPressure = "enum_cycle_error_sterilization_low_pressure".localized
    static let enumCycleErrorSterilizationHighPressure = "enum_cycle_error_sterilization_high_pressure".localized
    static let enumCycleErrorSterilizationLowTemp = "enum_cycle_error_sterilization_low_temp".localized
    static let enumCycleErrorSterilizationHighTemp = "enum_cycle_error_sterilization_high_temp".localized
    static let enumCycleErrorRtcTimerError = "enum_cycle_error_rtc_timer_error".localized
    static let enumCycleErrorCoolingLowPressure = "enum_cycle_error_cooling_low_pressure".localized
    static let enumCycleErrorCoolingHighTemp = "enum_cycle_error_cooling_high_temp".localized
    static let enumCycleErrorExhaustHighPressure = "enum_cycle_error_exhaust_high_pressure".localized
    static let enumCycleErrorHighPressureDry = "enum_cycle_error_high_pressure_(dry)".localized
    static let enumCycleErrorEndingHighPressure = "enum_cycle_error_ending_high_pressure".localized
    static let enumCycleErrorAirError = "enum_cycle_error_air_error".localized
    static let enumCycleErrorEndingHighTemperature = "enum_cycle_error_ending_high_temperature".localized
    static let enumCycleErrorErrorOpenDoor = "enum_cycle_error_error_open_door".localized
    static let enumCycleErrorErrorCloseDoor = "enum_cycle_error_error_close_door".localized
    static let enumCycleErrorVhpTimeout = "enum_cycle_error_vhp_timeout".localized
    static let enumCycleErrorEmergencyStop = "enum_cycle_error_emergency_stop".localized
    static let enumCycleErrorThermoBioFilterTimeout = "enum_cycle_error_thermo_bio_filter_timeout".localized
    static let enumCycleErrorPurgeTimeout = "enum_cycle_error_purge_timeout".localized
    static let enumCycleErrorAirDetector = "enum_cycle_error_air_detector".localized
    static let enumCycleErrorInternalError = "enum_cycle_error_internal_error".localized
    static let enumCycleErrorLeak = "enum_cycle_error_leak".localized
    static let enumCycleErrorVhpFail = "enum_cycle_error_vhp_fail".localized
    static let enumCycleErrorPreHeatTimeout = "enum_cycle_error_pre_heat_timeout".localized
    static let enumCycleErrorJacketIsCool = "enum_cycle_error_jacket_is_cool".localized
    static let enumCycleErrorWaterHighTemp = "enum_cycle_error_water_high_temp".localized
    static let enumCycleErrorLowWaterPressure = "enum_cycle_error_low_water_pressure".localized
    static let enumCycleErrorPipingError = "enum_cycle_error_piping_error".localized
    static let enumCycleErrorFaultFilter = "enum_cycle_error_fault_filter".localized
    static let enumCycleErrorPAirRemovalVacuumFailure = "enum_cycle_error_p_air_removal_vacuum_failure".localized
    static let enumCycleErrorPLeak = "enum_cycle_error_p_leak".localized
    static let enumCycleErrorPPrepareAirInletFailure = "enum_cycle_error_p_prepare_air_inlet_failure".localized
    static let enumCycleErrorPPrepareVacuumFailure = "enum_cycle_error_p_prepare_vacuum_failure".localized
    static let enumCycleErrorPBurnerNotReady = "enum_cycle_error_p_burner_not_ready".localized
    static let enumCycleErrorPDiffusion1LowPressure = "enum_cycle_error_p_diffusion_1_low_pressure".localized
    static let enumCycleErrorPDiffusion1HighPressure = "enum_cycle_error_p_diffusion_1_high_pressure".localized
    static let enumCycleErrorPDiffusion1HighRate = "enum_cycle_error_p_diffusion_1_high_rate".localized
    static let enumCycleErrorPDiffusion1AirInletFailure = "enum_cycle_error_p_diffusion_1_air_inlet_failure".localized
    static let enumCycleErrorPPlazma1VacuumFailure = "enum_cycle_error_p_plazma_1_vacuum_failure".localized
    static let enumCycleErrorPDiffusion2LowPressure = "enum_cycle_error_p_diffusion_2_low_pressure".localized
    static let enumCycleErrorPDiffusion2HighPressure = "enum_cycle_error_p_diffusion_2_high_pressure".localized
    static let enumCycleErrorPDiffusion2HighRate = "enum_cycle_error_p_diffusion_2_high_rate".localized
    static let enumCycleErrorPDiffusion2AirInletFailure = "enum_cycle_error_p_diffusion_2_air_inlet_failure".localized
    static let enumCycleErrorPPlazma2VacuumFailure = "enum_cycle_error_p_plazma_2_vacuum_failure".localized
    static let enumCycleErrorPAerationVacuumFailure = "enum_cycle_error_p_aeration_vacuum_failure".localized
    static let enumCycleErrorPAerationAirInletFailure = "enum_cycle_error_p_aeration_air_inlet_failure".localized
    static let enumCycleErrorPNormalPressure = "enum_cycle_error_p_normal_pressure".localized
    static let enumCycleErrorPCancelledByUser = "enum_cycle_error_p_cancelled_by_user".localized
    static let enumCycleErrorPEmergencyStop = "enum_cycle_error_p_emergency_stop".localized
    static let enumCycleErrorPIoCardNotConnected = "enum_cycle_error_p_io_card_not_connected".localized
    static let enumCycleErrorPAnalogInputError = "enum_cycle_error_p_analog_input_error".localized
    static let enumCycleErrorPPowerDown = "enum_cycle_error_p_power_down".localized
    static let enumCycleErrorPDoorIsOpen = "enum_cycle_error_p_door_is_open".localized
    static let enumCycleErrorPCancelledByAdmin = "enum_cycle_error_p_cancelled_by_admin".localized
    static let enumCycleErrorPInternalError = "enum_cycle_error_p_internal_error".localized
    static let enumCycleError0VacuumFail = "enum_cycle_error_0_vacuum_fail".localized
    static let enumCycleError0Leak = "enum_cycle_error_0_leak".localized
    static let enumCycleError0SteamError = "enum_cycle_error_0_steam_error".localized
    static let enumCycleError003Timeout = "enum_cycle_error_0_03_timeout".localized
    static let enumCycleError003LowConcentration = "enum_cycle_error_0_03_low_concentration".localized
    static let enumCycleError0ExhaustVacuumFail = "enum_cycle_error_0_exhaust_vacuum_fail".localized
    static let enumCycleError0ExhaustPressureFail = "enum_cycle_error_0_exhaust_pressure_fail".localized
    static let enumCycleError0NormalPressure = "enum_cycle_error_0_normal_pressure".localized
    static let enumCycleError003HighConcentration = "enum_cycle_error_0_03_high_concentration".localized
    static let enumCycleError003Leaks = "enum_cycle_error_0_03_leaks".localized
    static let enumCycleError003Dis = "enum_cycle_error_0_03_dis".localized
    static let enumCycleError0No02Supply = "enum_cycle_error_0_no_02_supply".localized
    static let enumCycleError0NoSteam = "enum_cycle_error_0_no_steam".localized
    static let enumCycleError0AnalogInputError = "enum_cycle_error_0_analog_input_error".localized
    static let enumCycleError0DoorIsOpen = "enum_cycle_error_0_door_is_open".localized
    static let enumCycleError0CancelledByUser = "enum_cycle_error_0_cancelled_by_user".localized
    static let enumCycleError0IoCardNotConnected = "enum_cycle_error_0_io_card_not_connected".localized
    static let enumCycleError0PowerDown = "enum_cycle_error_0_power_down".localized
    static let enumCycleError0InternalError = "enum_cycle_error_0_internal_error".localized

    // Analog Input Short Names
    
    static let enumAnalogInputNameNone = "enum_analog_input_name_none".localized
    static let enumAnalogInputNameDoor1 = "enum_analog_input_name_door_1".localized
    static let enumAnalogInputNameDoor2 = "enum_analog_input_name_door_2".localized
    static let enumAnalogInputNameTemperature = "enum_analog_input_name_temperature".localized
    static let enumAnalogInputNameTemp1 = "enum_analog_input_name_temp._1".localized
    static let enumAnalogInputNameBioTemp = "enum_analog_input_name_bio_temp.".localized
    static let enumAnalogInputNamePressure = "enum_analog_input_name_pressure".localized
    static let enumAnalogInputNameWater = "enum_analog_input_name_water".localized
    static let enumAnalogInputNameJacketPressure = "enum_analog_input_name_jacket_pressure".localized
    static let enumAnalogInputNameJacketTemperature = "enum_analog_input_name_jacket_temperature".localized
    static let enumAnalogInputNameGenerator = "enum_analog_input_name_generator".localized
    static let enumAnalogInputNameDrainTemperature = "enum_analog_input_name_drain_temperature".localized
    static let enumAnalogInputNameTemp2 = "enum_analog_input_name_temp._2".localized
    static let enumAnalogInputNameGeneratorWater = "enum_analog_input_name_generator_water".localized
    static let enumAnalogInputNameWaterWaste = "enum_analog_input_name_water_waste".localized
    static let enumAnalogInputNameDistilledWater = "enum_analog_input_name_distilled_water".localized
    static let enumAnalogInputNameAirPressureDetector = "enum_analog_input_name_air_pressure_detector".localized
    static let enumAnalogInputNameBioJacket = "enum_analog_input_name_bio_jacket".localized
    static let enumAnalogInputNameExtTemperature = "enum_analog_input_name_ext._temperature".localized
    static let enumAnalogInputNameExtPressure = "enum_analog_input_name_ext._pressure".localized
    static let enumAnalogInputNameTemp3 = "enum_analog_input_name_temp._3".localized
    static let enumAnalogInputNameTemp4 = "enum_analog_input_name_temp._4".localized
    static let enumAnalogInputNameTemp5 = "enum_analog_input_name_temp._5".localized
    static let enumAnalogInputNameFilterPressure = "enum_analog_input_name_filter_pressure".localized
    static let enumAnalogInputNameFilterTemperature = "enum_analog_input_name_filter_temperature".localized
    
    // Main Parameters Names
    
    static let enumMainParameterNameNone = "enum_main_parameter_name_none".localized
    static let enumMainParameterNameSterTemp = "enum_main_parameter_name_ster._temp.".localized
    static let enumMainParameterNameSterTime = "enum_main_parameter_name_ster._time".localized
    static let enumMainParameterNameDryTime = "enum_main_parameter_name_dry_time".localized
    static let enumMainParameterNameStable1Temperature = "enum_main_parameter_name_stable1_temperature".localized
    static let enumMainParameterNameStable1Time = "enum_main_parameter_name_stable1_time".localized
    static let enumMainParameterNameStable2Temperature = "enum_main_parameter_name_stable2_temperature".localized
    static let enumMainParameterNameStable2Time = "enum_main_parameter_name_stable2_time".localized
    static let enumMainParameterNameVacPres = "enum_main_parameter_name_vac._pres.".localized
    static let enumMainParameterNameVacTime1 = "enum_main_parameter_name_vac._time_1".localized
    static let enumMainParameterNameVacTime2 = "enum_main_parameter_name_vac._time_2".localized
    static let enumMainParameterNameTestTime = "enum_main_parameter_name_test_time".localized
    static let enumMainParameterNameDryPulses = "enum_main_parameter_name_dry_pulses".localized
    
}
