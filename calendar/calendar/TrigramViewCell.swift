//
//  TrigramViewCell.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 18/12/2016.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class TrigramViewCell: UIView {

    @IBOutlet weak var btnBaZhaiPositionName: UIButton!
    
    @IBOutlet weak var btnTrigramName: UIButton!
    
    @IBOutlet weak var btnTrigramDirection: UIButton!
    
    var trigramName:String = "" {
        didSet{
            if !trigramName.isEmpty {
                btnTrigramName.setTitle(trigramName, for: .normal)
            }
        }
    }
    
    var trigramDirection:String = "" {
        didSet{
            //if !trigramDirection.isEmpty {
                btnTrigramDirection.setTitle(trigramDirection, for: .normal)
            //}
        }
    }
    
    var baZhaPositionName:String = "" {
        didSet{
            //if !baZhaPositionName.isEmpty{
                btnBaZhaiPositionName.setTitle(baZhaPositionName, for: .normal)
                btnBaZhaiPositionName.titleLabel?.adjustsFontSizeToFitWidth = true
            //}
        }
    }
}
