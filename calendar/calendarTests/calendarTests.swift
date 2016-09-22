//
//  calendarTests.swift
//  calendarTests
//
//  Created by dev on 11/19/15.
//  Copyright © 2015 lsw. All rights reserved.
//

import XCTest
@testable import calendar

class calendarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMonthSource() {
        let source = MonthSource(date: Date())
        let result = source.buildOneMonthSource(Date(year: 2017,month: 1,day: 5))
        print(result)
    }
    
    func testMinDate() {
//        let c = NSDate()
//        let mDate = LunarDate(date: c)
//        
//        let dateFormatter = NSDateFormatter()
//        let dateAsString = "17-02-1616 00:00"
//        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        //var newDate = dateFormatter.dateFromString(dateAsString)
        
        //let str = dateFormatter.stringFromDate(mDate)
        //XCTAssert(str == dateAsString)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDayOfWeek() {
        let date = Date(year: 2016,month: 9,day: 9)
        print(date.dayOfWeek)
        
        XCTAssert(date.dayOfWeek == 6)
    }
    
    func testNSDateInitializer() {
        
        let c = Date(year: 1982,month: 12,day: 16)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let str = dateFormatter.string(from: c)
        
        var lunarDate = LunarDate(paramDate: c)
       
       
        do
        {
        var lunar = LunarDate(1982,11,2,false)
            
            //var de = try LunarDate(1982,11,2,false)
            let s = try dateFormatter.string(from: lunar.getDate())
            
            print(s)
            
            
            print(lunar.lunarYearText)
            print(lunar.lunarMonthText)
            print(lunar.lunarDayText)
            
            let testDate = Date(year: 1982,month: 12,day: 16, hour: 6, min: 5)
            
            let st = LunarSolarTerm(paramDate: testDate)
            
            print(st.getEraYearText())
            print(st.getEraMonthText())
            print(st.getEraDayText())
            print(st.getEraHourText())
            
        }
        catch
        {
            
        }
        //XCTAssert(str == "01-01-2001")

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
