//
//  DateSelectController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/12/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit
import core
class DateSelectController: UIViewController, UIPopoverPresentationControllerDelegate  {

   
    @IBOutlet weak var vPopup: UIView!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnLunarDate: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var selectedDate : Date!
    
    let highLightColorBtn = UIColor.orange
    let normalColorBtn = UIColor.darkGray
    
    let dateFormat = "yyyy年M月d日"
    let timeFormat = "HH:mm"
    
    var closeController:(() -> Void)?
    var closeControllerWithUnselected:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.vPopup.backgroundColor = UIColor.white
        self.modalPresentationStyle = .custom
        self.vPopup.layer.cornerRadius = 5
        self.vPopup.layer.shadowOpacity = 0.8
        self.vPopup.layer.shadowOffset = CGSize(width: 0, height: 0)

        self.view.tintColor = UIColor.orange
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
  

    @IBAction func btnSelectTap(_ sender: Any) {
        closeController!()
    }
    
    @IBAction func btnCancelTap(_ sender: Any) {
        closeControllerWithUnselected!()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
        //self.navigationItem.title = ""
//        let backBarButtonItem = UIBarButtonItem()
//        backBarButtonItem.title = ""
//        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
}
