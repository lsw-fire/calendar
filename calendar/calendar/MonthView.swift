//
//  MonthView.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 05/01/2017.
//  Copyright © 2017 lsw. All rights reserved.
//

import UIKit

class MonthView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private var allCells = Array<WeekCell>()
    
    var dayCells: Array<WeekCell>{
        get{
            return allCells
        }
    }
    
    func reloadCells(models:Array<DayModel?>) {
        
        
        for i in 0..<allCells.count {
            
            let dayCells = allCells[i].dayCells
            let dayCellsCount = dayCells.count
            
            for j in 0..<dayCellsCount
            {
                let cellIndex = (i * dayCellsCount) + j
                let cell = dayCells[j]
                cell.lbDay.text = ""
                cell.lbLunarDay.text = ""
                cell.lbSixtyName.text = ""
                
                if let model = models[cellIndex]{
                    cell.lbDay.text = model.day.description
                    cell.lbLunarDay.text = model.lunarDay
                    cell.lbSixtyName.text = model.solarTermText
                }
            }
            
        }
        
    }
    
    func setup() {
        
        var horizontalArrayView = Array<WeekCell>()
        for _ in 0...5 {
            
            let cell = loadViewFromNib()
            cell.translatesAutoresizingMaskIntoConstraints = false
            horizontalArrayView.append(cell)
            
//            cell.layer.borderColor = UIColor.orange.cgColor
//            cell.layer.borderWidth = 0.5
            
            allCells.append(cell)
        }
        
        let svhorizontal = UIStackView(arrangedSubviews: horizontalArrayView)
        
        svhorizontal.alignment = UIStackViewAlignment.fill
        svhorizontal.distribution = UIStackViewDistribution.fillEqually
        svhorizontal.axis = UILayoutConstraintAxis.vertical
        //svhorizontal.spacing = CGFloat(5)
        svhorizontal.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(svhorizontal)
        
        
        let hor = NSLayoutConstraint.constraints(withVisualFormat: "H:|[sv]|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["sv": svhorizontal])
        let vl = NSLayoutConstraint.constraints(withVisualFormat: "V:|[sv]|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["sv": svhorizontal])
        self.addConstraints(hor)
        self.addConstraints(vl)
        
    }
    
    func loadViewFromNib() -> WeekCell{
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WeekCell", bundle: bundle)
        let cell = nib.instantiate(withOwner: self, options: nil)[0] as! WeekCell
        
        return cell
    }
}
