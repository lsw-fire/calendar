//
//  MonthSource.swift
//  calendar
//
//  Created by Li Shi Wei on 9/9/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit


class MonthSource: NSObject {
    
    private var initialDate : NSDate
    
    lazy var calendar : NSCalendar = {
        
        //let cal = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        //cal.timeZone = NSTimeZone(abbreviation: "UTC")!
        let cal = NSCalendar.currentCalendar()
        return cal
    }()
    
    
    init(date: NSDate) {
        
        initialDate = date
        
        super.init()
    }
    
    func buildOneMonthSource(date: NSDate) -> Array<DayModel!> {
        var source = Array<DayModel!>()
        
        let currentDay = date.day
        let firstDate = NSDate(year: date.year, month: date.month, day: 1)
        let firstLunarDate = LunarDate(date: firstDate)
        
        //本月阳历1号所在的阴历月是几号，本月1号所在的阴历月一共多少天
        var numberOfLunarDaysInMonth = 0
        if firstLunarDate.isLeapMonth {
            numberOfLunarDaysInMonth = firstLunarDate.getChineseLeapMonthDays(firstLunarDate.lunarYear)
        }
        else
        {
            numberOfLunarDaysInMonth = firstLunarDate.getChineseMonthDays(firstLunarDate.lunarYear, firstLunarDate.lunarMonth)
        }
        
        //因为一个阳历月要显示42个格，所以农历月的总数量如果没超过42还要继续计算下一个农历月是阳历几号开始的
        
        
        let dayOfWeek = firstDate.dayOfWeek
        
        //dayOfWeek=1 周日
        //以周日为日历第一天
        //1,2,3,4,5,6,7 日一二三四五六
        //当周日为第一天的时候那么设置offsetDay=0天
        var offsetDay = 0
        
        if dayOfWeek == 1 {
            offsetDay = 0
        } else {
            offsetDay = 1 - dayOfWeek;
        }
        
        let firstEraDayIn42 = LunarSolarTerm(date: firstDate.plusDays(offsetDay))
        let firstEraIndexIn42 = firstEraDayIn42.getChineseEraOfDay()
        let pairSolarTerm = firstEraDayIn42.getSolarTerm(date.year, month: date.month)
        var dicSolarTerm : Dictionary<String,String> = Dictionary<String,String>()
        dicSolarTerm[pairSolarTerm.solarTerm1.solarTermDate.toFormatString("yyyy-M-d")] = pairSolarTerm.solarTerm1.name
        dicSolarTerm[pairSolarTerm.solarTerm2.solarTermDate.toFormatString("yyyy-M-d")] = pairSolarTerm.solarTerm2.name
        
        
        let numberOfDaysInMonth = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: firstDate).length
        
        //offsetDay 是计算出周日是不是在42个格里的头一个，
        //如果不是从当前日期往前挪几个格式月日历的星期日
        let absOffset = abs(offsetDay)
        
        //阳历一号的农历日期索引
        var lunarIndex = firstLunarDate.lunarDay
        
        var lunarNextMonthDate : LunarDate!
        
        for itemIndex in 0...41 {
            
            //天干地支文字根据42个格的第一个eraIndex算出本月的
            let eraIndex = getEraDayIndex(firstEraIndexIn42, offset: itemIndex)
            
            let dayNum = itemIndex - absOffset + 1
            
            if dayNum <= 0 {
                //先加空，回头改成上个月的日期
                source.append(nil)
            }
            else if dayNum > 0 && dayNum <= numberOfDaysInMonth
            {
                //农历已经到了下个月，从新计算转天农历所在的月有多少天
                if lunarIndex > numberOfLunarDaysInMonth && lunarNextMonthDate == nil{
                    
                    lunarNextMonthDate = LunarDate(date: firstDate.plusDays(itemIndex - absOffset))
                    
                    if lunarNextMonthDate.isLeapMonth {
                        numberOfLunarDaysInMonth = firstLunarDate.getChineseLeapMonthDays(lunarNextMonthDate.lunarYear)
                    }
                    else
                    {
                        numberOfLunarDaysInMonth = firstLunarDate.getChineseMonthDays(lunarNextMonthDate.lunarYear, lunarNextMonthDate.lunarMonth)
                    }
                    
                    //从新从初一开始新的农历月索引
                    lunarIndex = lunarNextMonthDate.lunarDay
                    
                }

                
                let eraTextTuple = firstEraDayIn42.getEraText(eraIndex)
                let eraText = eraTextTuple.c + eraTextTuple.t
                
                let lunarDayText = firstLunarDate.getLunarDayTextByValue(lunarIndex)
                lunarIndex += 1
                
                var formatDate = String(firstDate.year)
                    formatDate += "-"
                    formatDate += String(firstDate.month)
                    formatDate += "-"
                    formatDate += String(dayNum)
                
                let isToday = dayNum == currentDay
                
                var solarTermText = ""
                if dicSolarTerm.keys.contains(formatDate) {
                    solarTermText = dicSolarTerm[formatDate]!
                }
                
                source.append(DayModel(day: dayNum, lunarDay: lunarDayText, eraDay : eraText, formatDate: formatDate,
                    isCurrentMonth : true,
                    isToday : isToday,
                    isSelected : false,
                    solarTermText : solarTermText))
            }else
            {
                //先加空，回头改成下个月的日期
                source.append(nil)
            }
        }
        
        return source
    }
    
    func getEraDayIndex(eraIndex: Int, offset: Int) -> Int {
        if (eraIndex + offset) < 0
        {
            var value = eraIndex + offset;
            while (value < 0) {
                value = value + 59;
                break;
            }
            return value;
        }
        else
        {
            return eraIndex + offset;
        }
        
    }
    
}
