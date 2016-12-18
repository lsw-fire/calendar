//
//  SelfTrigramViewController.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 18/12/2016.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit
import core

class SelfTrigramViewController: UIViewController {
    
    @IBOutlet weak var scGender: UISegmentedControl!
    @IBOutlet weak var lbDateSelected: UILabel!
    @IBOutlet weak var selfTrigramView: TrigramViewContainer!
    
    var selectedDate: Date!
    var isMale = true
    
    let defaultTrigrams = ["巽","离","坤","震","","兑","艮","坎","乾"]
    let trigramsMapping : Dictionary<String,String> = ["巽":"风","离":"火","坤":"地","震":"雷",
                                                       "兑":"泽","艮":"山","坎":"水","乾":"天"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bi = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action:nil)
        self.navigationItem.backBarButtonItem = bi

        scGender.selectedSegmentIndex = 0
        //selectedDate = Date(year: 1982, month: 12, day: 16)
        loadContent()
        
        self.view.tintColor = UIColor.orange
        self.title = "本命卦"
    }
    
    func loadContent() {
        let ziBai = ZiBaiGenerator(date: selectedDate, isMale: isMale)
        let selfTrigram = ziBai.calculateSelfTrigram()
        
        for i in 0..<selfTrigramView.cells.count {
            selfTrigramView.cells[i].trigramName = defaultTrigrams[i]
            
            let selfTrigramName = selfTrigram?.0
            let d = defaultTrigramList[trigramsMapping[selfTrigramName!]!]
            if !defaultTrigrams[i].isEmpty {
                let t = defaultTrigramList[trigramsMapping[defaultTrigrams[i]]!]
                
                let m = ZiBaiGenerator.getPositionName(from: d!, to: t!)
                
                selfTrigramView.cells[i].baZhaPositionName = m.rawValue
                selfTrigramView.cells[i].trigramDirection = t!.positonName
            }else{
                selfTrigramView.cells[i].baZhaPositionName = "本命"
                selfTrigramView.cells[i].trigramName = selfTrigramName!
                selfTrigramView.cells[i].trigramDirection = ""
            }
        }
        
        lbDateSelected.text = selectedDate.toFormatString("yyyy年M月d日")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scGenderChange(_ sender: Any) {
        
        let index = scGender.selectedSegmentIndex
        if index != 0 {
            isMale = false
        }else{
            isMale = true
        }
        
        loadContent()
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
