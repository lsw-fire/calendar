//
//  DateSelectController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/12/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class DateSelectController: UIViewController {

   
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnLunarDate: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var selectedDate : NSDate!
    
    let highLightColorBtn = UIColor.orangeColor()
    let normalColorBtn = UIColor.darkGrayColor()
    
    let dateFormat = "yyyy年M月d日"
    let timeFormat = "HH:mm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nsLocal = NSLocale.init(localeIdentifier: "zh_CN")
        
        datePicker.date = selectedDate
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.locale = nsLocal
        
        timePicker.date = selectedDate
        timePicker.datePickerMode = UIDatePickerMode.Time
        timePicker.locale = nsLocal
        
        timePicker.hidden = true
        btnLunarDate.hidden = true
        
        btnDate.setTitle(selectedDate.toFormatString(dateFormat), forState: UIControlState.Normal)
        btnDate.setTitleColor(highLightColorBtn, forState: UIControlState.Normal)
        
        btnTime.setTitle(selectedDate.toFormatString(timeFormat), forState: UIControlState.Normal)
        btnTime.setTitleColor(normalColorBtn, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var dateSelectedAction:(NSDate -> Void)?
    
    @IBAction func datePickerTimeSelect(sender: AnyObject) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-M-d HH:mm"
        let dateStr = selectedDate.toFormatString("yyyy-M-d")
        let timeStr = timePicker.date.toFormatString("HH:mm")
        let date = formatter.dateFromString(dateStr + " " + timeStr)
        selectedDate = date
        dateSelectedAction?(selectedDate)
        
        btnTime.setTitle(selectedDate.toFormatString(timeFormat), forState: UIControlState.Normal)
    }
    @IBAction func dataPickerSelect(sender: AnyObject) {
        
        dateSelectedAction?(datePicker.date)
        selectedDate = datePicker.date
        
        btnDate.setTitle(selectedDate.toFormatString(dateFormat), forState: UIControlState.Normal)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnDateSelect(sender: AnyObject) {
        btnDate.setTitleColor(highLightColorBtn, forState: UIControlState.Normal)
        btnTime.setTitleColor(normalColorBtn, forState: UIControlState.Normal)
        datePicker.hidden = false
        timePicker.hidden = true
        
    }
    @IBAction func btnTimeSelect(sender: AnyObject) {
        btnTime.setTitleColor(highLightColorBtn, forState: UIControlState.Normal)
        btnDate.setTitleColor(normalColorBtn, forState: UIControlState.Normal)
        datePicker.hidden = true
        timePicker.hidden = false
    }

    @IBAction func btnLunarDateSelect(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
