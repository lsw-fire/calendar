//
//  DateSelectController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/12/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class DateSelectController: UIViewController {

   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var selectedDate : NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nsLocal = NSLocale.init(localeIdentifier: "zh_CN")
        
        datePicker.date = selectedDate
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.locale = nsLocal
        
        timePicker.date = selectedDate
        timePicker.datePickerMode = UIDatePickerMode.Time
        timePicker.locale = nsLocal
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
        dateSelectedAction?(date!)
        
    }
    @IBAction func dataPickerSelect(sender: AnyObject) {
        
        dateSelectedAction?(datePicker.date)
        selectedDate = datePicker.date
        //self.dismissViewControllerAnimated(true, completion: nil)
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
