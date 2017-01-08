//
//  MonthViewController.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 05/01/2017.
//  Copyright © 2017 lsw. All rights reserved.
//

import UIKit
import core

class CalendarMonthView: UIView , UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    let month = MonthSource(date:Date())
    var selectedDate: Date = Date()
    
    var monthViews: [EnumMonthIdentifier: MonthView] = [EnumMonthIdentifier:MonthView]()
    
    func initView(frame: CGRect) {
        
        scrollView = UIScrollView(frame: frame)
        scrollView.contentSize = CGSize(width: frame.width, height: (frame.height * 3))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.masksToBounds = true
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        let model = getSource(selectedDate)
        
        for i in 0...2{
            let y = frame.height*CGFloat(i)
            let frame = CGRect(x: 0, y: y, width: frame.width, height: frame.height)
            let index = EnumMonthIdentifier(rawValue:i)!
            let dayModels = model[index]
            let currentMonthView = getMonthView(models: dayModels!, frame: frame)
            monthViews[index] = currentMonthView
            scrollView.addSubview(monthViews[index]!)
            
            currentMonthView.alignmentRectInsets
        }
        
    
       
        scrollView.contentOffset.y = frame.height
        //scrollView.bounces = false
        addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getMonthView(models:Array<DayModel?>, frame:CGRect) -> MonthView {
        
        let currentMonthView = MonthView(frame: frame)
        currentMonthView.reloadCells(models: models)
        return currentMonthView
    }
    
    func getSource(_ date: Date) -> Dictionary<EnumMonthIdentifier,Array<DayModel?>>
    {
        var dic = Dictionary<EnumMonthIdentifier,Array<DayModel?>>()
        
        let pre = month.buildOneMonthSource(date.plusMonths(-1))
        let current = month.buildOneMonthSource(date)
        let next = month.buildOneMonthSource(date.plusMonths(1))
        
        dic.updateValue(pre, forKey: EnumMonthIdentifier.before)
        dic.updateValue(current, forKey: EnumMonthIdentifier.current)
        dic.updateValue(next, forKey: EnumMonthIdentifier.next)
        
        return dic
    }
    
    

    enum EnumMonthIdentifier : Int {
        case before = 0;
        case current = 1;
        case next = 2;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.calculateDateBasedOnScrollViewPosition(scrollView)
    }
    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        self.calculateDateBasedOnScrollViewPosition(scrollView)
//    }
    var contentOffsetY = CGFloat(0)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetY = scrollView.contentOffset.y
        print(contentOffsetY)
    }
    
    func calculateDateBasedOnScrollViewPosition(_ scrollView: UIScrollView) {
        
        let frame = scrollView.frame
//        let y = frame.height * CGFloat(2)
//        
//        scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: false)
        
        let cvbounds = scrollView.bounds
        
        let rotateDirection = ApplicationResource.sharedInstance.getMonthViewRotateDirection()
        
        var page = Int(floor(self.scrollView.contentOffset.x / cvbounds.size.width))
        if rotateDirection != .horizontal
        {
            page = Int(floor(self.scrollView.contentOffset.y / cvbounds.size.height))
        }
        
        page = page > 0 ? page : 0
        
        if page == 2 {
            monthViews[EnumMonthIdentifier.before]?.removeFromSuperview()
            monthViews[EnumMonthIdentifier.before] = monthViews[EnumMonthIdentifier.current]
            monthViews[EnumMonthIdentifier.current] = monthViews[EnumMonthIdentifier.next]
            
            
            
            let models = month.buildOneMonthSource(selectedDate.plusMonths(2))
            
            let currentMonthView = MonthView(frame: frame)
            currentMonthView.frame.origin.y = frame.height * CGFloat(2)
            currentMonthView.reloadCells(models: models)
            monthViews[EnumMonthIdentifier.next] = currentMonthView
            scrollView.insertSubview(currentMonthView, at: EnumMonthIdentifier.next.rawValue)
           
            
            monthViews[EnumMonthIdentifier.before]?.frame.origin.y = frame.height * CGFloat(0)
            monthViews[EnumMonthIdentifier.current]?.frame.origin.y = frame.height * CGFloat(1)

            var monthViewFrame = frame
            monthViewFrame.origin.y = monthViewFrame.height * CGFloat(1)
            scrollView.scrollRectToVisible(monthViewFrame, animated: false)
        }
        if page == 0 {
            
        }
//        if rotateDirection == .horizontal {
//            scrollView.contentOffset.x = scrollView.frame.size.width
//        }
//        else
//        {
            //scrollView.contentOffset.y = scrollView.frame.size.height * CGFloat(page)
        //}
    }

    
}
