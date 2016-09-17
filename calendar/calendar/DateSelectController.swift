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
    
    @IBOutlet weak var niRotateItem: UIBarButtonItem!
    @IBAction func niRotateDirection(_ sender: AnyObject) {
        if ApplicationResource.sharedInstance.getMonthViewRotateDirection() == .horizontal {
            ApplicationResource.sharedInstance.setMonthViewRotateDirection(.vertical)
            niRotateItem.title = "纵向"
        }
        else
        {
            ApplicationResource.sharedInstance.setMonthViewRotateDirection(.horizontal)
            niRotateItem.title = "横向"
        }
    }
    var selectedDate : Date!
    
    let highLightColorBtn = UIColor.orange
    let normalColorBtn = UIColor.darkGray
    
    let dateFormat = "yyyy年M月d日"
    let timeFormat = "HH:mm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if ApplicationResource.sharedInstance.getMonthViewRotateDirection() == .horizontal {
            niRotateItem.title = "横向"
        }
        else
        {
            niRotateItem.title = "纵向"
        }
        
        
        let nsLocal = Locale.init(identifier: "zh_CN")
        
        datePicker.date = selectedDate
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale = nsLocal
        
        timePicker.date = selectedDate
        timePicker.datePickerMode = UIDatePickerMode.time
        timePicker.locale = nsLocal
        
        timePicker.isHidden = true
        btnLunarDate.isHidden = true
        
        btnDate.setTitle(selectedDate.toFormatString(dateFormat), for: UIControlState())
        btnDate.setTitleColor(highLightColorBtn, for: UIControlState())
        
        btnTime.setTitle(selectedDate.toFormatString(timeFormat), for: UIControlState())
        btnTime.setTitleColor(normalColorBtn, for: UIControlState())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var dateSelectedAction:((Date) -> Void)?
    
    @IBAction func datePickerTimeSelect(_ sender: AnyObject) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d HH:mm"
        let dateStr = selectedDate.toFormatString("yyyy-M-d")
        let timeStr = timePicker.date.toFormatString("HH:mm")
        let date = formatter.date(from: dateStr + " " + timeStr)
        selectedDate = date
        dateSelectedAction?(selectedDate)
        
        btnTime.setTitle(selectedDate.toFormatString(timeFormat), for: UIControlState())
    }
    @IBAction func dataPickerSelect(_ sender: AnyObject) {
        
        dateSelectedAction?(datePicker.date)
        selectedDate = datePicker.date
        
        btnDate.setTitle(selectedDate.toFormatString(dateFormat), for: UIControlState())
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnDateSelect(_ sender: AnyObject) {
        btnDate.setTitleColor(highLightColorBtn, for: UIControlState())
        btnTime.setTitleColor(normalColorBtn, for: UIControlState())
        datePicker.isHidden = false
        timePicker.isHidden = true
        
    }
    @IBAction func btnTimeSelect(_ sender: AnyObject) {
        btnTime.setTitleColor(highLightColorBtn, for: UIControlState())
        btnDate.setTitleColor(normalColorBtn, for: UIControlState())
        datePicker.isHidden = true
        timePicker.isHidden = false
    }

    @IBAction func btnLunarDateSelect(_ sender: AnyObject) {
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
