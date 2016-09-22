//
//  SettingViewController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/18/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var sMonthRotation: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if ApplicationResource.sharedInstance.getMonthViewRotateDirection() == .horizontal {
            sMonthRotation.isOn = true
        }else{
            sMonthRotation.isOn = false
        }
         //self.navigationController?.navigationItem.title = ""
//        let bi = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingViewController.backAction))
//      
//       self.navigationItem.leftBarButtonItem = bi
        self.title = "设置"
        // Do any additional setup after loading the view.
    }
    
    func backAction()  {
        self.navigationController?.popViewController(animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sMonthRotationChanged(_ sender: AnyObject) {
        let btn = sender as! UISwitch
        if btn.isOn {
            ApplicationResource.sharedInstance.setMonthViewRotateDirection(.horizontal)
        }
        else{
            ApplicationResource.sharedInstance.setMonthViewRotateDirection(.vertical)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //self.navigationController?.navigationItem.title = "时间"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
