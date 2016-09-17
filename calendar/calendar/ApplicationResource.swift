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
    
    internal fileprivate(set) var jsonSource : Dictionary<String,AnyObject>! = nil
    
    override init() {
        
        super.init()
        
        let bundle : Bundle = Bundle.main
        let jsonPath = bundle.path(forResource: "Source.json", ofType: nil)
        let jsonData = try? Data.init(contentsOf: URL(fileURLWithPath: jsonPath!))
        
        do
        {
            jsonSource = try JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers) as! Dictionary<String,AnyObject>
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        if !userDefaults.dictionaryRepresentation().keys.contains(viewRotateDirection) {
             self.setMonthViewRotateDirection(UICollectionViewScrollDirection.vertical)
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
    
    func getCelestialPropertyBy(_ name: String) -> Dictionary<String,String> {
        return celestialStem[name] as! Dictionary<String,String>
    }
    
    func getTerrestialPropertyBy(_ name: String) -> Dictionary<String,AnyObject> {
        return terrestialBranch[name] as! Dictionary<String,AnyObject>
    }
    
    let colorDictionary : Dictionary<String,UIColor> = [
            "Red":UIColor.red,
            "Yellow":UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1),
            "Brown":UIColor.brown,
            "Green":UIColor(red: 34/255, green: 193/255, blue: 34/255, alpha: 1),
            "Blue":UIColor.blue
    ]
    
    //user defaults
    let userDefaults = UserDefaults.standard
    let viewRotateDirection = "viewRotateDirection"
    func setMonthViewRotateDirection(_ direction:UICollectionViewScrollDirection) {
        userDefaults.set(direction.rawValue, forKey: viewRotateDirection)
        userDefaults.synchronize()
    }
    
    func getMonthViewRotateDirection() -> UICollectionViewScrollDirection {
         return UICollectionViewScrollDirection(rawValue: userDefaults.integer(forKey: viewRotateDirection))!
    }
}
