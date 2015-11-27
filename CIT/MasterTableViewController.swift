//
//  MasterTableViewController.swift
//  CIT
//
//  Created by Mary K Paquette on 11/11/15.
//  Copyright © 2015 Mary K Paquette. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, CloudKitDelegate {

    let model: CloudKitHelper = CloudKitHelper.sharedInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self;
        
        cloudKitHelper.fetchTodos(nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        NSLog("\(cloudKitHelper.todos.count)")
        return cloudKitHelper.todos.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = cloudKitHelper.todos[indexPath.row].name
        cell.textLabel?.textColor = UIColor.blueColor()
        cell.detailTextLabel?.text = "\(cloudKitHelper.todos[indexPath.row].city), \(cloudKitHelper.todos[indexPath.row].state), \(cloudKitHelper.todos[indexPath.row].zipcode)"
        //cell.detailTextLabel?.font = UIFont(name: "SanFrancisco", size: 14)
        return cell
    }
    
    
    func modelUpdated() {
        NSLog("Model refreshed \(cloudKitHelper.todos.count)")
        refreshControl?.endRefreshing()
        tableView.reloadData()
        
    }
    
    func errorUpdating(error: NSError) {
        let alert = UIAlertController(title: "load error", message: "Log into your iCloud to see CIT data.", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // AutoLayout Feature
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailsSegue" {
           _ = self.tableView.indexPathForSelectedRow!.row
            _ = segue.destinationViewController as! UINavigationController
            segue.destinationViewController as! DetailsViewController

            
        } else if segue.identifier == "addItemSegue" {
            
            _ = segue.destinationViewController as! UINavigationController
            _ = navigationController!.topViewController as! MasterTableViewController
            
        }
        
    }
}