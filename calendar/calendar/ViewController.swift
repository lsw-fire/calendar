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
            
            let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            @IBOutlet weak var viewHolder: UIView!
            
            self.present(alertMessage, animated: true, completion:nil);
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() { 
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage()
    {
        let alertController = UIAlertController(title: "Welcome to My calendar", message: "2015-11-19", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion:nil);
    }
    
    var tableViewSource = ["lsw1","lsw2","lsw3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath) 
        cell.textLabel?.text = tableViewSource[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: "img")
        
        
        
        return cell
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share",
            handler: {(action:UITableViewRowAction!,indexPath:IndexPath ) -> Void in
                let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
                let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: nil)
                let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.default, handler: nil)
                shareMenu.addAction(twitterAction)
                shareMenu.addAction(facebookAction)
                
                self.present(shareMenu, animated: true, completion: nil)
        })
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler: {
            (action:UITableViewRowAction!, indexPath:IndexPath) -> Void in
            
            
        })
        
        return [ shareAction,deleteAction]
    }

}

