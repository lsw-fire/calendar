//
//  CalendarViewController.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 05/01/2017.
//  Copyright © 2017 lsw. All rights reserved.
//

import UIKit

class CalendarViewController2: UIViewController {

    @IBOutlet weak var mv: CalendarMonthView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layoutIfNeeded()
        let frame = CGRect(x: 0, y: 0, width: mv.frame.width, height: mv.frame.height)
        
        mv.initView(frame: frame)
        //不加这句初始化有块空白
        automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
  
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
