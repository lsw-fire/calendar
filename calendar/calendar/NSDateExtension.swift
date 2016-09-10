//
//  LunarCalendar.swift
//  calendar
//
//  Created by Li Shi Wei on 9/7/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit


extension NSDate {
    
    convenience init(date: NSDate) {
        self.init(timeInterval:0, sinceDate: date )
    }
    
    convenience init(year:Int!, month:Int!, day:Int!, hour:Int! = 0, min:Int! = 0, second:Int = 0) {
        
        if(year == nil || month == nil || day == nil)
        {
            self.init()
            return
        }
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponent = NSDateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        dateComponent.hour = hour
        dateComponent.minute = min
        dateComponent.second = second
        
        self.init(timeInterval:0,sinceDate: calendar.dateFromComponents(dateComponent)!)
    }
    
    
    func getDateComponents() -> NSDateComponents {
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: self)
        
        return components
    }
    
    public var dayOfWeek : Int {
        get{
            
            let myCalendar = NSCalendar.currentCalendar()
            let myComponents = myCalendar.components(.Weekday, fromDate: self)
            let weekDay = myComponents.weekday
            return weekDay
        }
    }
    
    public var day: Int {
        return NSCalendar.currentCalendar().component(.Day, fromDate: self)
    }
    
    public var month: Int {
        return NSCalendar.currentCalendar().component(.Month, fromDate: self)
    }
    
    public var year: Int {
        return NSCalendar.currentCalendar().component(.Year, fromDate: self)
    }
    
    public var hour: Int {
        return NSCalendar.currentCalendar().component(.Hour, fromDate: self)
    }
    
    public var minute: Int {
        return NSCalendar.currentCalendar().component(.Minute, fromDate: self)
    }
    
    public var second: Int {
        return NSCalendar.currentCalendar().component(.Second, fromDate: self)
    }
    
    public func plusSeconds(s: Int) -> NSDate {
        return self.addComponentsToDate(seconds: s, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusSeconds(s: Int) -> NSDate {
        return self.addComponentsToDate(seconds: -s, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusMinutes(m: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: m, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusMinutes(m: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: -m, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusHours(h: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: h, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusHours(h: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: -h, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusDays(d: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: d, weeks: 0, months: 0, years: 0)
    }
    
    public func minusDays(d: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -d, weeks: 0, months: 0, years: 0)
    }
    
    public func plusWeeks(w: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: w, months: 0, years: 0)
    }
    
    public func minusWeeks(w: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -w, months: 0, years: 0)
    }
    
    public func plusMonths(m: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: m, years: 0)
    }
    
    public func minusMonths(m: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -m, years: 0)
    }
    
    public func plusYears(y: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: y)
    }
    
    public func minusYears(y: Int) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -y)
    }
    
    private func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> NSDate {
        let dc: NSDateComponents = NSDateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return NSCalendar.currentCalendar().dateByAddingComponents(dc, toDate: self, options: [])!
    }
    
    public func isGreaterThan(date: NSDate) -> Bool {
        return (self.compare(date) == .OrderedDescending)
    }
    
    public func isLessThan(date: NSDate) -> Bool {
        return (self.compare(date) == .OrderedAscending)
    }
    
    public class func secondsBetween(date1 d1:NSDate, date2 d2:NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: d1, toDate: d2, options:[])
        return dc.second
    }
    
    public class func minutesBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: d1, toDate: d2, options: [])
        return dc.minute
    }
    
    public class func hoursBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: d1, toDate: d2, options: [])
        return dc.hour
    }
    
    public class func daysBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: d1, toDate: d2, options: [])
        return dc.day
    }
    
    public class func weeksBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: d1, toDate: d2, options: [])
        return dc.weekOfYear
    }
    
    public class func monthsBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: d1, toDate: d2, options: [])
        return dc.month
    }
    
    public class func yearsBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: d1, toDate: d2, options: [])
        return dc.year
    }
    
    func toFormatString(format:String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
}
