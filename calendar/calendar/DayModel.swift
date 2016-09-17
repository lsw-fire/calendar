//
//  DayModel.swift
//  calendar
//
//  Created by Li Shi Wei on 9/5/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

struct DayModel {
    
    var day:Int
    var lunarDay: String
    var eraDay: (c: String, t: String)
    var formatDate: String
    var isCurrentMonth: Bool
    var isToday: Bool
    var isSelected: Bool
    var isSolarTerm: Bool
        {
        get{
            if solarTermText == nil || solarTermText.isEmpty {
                return false
            }
            return true
        }
    }
    var solarTermText: String!
    
    mutating func setIsSelected(_ isSelected:Bool) {
        self.isSelected = isSelected
    }
}
