//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/7/21.
//

import SwiftUI

public extension Date {
    func currentTime_formatted(delimiter:String = "/") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "EDT")
        formatter.dateFormat = "MM\(delimiter)dd\(delimiter)yyyy"
        return formatter.string(from: self)
    }
    
    var writtenOut: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none

        return formatter.string(from: self)

    }
    
    func debugFormatter() -> String {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "EDT")
        df.dateFormat = "y-MM-dd H:mm:ss.SSSS"
        return df.string(from: self)
    }
    
    func universalFormatter() -> String {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "UTC")
        df.dateFormat = "y-MM-dd H:mm:ss.SSSS"
        return df.string(from: self)
    }
    
    func displayableDifference(comparedAgainst:Date = Date()) -> String?{
            let componentDifference = Calendar.current.dateComponents([
                Calendar.Component.year,
                Calendar.Component.month,
                Calendar.Component.day,
                Calendar.Component.hour,
                Calendar.Component.minute,
                Calendar.Component.second,
            ], from: self, to: comparedAgainst)
            let dateFormatter = DateFormatter()
            
            
            if componentDifference.year! > 0 {
                dateFormatter.dateFormat = "MMMM d yyyy"
                return dateFormatter.string(from: self)
            } else if componentDifference.day! > 0 {
                dateFormatter.dateFormat = "MMMM d"
                return dateFormatter.string(from: self)
            } else if componentDifference.hour! > 0 {
                return "\(componentDifference.hour!) hour\(componentDifference.hour! > 1 ? "s" : "") ago"
            } else if componentDifference.minute! > 0 {
                return "\(componentDifference.minute!) minute\(componentDifference.minute! > 1 ? "s" : "") ago"
            } else if componentDifference.second! > 0 {
                return "\(componentDifference.second!) second\(componentDifference.second! > 1 ? "s" : "") ago"
            } else {
                return nil
            }
        
    }
    
    func plus(days: Int) -> Date?{
        var dc = DateComponents()
        dc.day = days
        return Calendar.current.date(byAdding: dc, to: self)
    }
    
    var isToday: Bool {
        self.isSameYMD(as: Date())
    }
    
    func isSameYMD(as date: Date) -> Bool{
        self.dateComponents.year == date.dateComponents.year &&
            self.dateComponents.month == date.dateComponents.month &&
            self.dateComponents.day == date.dateComponents.day
    }
    
    var dateComponents: DateComponents{
        Calendar.current.dateComponents([.calendar, .day, .era, .hour, .minute, .month, .nanosecond, .quarter, .second, .second, .timeZone, .weekOfMonth, .weekOfYear, .weekday, .weekdayOrdinal, .year, .yearForWeekOfYear], from: self)
    }
    
    static func generate(year: Int?, month: Int?, day: Int?) -> Date? {
        
        if let year = year,
           let month = month,
           let day = day{
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
            return Calendar.current.date(from: dateComponents)
        }
        return nil
    }
    
    static func daysInMonth(_ monthNumber: Int, _ year: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = monthNumber
        if
            let d = Calendar.current.date(from: dateComponents),
            let interval = Calendar.current.dateInterval(of: .month, for: d),
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day
        { return days } else { return -1 }
    }
    
    var monthString: String?{
        if let month = self.dateComponents.month {
            return Calendar.current.monthSymbols[month-1]
        }
        return nil
    }
    
    

    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date))s" }
        return ""
    }
}
