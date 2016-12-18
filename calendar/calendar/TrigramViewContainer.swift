//
//  TrigramViewContainer.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 18/12/2016.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

@IBDesignable class TrigramViewContainer: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private var allCells = Array<TrigramViewCell>()
    
    var cells: Array<TrigramViewCell>{
        get{
            return allCells
        }
    }
    
    func setup() {
      
        var verticalArrayView = Array<UIStackView>()
        
        for _ in 0...2{
            
            var horizontalArrayView = Array<TrigramViewCell>()
            for _ in 0...2 {
                
                let cell = loadViewFromNib()
                cell.translatesAutoresizingMaskIntoConstraints = false
                horizontalArrayView.append(cell)
                
                cell.layer.borderColor = UIColor.orange.cgColor
                cell.layer.borderWidth = 0.5
                
                allCells.append(cell)
            }
            
            let svhorizontal = UIStackView(arrangedSubviews: horizontalArrayView)
            
            svhorizontal.alignment = UIStackViewAlignment.fill
            svhorizontal.distribution = UIStackViewDistribution.fillEqually
            svhorizontal.axis = UILayoutConstraintAxis.horizontal
            svhorizontal.spacing = CGFloat(5)
            
            svhorizontal.translatesAutoresizingMaskIntoConstraints = false
            verticalArrayView.append(svhorizontal)

        }
        
        let svvertical = UIStackView(arrangedSubviews: verticalArrayView)
        
        svvertical.alignment = UIStackViewAlignment.fill
        svvertical.distribution = UIStackViewDistribution.fillEqually
        svvertical.axis = UILayoutConstraintAxis.vertical
        svvertical.spacing = CGFloat(5)
        
        svvertical.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(svvertical)
        
        
        let hor = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[sv]-5-|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["sv": svvertical])
        let vl = NSLayoutConstraint.constraints(withVisualFormat: "V:|[sv]|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["sv": svvertical])
        self.addConstraints(hor)
        self.addConstraints(vl)

    }
    
    func loadViewFromNib() -> TrigramViewCell{
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TrigramViewCell", bundle: bundle)
        let cell = nib.instantiate(withOwner: self, options: nil)[0] as! TrigramViewCell
        
        return cell
    }

}
