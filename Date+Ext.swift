//
//  Date+Ext.swift
//  StrataPanel
//
//  Created by Gaurang on 18/04/23.
//

import Foundation

enum DateFormat: String {
    case standard       = "yyyy-MM-dd HH:mm:ss" //2020-02-17 16:42:37
    case fullDateTime   = "dd MMM yyyy - h:mm a" //12 Jan 2020, 5:15 pm
    case dateReadable   = "dd MMM yyyy"
    case fullDate       = "MMMM dd, yyyy"
    case digitDate      = "yyyy-MM-dd" // 1992-07-07
    case digitDate1     = "dd-MM-yyyy" // 1992-07-07
    case twelveHrTime   = "h:mm a"
    case dayDateMonth   = "E, d MMM" //Tue, 7 Sep
    case slashDate      = "dd/MM/yyyy" // 12/09/2021
    case monthYear      = "MMM yyyy"
    case descriptive    = "MMMM d, yyyy - h:mm a" //April 19, 2023 AT 11:00 AM

    var dateFormatter: DateFormatter {
        let dateformat = DateFormatter()
        dateformat.dateFormat = self.rawValue
        dateformat.locale = .current
        return dateformat
    }

    func getDateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func getDate(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    func convert(_ string: String, to df: DateFormat) -> String? {
        return string.getDate(self)?.getString(df)
    }

}

extension Date {
    
    func getString(_ format: DateFormat) -> String {
        format.getDateString(from: self)
    }

    func getDayDifferentTextWithTime() -> String {
        let calendar = Calendar.current
        let timeStr = DateFormat.twelveHrTime.getDateString(from: self).lowercased()
        if calendar.isDateInToday(self) {
            return "Today, \(timeStr)"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday, \(timeStr)"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow, \(timeStr)"
        } else {
            return DateFormat.fullDateTime.getDateString(from: self)
        }
    }

    func getDayDifferentText() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        } else {
            return DateFormat.fullDate.getDateString(from: self)
        }
    }

    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    func timeAgo() -> String {

        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        }
        
        let secondsAgo = Int(Date.now.timeIntervalSince(self))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week

        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
    
    func getFullString() -> String {
        self.getString(.descriptive).replacingOccurrences(of: "-", with: "AT")
    }
}

extension String {
    func getDate(_ format: DateFormat) -> Date? {
        format.getDate(from: self)
    }
}
