//
//  LunarDate.swift
//  calendar
//
//  Created by Li Shi Wei on 9/8/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class LunarDate :NSObject{
    
    private let minYear : Int = 1616
    private let minMonth : Int = 2
    private let minDay : Int = 17
    
    private let lunarDateArray : [Int] = [0x09b50,0x04b60,0x0aae4,0x0a4f0,0x05260,0x1d262,0x0d550,0x15a9a,0x056a0,0x096d0,
                                          0x149d6,0x049e0,0x0a4d0,0x0d4d4,0x0d250,0x0d53b,0x0b540,0x0b5a0,0x195a8,0x095b0,
                                          0x049b0,0x0a974,0x0a4b0,0x02a50,0x0ea51,0x06d40,0x0adbb,0x02b60,0x09370,0x04af6,
                                          0x04970,0x064b0,0x164a4,0x0da50,0x06b20,0x196c2,0x0ab60,0x192d6,0x092e0,0x0c960,
                                          0x1d155,0x0d4a0,0x0da50,0x15553,0x056a0,0x0a7a7,0x0a5d0,0x092d0,0x0aab6,0x0a950,
                                          0x0b4a0,0x0baa4,0x0ad50,0x055a0,0x18ba2,0x0a5b0,0x05377,0x052b0,0x06930,0x17155,
                                          0x06aa0,0x0ad50,0x05b53,0x04b60,0x0a5e8,0x0a4e0,0x0d260,0x0ea66,0x0d520,0x0daa0,
                                          0x166a4,0x056d0,0x04ae0,0x0a9d3,0x0a4d0,0x0d2b7,0x0b250,0x0d520,0x1d545,0x0b5a0,
                                          0x055d0,0x055b3,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x0b656,0x06d20,0x0ada0,0x05b64,
                                          0x09370,0x04970,0x06973,0x064b0,0x06aa7,0x0da50,0x05aa0,0x0aec5,0x0aae0,0x092e0,
                                          0x0d2e3,0x0c960,0x1d458,0x0d4a0,0x0d550,0x15956,0x056a0,0x0a6d0,0x055d4,0x052d0,
                                          0x0a950,0x1c953,0x0b4a0,0x1b4a7,0x0ad50,0x055a0,0x1a3a5,0x0a5b0,0x052b0,0x1a174,
                                          0x06930,0x06ab9,0x06aa0,0x0ab50,0x04f56,0x04b60,0x0a570,0x052e4,0x0d160,0x0e930,
                                          0x07523,0x0daa0,0x15aa7,0x056d0,0x04ae0,0x1a1d5,0x0a2d0,0x0d150,0x0da54,0x0b520,
                                          0x0d6a9,0x0ada0,0x055d0,0x129b6,0x045b0,0x0a2b0,0x0b2b5,0x0a950,0x0b520,0x1ab22,
                                          0x0ad60,0x15567,0x05370,0x04570,0x06575,0x052b0,0x06950,0x07953,0x05aa0,0x0ab6a,
                                          0x0a6d0,0x04ae0,0x0a6e6,0x0a560,0x0d2a0,0x0eaa5,0x0d550,0x05aa0,0x0b6a3,0x0a6d0,
                                          0x04bd7,0x04ab0,0x0a8d0,0x0d555,0x0b2a0,0x0b550,0x05d54,0x04da0,0x095d0,0x05572,
                                          0x049b0,0x0a976,0x064b0,0x06a90,0x0baa4,0x06b50,0x02ba0,0x0ab62,0x09370,0x052e6,
                                          0x0d160,0x0e4b0,0x06d25,0x0da90,0x05b50,0x036d3,0x02ae0,0x0a2e0,0x0e2d2,0x0c950,
                                          0x0d556,0x0b520,0x0b690,0x05da4,0x055d0,0x025d0,0x0a5b3,0x0a2b0,0x1a8b7,0x0a950,
                                          0x0b4a0,0x1b2a5,0x0ad50,0x055b0,0x02b74,0x02570,0x052f9,0x052b0,0x06950,0x06d56,
                                          0x05aa0,0x0ab50,0x056d4,0x04ae0,0x0a570,0x14553,0x0d2a0,0x1e8a7,0x0d550,0x05aa0,
                                          0x0ada5,0x095d0,0x04ae0,0x0aab4,0x0a4d0,0x0d2b8,0x0b290,0x0b550,0x05757,0x02da0,
                                          0x095d0,0x04d75,0x049b0,0x0a4b0,0x1a4b3,0x06a90,0x0ad98,0x06b50,0x02b60,0x19365,
                                          0x09370,0x04970,0x06964,0x0e4a0,0x0ea6a,0x0da90,0x05ad0,0x12ad6,0x02ae0,0x092e0,
                                          0x0cad5,0x0c950,0x0d4a0,0x1d4a3,0x0b690,0x057a7,0x055b0,0x025d0,0x095b5,0x092b0,
                                          0x0a950,0x0d954,0x0b4a0,0x0b550,0x06b52,0x055b0,0x02776,0x02570,0x052b0,0x0aaa5,
                                          0x0e950,0x06aa0,0x0baa3,0x0ab50,
                                          
                                          0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
                                          0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
                                          0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
                                          0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
                                          0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
                                          
                                          0x06ca0,0x0b550,0x15355,0x04da0,0x0a5b0,0x14573,0x052b0,0x0a9a8,0x0e950,0x06aa0,
                                          0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
                                          0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b6a0,0x195a6,
                                          0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,
                                          0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
                                          
                                          0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,
                                          0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
                                          0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,
                                          0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
                                          0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0,
                                          
                                          0x04b63,0x0937f,0x049f8,0x04970,0x064b0,0x068a6,0x0ea5f,0x06b20,0x0a6c4,0x0aaef,
                                          0x092e0,0x0d2e3,0x0c960,0x0d557,0x0d4a0,0x0da50,0x05d55,0x056a0,0x0a6d0,0x055d4,
                                          0x052d0,0x0a9b8,0x0a950,0x0b4a0,0x0b6a6,0x0ad50,0x055a0,0x0aba4,0x0a5b0,0x052b0,
                                          0x0b273,0x06930,0x07337,0x06aa0,0x0ad50,0x04b55,0x04b6f,0x0a570,0x054e4,0x0d260,
                                          0x0e968,0x0d520,0x0daa0,0x06aa6,0x056df,0x04ae0,0x0a9d4,0x0a4d0,0x0d150,0x0f252,
                                          0x0d520]
    
    func getMinLunarDate() -> NSDate {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let dateComponent = NSDateComponents()
        //dateComponent.timeZone = NSTimeZone(abbreviation: "CST")
        dateComponent.year = minYear
        dateComponent.month = minMonth
        dateComponent.day = minDay
        dateComponent.hour = 0
        dateComponent.minute = 0
        
        let date = calendar!.dateFromComponents(dateComponent)
        return date!
    }
    
    func checkDateLimit(date: NSDate) -> Bool {
        let maxDate = NSDate(year: minYear + lunarDateArray.count, month: minMonth, day: minDay)
        
        if date.isLessThan(getMinLunarDate()) || date.isGreaterThan(maxDate)
        {
            return false
        }
        else
        {
            return true
        }
    }
    //var getLunarYear : Int { get { return lunarYear} }
    
    private (set) var lunarYear: Int = 0
    public private (set) var lunarMonth: Int = 0
    private (set) var lunarDay:Int = 0
    var isLeapMonth: Bool = false
    
    init(_ lunarYear:Int, _ lunarMonth:Int, _ lunarDay:Int, _ isLeapMonth: Bool) {
        self.lunarYear = lunarYear
        self.lunarMonth = lunarMonth
        self.lunarDay = lunarDay
        self.isLeapMonth = isLeapMonth
    }
    
    init(date: NSDate){
        
        super.init()
        
        //修正时间如果是0点0分，会计算少一天(Android复制过来的，应该测试一下）
        if(date.hour == 0 && date.minute == 0)
        {
            date.plusSeconds(1)
        }
        
        var minYear : Int  { get { return self.minYear }}
        var leap : Int
        var temp : Int
        var offset : Int
        
        let minDate = getMinLunarDate()
        
        if self.checkDateLimit(date)
        {
            temp = 0
            
            //计算最小日期到计算日期的差距
            offset = NSDate.daysBetween(date1: minDate, date2: date)
            
            let maxYear = minYear + lunarDateArray.count
            
            var yearNum = 0
            
            for i in minYear ... maxYear+1
            {
                yearNum = i
                temp = getChineseYearDays(i)
                if offset - temp < 1
                {
                    break;
                }
                else
                {
                    offset = offset - temp;
                }
                
                //print(offset)
            }
            
            self.lunarYear = yearNum
            
            leap = getChineseLeapMonth(self.lunarYear)
            
            var isLeapMonth = false
            
            
            var j = 1
            while j <= 12 {
                if (leap > 0) && (j==leap+1) && (!isLeapMonth)
                {
                    isLeapMonth = true
                    j = j - 1
                    temp = getChineseLeapMonthDays(self.lunarYear)
                }
                else
                {
                    isLeapMonth = false
                    temp = getChineseMonthDays(self.lunarYear, j)
                }
                
                offset = offset - temp
                if offset <= 0
                {
                    break
                }
                j += 1
            }
            
            offset = offset + temp
            self.isLeapMonth = isLeapMonth
            self.lunarMonth = j
            self.lunarDay  = offset
            
        }
        
    }
    
    private func getChineseYearDays(year : Int) -> Int {
        var i, f, sumDay, info : Int
        
        sumDay = 348 //29天x12个月
        
        i = 0x8000
        
        info = lunarDateArray[year - minYear] & 0x0FFFF
        
        for _ in 0...11
        {
            f = info & i
            
            if f != 0
            {
                sumDay += 1
            }
            i = i >> 1
        }
        
        return sumDay + getChineseLeapMonthDays(year)
    }
    
    func getChineseLeapMonthDays(year : Int) -> Int {
        
        if getChineseLeapMonth(year) != 0 {
            
            if(lunarDateArray[year - minYear] & 0x10000) != 0{
                return 30
            }
            else{
                return 29
            }
        }
        else
        {
            return 0
        }
    }
    
    func getChineseLeapMonth(year: Int) -> Int {
        return lunarDateArray[year-minYear] & 0xF
    }
    
    func getChineseMonthDays(year: Int, _ month: Int) -> Int {
        
        if bitTest32(lunarDateArray[year - minYear] & 0x0000FFFF, bitPosition: (16-month))
        {
            return 30
        }
        else
        {
            return 29
        }
    }
    
    private func bitTest32(num: Int, bitPosition: Int) -> Bool {
        if(bitPosition > 31) || (bitPosition < 0)
        {
            _ = "Error Param: bitpositon[0-31]:" + String(bitPosition)
            //print(error)
        }
        //throw exception
        
        let bit = 1 << bitPosition
        
        if(num & bit) == 0
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    func getDate() throws -> NSDate
    {
        var minYear, leapMonth, temp, offset : Int
        
        try checkChineseDateLimit(self.lunarYear, month: self.lunarMonth, day: self.lunarDay, isLeapMonth: self.isLeapMonth)
        
        offset = 0
        
        minYear = self.minYear
        
        for i in minYear...lunarYear-1
        {
            temp = getChineseYearDays(i)
            offset = offset + temp
        }
        
        leapMonth = getChineseLeapMonth(lunarYear)
        
        var haveLeapMonth : Bool
        
        if leapMonth != 0{
            haveLeapMonth = true
        }
        else{
            haveLeapMonth = false
        }
        
        var isLeapMonth : Bool
        if lunarMonth != leapMonth
        {
            isLeapMonth = false
        }
        else
        {
            isLeapMonth = self.isLeapMonth
        }
        
        if !haveLeapMonth || lunarMonth < leapMonth{
            
            for i in 1...lunarMonth-1
            {
                temp = getChineseMonthDays(lunarYear,  i)
                offset = offset + temp
            }
            
            let monthDays = getChineseMonthDays(lunarMonth, lunarMonth)
            if lunarDay > monthDays
            {
                throw ErrorChieseDateValidation.InvalidLunarDay(minDay: 1, maxDay: monthDays)
            }
            offset = offset + lunarDay
        }
        else
        {
            for i in 1...lunarMonth-1
            {
                temp = getChineseMonthDays(lunarYear, i)
                offset = offset + temp
            }
            
            if lunarMonth > leapMonth
            {
                temp = getChineseLeapMonthDays(lunarYear)
                offset = offset + temp
                
                let monthDays = getChineseMonthDays(lunarYear, lunarDay)
                
                if lunarDay > monthDays
                {
                    throw ErrorChieseDateValidation.InvalidLunarDay(minDay: 1, maxDay: monthDays)
                }
                offset = offset + lunarDay
            }
            else
            {
                if isLeapMonth
                {
                    temp = getChineseMonthDays(lunarYear, lunarMonth)
                    offset = offset + temp
                }
                
                let monthDays = getChineseLeapMonthDays(lunarYear)
                if lunarDay > monthDays
                {
                    throw ErrorChieseDateValidation.InvalidLunarDay(minDay: 1, maxDay: monthDays)
                }
                
                offset = offset + lunarDay
            }
        }
        
        let date = getMinLunarDate().plusDays(offset)
        
        return date
    }
    
    private func checkChineseDateLimit(year : Int, month: Int, day:Int, isLeapMonth: Bool) throws
    {
        let maxYear = lunarDateArray.count + minYear
        
        if year < minYear || year > maxYear
        {
            throw ErrorChieseDateValidation.InvalidLunarYear(minYear: minYear, maxYear: maxYear)
        }
        
        if month < 1 || month > 12
        {
            throw ErrorChieseDateValidation.InvalidLunarMonth(mintMonth: 1, maxMonth: 12)
        }
        
        if day < 1 || day > 30
        {
            throw ErrorChieseDateValidation.InvalidLunarDay(minDay: 1, maxDay: 30)
        }
        
        let leapMonth = getChineseLeapMonth(year)
        if isLeapMonth && leapMonth != month
        {
            throw ErrorChieseDateValidation.InvalidLeapMonth(currentYear: year, leapMonth: leapMonth)
        }
    }
    
    enum ErrorChieseDateValidation: ErrorType {
        case InvalidLunarYear(minYear: Int, maxYear: Int)
        case InvalidLunarMonth(mintMonth: Int, maxMonth:Int)
        case InvalidLunarDay(minDay:Int, maxDay:Int)
        case InvalidLeapMonth(currentYear:Int, leapMonth:Int)
        
    }
    
    private let lunarMonthTextArray : [String] = ["正","二","三","四","五","六","七","八","九","十","十一","腊"]
    
    func getLunarMonthTextByValue(value:Int) -> String {
        return lunarMonthTextArray[value-1]
    }
    
    var lunarMonthText : String
        {
        get
        {
            return getLunarMonthTextByValue(lunarMonth)
        }
    }
    
    private let lunarDayTextArray1 : [String] = ["一","二","三","四","五","六","七","八","九"]
    private let lunarDayTextArray2 : [String] = ["初","十","廿","卅"]
    
    var lunarDayText : String
        {
        get
        {
            return getLunarDayTextByValue(lunarDay)
        }
    }
    
    func getLunarDayTextByValue(value:Int) -> String {
        switch value {
        case 0:
            return ""
        case 10:
            return "初十"
        case 20:
            return "二十"
        case 30:
            return "三十"
        default:
            return lunarDayTextArray2[value/10] + lunarDayTextArray1[value%10-1]
        }

    }
    
    private let lunarYearTextArray : [String] = ["零","一","二","三","四","五","六","七","八","九"]
    
    var lunarYearText: String
        {
        get{
            var str : String = ""
            let yearChars = Array(String(lunarYear).characters)
            for item in yearChars {
                if let index = Int(String(item)){
                    if index >= 0 || index <= 9
                    {
                        str += lunarYearTextArray[index]
                    }
                }
            }
            
            return str
        }
    }
}
