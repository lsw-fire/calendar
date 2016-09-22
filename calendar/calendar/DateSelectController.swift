//
//  DateSelectController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/12/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class DateSelectController: UIViewController, UIPopoverPresentationControllerDelegate  {

   
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnLunarDate: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var niRotateItem: UIBarButtonItem!
    @IBAction func niRotateDirection(_ sender: AnyObject) {
        
        let settingViewController = self.storyboard!.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        

        self.navigationController?.pushViewController(settingViewController, animated: true)

        
//        var popoverContent = (self.storyboard?.instantiateViewController(withIdentifier: "monthViewController"))! as    UIViewController
//        popoverContent.preferredContentSize = CGSize(width: 100, height: 100)
//        popoverContent.modalPresentationStyle = .popover
//        
//        let popController = popoverContent.popoverPresentationController
//        popController?.delegate = self
//        //popController?.sourceView = sender as! UIView
//        popController?.permittedArrowDirections = .any
//        popController?.barButtonItem = sender as! UIBarButtonItem
//        popController?.sourceRect = CGRect(x: 100, y: 100, width: 0, height: 0)

            
        //var nav = UINavigationController(rootViewController: popoverContent)
        //nav.modalPresentationStyle = .popover
        //var popover = nav.popoverPresentationController
        //
            //
        //self.present(popoverContent, animated: true, completion: nil)
    }
    
    //popoverPresentationController iphone 上必须重写此方法
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    var selectedDate : Date!
    
    let highLightColorBtn = UIColor.orange
    let normalColorBtn = UIColor.darkGray
    
    let dateFormat = "yyyy年M月d日"
    let timeFormat = "HH:mm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         //self.navigationController?.navigationBar.topItem?.title = ""
         let bi = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action:nil)
        
        self.navigationItem.backBarButtonItem = bi
        
//        let item=UIBarButtonItem(title: "分享", style: .plain, target: self, action: nil)
//        
//        self.navigationItem.leftBarButtonItem = item
         //self.navigationController?.navigationItem.title = ""
        self.title = "时间"
        
        if ApplicationResource.sharedInstance.getMonthViewRotateDirection() == .horizontal {
            //niRotateItem.title = "横向"
        }
        else
        {
            //niRotateItem.title = "纵向"
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
        //self.navigationItem.title = ""
//        let backBarButtonItem = UIBarButtonItem()
//        backBarButtonItem.title = ""
//        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //self.navigationController?.navigationBar.topItem?.title = ""

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        
    }
}
