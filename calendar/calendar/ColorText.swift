//
//  ColorText.swift
//  calendar
//
//  Created by Li Shi Wei on 9/11/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class ColorText: NSObject {
    
    fileprivate static var dicColorString : Dictionary<String,NSAttributedString> = Dictionary<String,NSAttributedString>()
    
    class func getColorEraText(_ celestial:String = "", terrestial:String = "") -> NSAttributedString {
        
        let listString = NSMutableAttributedString()
        
        if dicColorString.keys.contains(celestial) {
            listString.append(dicColorString[celestial]!)
        }
        else{
            if !celestial.isEmpty {
            
            let cColor = ApplicationResource.sharedInstance.getCelestialPropertyBy(celestial)["Color"]
            let cUIColor = ApplicationResource.sharedInstance.colorDictionary[cColor!]
                let cAttribute = [NSAttributedStringKey.foregroundColor : cUIColor!]
            let cString = NSAttributedString(string: celestial, attributes: cAttribute)
            
            listString.append(cString)
            dicColorString[celestial] = cString
            }
        }
        
        if dicColorString.keys.contains(terrestial) {
            listString.append(dicColorString[terrestial]!)
        }
        else{
            
            if !terrestial.isEmpty {
                
            let tColor = ApplicationResource.sharedInstance.getTerrestialPropertyBy(terrestial)["Color"]
            let tUIColor = ApplicationResource.sharedInstance.colorDictionary[tColor! as! String]
                let tAttribute = [NSAttributedStringKey.foregroundColor : tUIColor!]
            let tString = NSAttributedString(string: terrestial, attributes: tAttribute)
            
            listString.append(tString)
            dicColorString[terrestial] = tString
            }
        }
        return listString
    }
    
}
