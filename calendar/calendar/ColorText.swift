//
//  ColorText.swift
//  calendar
//
//  Created by Li Shi Wei on 9/11/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class ColorText: NSObject {
    
    private static var dicColorString : Dictionary<String,NSAttributedString> = Dictionary<String,NSAttributedString>()
    
    class func getColorEraText(celestial:String = "", terrestial:String = "") -> NSAttributedString {
        
        let listString = NSMutableAttributedString()
        
        if dicColorString.keys.contains(celestial) {
            listString.appendAttributedString(dicColorString[celestial]!)
        }
        else{
            if !celestial.isEmpty {
            
            let cColor = ApplicationResource.sharedInstance.getCelestialPropertyBy(celestial)["Color"]
            let cUIColor = ApplicationResource.sharedInstance.colorDictionary[cColor!]
            let cAttribute = [NSForegroundColorAttributeName : cUIColor!]
            let cString = NSAttributedString(string: celestial, attributes: cAttribute)
            
            listString.appendAttributedString(cString)
            dicColorString[celestial] = cString
            }
        }
        
        if dicColorString.keys.contains(terrestial) {
            listString.appendAttributedString(dicColorString[terrestial]!)
        }
        else{
            
            if !terrestial.isEmpty {
                
            let tColor = ApplicationResource.sharedInstance.getTerrestialPropertyBy(terrestial)["Color"]
            let tUIColor = ApplicationResource.sharedInstance.colorDictionary[tColor! as! String]
            let tAttribute = [NSForegroundColorAttributeName : tUIColor!]
            let tString = NSAttributedString(string: terrestial, attributes: tAttribute)
            
            listString.appendAttributedString(tString)
            dicColorString[terrestial] = tString
            }
        }
        return listString
    }
    
}
