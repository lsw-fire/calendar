//
//  ViewController.swift
//  calendar
//
//  Created by dev on 11/19/15.
//  Copyright © 2015 lsw. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(alertMessage, animated: true, completion:nil);
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() { 
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage()
    {
        let alertController = UIAlertController(title: "Welcome to My calendar", message: "2015-11-19", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion:nil);
    }
    
    var tableViewSource = ["lsw1","lsw2","lsw3"]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath:indexPath) 
        cell.textLabel?.text = tableViewSource[indexPath.row]
        cell.imageView?.image = UIImage(named: "img")
        return cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share",
            handler: {(action:UITableViewRowAction!,indexPath:NSIndexPath ) -> Void in
                let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
                let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
                let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
                shareMenu.addAction(twitterAction)
                shareMenu.addAction(facebookAction)
                
                self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {
            (action:UITableViewRowAction!, indexPath:NSIndexPath) -> Void in
            
            
        })
        
        return [deleteAction, shareAction]
    }

}

