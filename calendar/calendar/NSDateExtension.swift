//
//  LunarCalendar.swift
//  calendar
//
//  Created by Li Shi Wei on 9/7/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit


extension Date {
    
    init(date: Date) {
        self.init(timeInterval:0, since: date )
    }
    
    init(year:Int!, month:Int!, day:Int!, hour:Int! = 0, min:Int! = 0, second:Int = 0) {
        
        if(year == nil || month == nil || day == nil)
        {
            self.init()
            return
        }
        let calendar = Calendar.current
        
        var dateComponent = DateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        dateComponent.hour = hour
        dateComponent.minute = min
        dateComponent.second = second
        
        self.init(timeInterval:0,since: calendar.date(from: dateComponent)!)
    }
    
    
    func getDateComponents() -> DateComponents {
        
        let calendar = Calendar.current
        
        let components = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: self)
        
        return components
    }
    
    public var dayOfWeek : Int {
        get{
            
            let myCalendar = Calendar.current
            let myComponents = (myCalendar as NSCalendar).components(.weekday, from: self)
            let weekDay = myComponents.weekday
            return weekDay!
        }
    }
    
    public var day: Int {
        return (Calendar.current as NSCalendar).component(.day, from: self)
    }
    
    public var month: Int {
        return (Calendar.current as NSCalendar).component(.month, from: self)
    }
    
    public var year: Int {
        return (Calendar.current as NSCalendar).component(.year, from: self)
    }
    
    public var hour: Int {
        return (Calendar.current as NSCalendar).component(.hour, from: self)
    }
    
    public var minute: Int {
        return (Calendar.current as NSCalendar).component(.minute, from: self)
    }
    
    public var second: Int {
        return (Calendar.current as NSCalendar).component(.second, from: self)
    }
    
    public func plusSeconds(_ s: Int) -> Date {
        return self.addComponentsToDate(seconds: s, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusSeconds(_ s: Int) -> Date {
        return self.addComponentsToDate(seconds: -s, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusMinutes(_ m: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: m, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusMinutes(_ m: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: -m, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusHours(_ h: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: h, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusHours(_ h: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: -h, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusDays(_ d: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: d, weeks: 0, months: 0, years: 0)
    }
    
    public func minusDays(_ d: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -d, weeks: 0, months: 0, years: 0)
    }
    
    public func plusWeeks(_ w: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: w, months: 0, years: 0)
    }
    
    public func minusWeeks(_ w: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -w, months: 0, years: 0)
    }
    
    public func plusMonths(_ m: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: m, years: 0)
    }
    
    public func minusMonths(_ m: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -m, years: 0)
    }
    
    public func plusYears(_ y: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: y)
    }
    
    public func minusYears(_ y: Int) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -y)
    }
    
    fileprivate func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> Date {
        var dc: DateComponents = DateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return (Calendar.current as NSCalendar).date(byAdding: dc, to: self, options: [])!
    }
    
    public func isGreaterThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedDescending)
    }
    
    public func isLessThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedAscending)
    }
    
    public static func secondsBetween(date1 d1:Date, date2 d2:Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.second, from: d1, to: d2, options:[])
        return dc.second!
    }
    
    public static func minutesBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.minute, from: d1, to: d2, options: [])
        return dc.minute!
    }
    
    public static func hoursBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.hour, from: d1, to: d2, options: [])
        return dc.hour!
    }
    
    public static func daysBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: d1, to: d2, options: [])
        return dc.day!
    }
    
    public static func weeksBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.weekOfYear, from: d1, to: d2, options: [])
        return dc.weekOfYear!
    }
    
    public static func monthsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.month, from: d1, to: d2, options: [])
        return dc.month!
    }
    
    public static func yearsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.year, from: d1, to: d2, options: [])
        return dc.year!
    }
    
    func toFormatString(_ format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
