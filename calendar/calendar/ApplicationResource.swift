//
//  ApplicationResource.swift
//  calendar
//
//  Created by Li Shi Wei on 9/10/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

let _SingletonSharedInstance = ApplicationResource()

class ApplicationResource: NSObject {

    class var sharedInstance : ApplicationResource {
        return _SingletonSharedInstance
    }
    
    internal private(set) var jsonSource : Dictionary<String,AnyObject>! = nil
    
    override init() {
        
        let bundle : NSBundle = NSBundle.mainBundle()
        let jsonPath = bundle.pathForResource("Source.json", ofType: nil)
        let jsonData = NSData.init(contentsOfFile: jsonPath!)
        
        do
        {
            jsonSource = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! Dictionary<String,AnyObject>
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }

    }
    
    var celestialStem : Dictionary<String,AnyObject>
        {
        get{
            return jsonSource["天干"] as! Dictionary<String,AnyObject>
        }
    }
    
    var terrestialBranch : Dictionary<String,AnyObject>
        {
        get{
            return jsonSource["地支"] as! Dictionary<String,AnyObject>
        }
    }
    
    func getCelestialPropertyBy(name: String) -> Dictionary<String,String> {
        return celestialStem[name] as! Dictionary<String,String>
    }
    
    func getTerrestialPropertyBy(name: String) -> Dictionary<String,AnyObject> {
        return terrestialBranch[name] as! Dictionary<String,AnyObject>
    }
    
    let colorDictionary : Dictionary<String,UIColor> = [
            "Red":UIColor.redColor(),
            "Yellow":UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1),
            "Brown":UIColor.brownColor(),
            "Green":UIColor(red: 34/255, green: 193/255, blue: 34/255, alpha: 1),
            "Blue":UIColor.blueColor()
    ]
}
