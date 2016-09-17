//
//  LunarSolarTerm.swift
//  calendar
//
//  Created by Li Shi Wei on 9/9/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit
import Foundation

class LunarSolarTerm: LunarDate {
    
    let lunarHolidayName : [String] = ["小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至","小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪", "冬至" ]
    
    let celestialStemName : String = "癸甲乙丙丁戊己庚辛壬"
    let terrestialBranchName : String = "亥子丑寅卯辰巳午未申酉戌"
    
    func getCelestialStemText(x:Int) -> String {
        let index = x%10
        return celestialStemName.substringWithRange(Range<String.Index>(celestialStemName.startIndex.advancedBy(index) ..< celestialStemName.startIndex.advancedBy(index + 1)))
    }
    
    func getTerrestrialBranchText(x:Int) -> String {
        let index = x%12
        return terrestialBranchName.substringWithRange(Range<String.Index>(terrestialBranchName.startIndex.advancedBy(index) ..< terrestialBranchName.startIndex.advancedBy(index+1)))
    }
    
    func getEraText(x:Int) -> (c:String,t:String) {
        return (getCelestialStemText(x),getTerrestrialBranchText(x))
    }
    
    func getEraYearText() -> (c:String,t:String) {
        let eraYear = getChineseEraOfYear()
        return getEraText(eraYear)
    }
    
    func getEraMonthText() -> (c:String,t:String) {
        let eraMonth = getChineseEraOfMonth()
        return getEraText(eraMonth)
    }
    
    func getEraDayText() -> (c:String,t:String) {
        let eraDay = getChineseEraOfDay()
        return getEraText(eraDay)

    }
    
    func getEraHourText() -> (c:String,t:String) {
        let eraHour = getChineseEraOfHour()
        return getEraText(eraHour)

    }
    
    private var date : NSDate
    
    override init(date: NSDate) {
        self.date = date
        super.init(date: self.date)
    }
    
    func getChineseEraOfYear() -> Int {
        var g = (self.date.year - 4) % 60
        
        let dayDifferent = self.dayDifferent(self.date.year, month: self.date.month, day: self.date.day) + self.date.hour/24
        
        if Double(dayDifferent) < term(self.date.year, n: 3, pd: true)
        {
            g-=1
        }
        return g+1
    }
    
    func getChineseEraOfMonth() -> Int {
        var v = (self.date.year * 12 + self.date.month + 12)%60
        let day = self.date.day
        if day <  getSolarTerm(self.date.year, month: self.date.month).solarTerm1.solarTermDate.day
        {
            v-=1
        }
        return v+1
    }
    
    func getChineseEraOfDay() -> Int {
        let gzD = equivalentStandardDay(self.date.year, month: self.date.month, day: self.date.day)
        
        //let gzDWith15 = Int(gzD) + 15
        
        return Int(round(rem(gzD + 15, w: 60)))
    }
    
    func getChineseEraOfHour() -> Int {
        let v = Double(12 * gan(getChineseEraOfDay())) + floor((Double(self.date.hour + 1)/2)) - 11
   
        return Int(round(rem(v, w: 60)))
    }
    
    func getSolarTerm(year:Int, month:Int) -> (solarTerm1 : SolarTerm, solarTerm2: SolarTerm) {
        var solarTermArray = Array<SolarTerm>()
        
        let begin = month * 2 - 1
        let end = month * 2
        
        for i in begin ... end {
            
            let dd = Double(term(year, n: i, pd: true))
            let sd1 = antiDayDifferent(year, x: floor(dd))
            let sHour = Int(floor(tail(dd)*24))
            let sMin = Int(floor((tail(dd)*24 - Double(sHour))*60))
            let sMonth = Int(ceil(Double(i)/2))
            let sDay = Int(sd1%100)
            
            let date = NSDate(year:year,month: sMonth,day: sDay, hour: sHour, min: sMin)
            
            let solarTerm = SolarTerm(solarTermDate: date, name: lunarHolidayName[i-1])
            
            solarTermArray.insert(solarTerm, atIndex: i - month*2 + 1)

        }
        
        return (solarTermArray[0],solarTermArray[1])
    }
    
    func gan(x:Int) -> Int {
        return x%10
    }
    
    func rem(x: Double, w: Double) -> Double {
        return tail(x/w) * w
    }
    
    func tail(x: Double) -> Double {
        return x-floor(x)
    }
    
    func antiDayDifferent(year:Int, x: Double) -> Double {
        var tempX = x
        var m = 1
        for j in 1...12 {
            let ml = dayDifferent(year, month: j+1, day: 1) - dayDifferent(year, month: j, day: 1)
            if (tempX < Double(ml)) || j == 12
            {
                m = j
                break
            }
            else
            {
                tempX -= Double(ml)
            }
        }
        return 100 * Double(m) + tempX
    }
    
    func dayDifferent(year: Int, month: Int, day:Int) -> Int {
        let ifG = ifGregorian(year, month: month, day: day, opt: 1)
        var monthDays : [Int] = [0,31,28,31,30,31,30,31,31,30,31,30,31]
        if ifG == 1 {
            if year%100 != 0 && year%4==0 || year%400 == 0
            {
                monthDays[2] += 1
            }
            else if year%4 == 0
            {
                monthDays[2] += 1
            }
        }
        
        var v = 0
        for i in 0...month-1 {
            v += monthDays[i]
        }
        v += day
        
        if year == 1582 {
            if ifG == 1 {
                v -= 10
            }
            if ifG == -1 {
                v = 0
            }
        }
        
        return v
    }
    
    func ifGregorian(year: Int, month: Int, day:Int, opt:Int) -> Int {
        if opt == 1
        {
            if year > 1582 || (year == 1582 && month > 10) || (year==1582 && month == 10 && day > 14)
            {
                return 1
            }
            else if year == 1582 && month == 10 && day > 5 && day <= 14
            {
                return -1
            }
            else
            {
                return 0
            }
        }
        
        if opt == 2
        {
            return 1 //Gregorian
        }
        if opt == 3 {
            return 0 //Julian
        }
        
        return -1
    }
    
    func term(year:Int, n: Int, pd: Bool) -> Double
    {
        let yearMin100 = Double(year) - 100
        let doubleYearMin100 = yearMin100 * yearMin100
        let middleJud = 365.2423112 - 6.4e-14 * doubleYearMin100 - 3.047e-8 * yearMin100
        let juD = Double(year) * (middleJud) + 15.218427 * Double(n) + 1721050.71301//儒略日
        let tht = 3e-4 * Double(year) - 0.372781384 - 0.2617913325 * Double(n)//角度
        
        let yrDBegin = (1.945 * sin(tht) - 0.01206 * sin(2 * tht))
        let yrD =  yrDBegin * (1.048994 - 2.583e-5 * Double(year))//年差实均数
        let shuoD = -18e-4 * sin(2.313908653 * Double(year) - 0.439822951 - 3.0443 * Double(n))//朔差实均数
        let vs = (pd) ?
            (juD + yrD + shuoD - equivalentStandardDay(year, month: 1, day: 0) - 1721425) :
            (juD - equivalentStandardDay(year, month: 1, day: 0) - 1721425)
        return vs;
    }
    
    func equivalentStandardDay(year: Int, month:Int, day:Int) -> Double {
        let doubleYear = Double(year)
        let differentDay = Double(dayDifferent(year, month: month, day: day))
        var v = (doubleYear-1)*365
            v = v + floor((doubleYear-1)/4)
            v = v + differentDay - 2
        //Julian
        if year > 1582 {
            v = v - floor((doubleYear-1)/100)
            v = v + floor((doubleYear-1)/400) + 2
        }
        return v
    }
}

struct SolarTerm {
    var solarTermDate : NSDate
    var name : String
}
