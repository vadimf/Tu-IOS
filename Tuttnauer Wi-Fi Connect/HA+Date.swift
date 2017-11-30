//
//  HA+Date.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 11/8/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

extension Date {
    
    func getDateComponents() -> DateComponents {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return components
    }
    
    func minutesAndSeconds(until date: Date) -> String {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let components = calendar.dateComponents([.minute, .second], from: self, to: date)
        let minutesComponent = components.minute ?? 0
        let secondsComponent = components.second ?? 0
        
        var minutes = "00"
        var seconds = "00"
        
        minutes = minutesComponent < 10 ? "0\(minutesComponent)" : "\(minutesComponent)"
        seconds = secondsComponent < 10 ? "0\(secondsComponent)" : "\(secondsComponent)"
        
        return "\(minutes):\(seconds)"
    }
    
    func getCountdown(to date: Date) -> String {
        let fromDateString = String.init(describing: self) // From this Date
        let toDateString = String.init(describing: date) // To this future Date
        
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        fromDateFormatter.timeZone = .current
        let fromDate = fromDateFormatter.date(from: fromDateString)
        
        let toDateFormatter = DateFormatter()
        toDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        fromDateFormatter.timeZone = .current
        let toDate = toDateFormatter.date(from: toDateString)
        
        guard let from = fromDate, let to = toDate else { return "" }
        
        let diffComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: from, to: to)
        
        let hours = diffComponents.hour ?? 0
        let minutes = diffComponents.minute ?? 0
        let seconds = diffComponents.second ?? 0
        
        return "\(hours):\(minutes):\(seconds)"
    }
    
    func local() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateInFormat = dateFormatter.string(from: self)
        guard let localDate = dateFormatter.date(from: dateInFormat) else {
            return Date()
        }
        return localDate
    }
    
    // MARK: - Ticks
    
    init(ticks: UInt64) {
        self.init(timeIntervalSince1970: Double(ticks)/10_000_000 - 62_135_596_800)
    }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
}
