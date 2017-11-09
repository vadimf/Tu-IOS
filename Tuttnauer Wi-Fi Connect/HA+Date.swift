//
//  HA+Date.swift
//  Tuttnauer Wi-Fi Connect
//
//  Created by Erez Hod on 11/8/17.
//  Copyright © 2017 Tuttnauer Europe B.V. All rights reserved.
//

import Foundation

extension Date {
    
    func minutesAndSeconds(until date: Date) -> (minutes: Int, seconds: Int) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let components = calendar.dateComponents([.minute, .second], from: self, to: date)
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        return (minutes, seconds)
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
