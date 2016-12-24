//
//  AppDelegate.swift
//  calendar
//
//  Created by dev on 11/19/15.
//  Copyright © 2015 lsw. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //ApplicationResource.sharedInstance
        
        var navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.darkGray
        
        return true
    }
    
    var fromApp:String = ""
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let schema = url.scheme
        
        if schema?.caseInsensitiveCompare("OpenSelfTrigramSelect") == .orderedSame {
            
            let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
            let queryItems = components?.queryItems
            var dic = Dictionary<String,String>()
            
            for item in queryItems! {
                dic.updateValue(item.value!, forKey: item.name)
            }
            
            if dic.keys.contains("from") {
                let from = dic["from"]!
                fromApp = from
                print(fromApp)
            }
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
            
            if let nav = self.window?.rootViewController as? UINavigationController{
                //nav.pushViewController(vc, animated: true)
                if nav.viewControllers.count > 0 {
                    nav.popToViewController(nav.viewControllers[0], animated: true)
                }else
                {
                    nav.viewControllers[0] = vc
                }
            }
            
            
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

