//
//  CITonly.swift
//  CIT
//
//  Created by Mary K Paquette on 1/23/16.
//  Copyright © 2016 Mary K Paquette. All rights reserved.
//

import UIKit

//protocol JournalEntryDelegate {
 //  func didFinishViewController(
  //      viewController: CITonly, didSave:Bool)
// }


class CITonly: UITableViewController {
    
    var featuredItem: TeamDetail! {
    didSet {
    //self.configureView()
        }
    }

        let model: CloudKitHelper = CloudKitHelper.sharedInstance()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //model.delegate = self;
            
            cloudKitHelper.fetchTodos(nil)
        }
        
  /*
        func configureView() {
        if let detail: TeamDetail = self.featuredItem {
            title = detail.state
             // detail.loadCoverPhoto() { image in
            //  dispatch_async(dispatch_get_main_queue()) {
            // self.coverView.image = image
        }
      }
   // coordinatorLabel.text = title*/
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
        //configureView()
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
        NSLog("Establishment Cell is active")
       // return cloudKitHelper.todos.count
        return 1
    }
    
     /*  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
                as! Cell
            configureView()
            return cell
    } */
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("EstablishmentCell", forIndexPath: indexPath)
    
    let establishment = cloudKitHelper.todos[indexPath.row].name
    if let nameLabel = cell.viewWithTag(100) as? UILabel { //3
    nameLabel.text = establishment
    }
    if let cityLabel = cell.viewWithTag(101) as? UILabel {
        cityLabel.text = cloudKitHelper.todos[indexPath.row].city
    }
    if let stateLabel = cell.viewWithTag(102) as? UILabel {
        stateLabel.text = cloudKitHelper.todos[indexPath.row].state
    }
    return cell
    }
   
    
    func disMiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //back button
    @IBAction func done(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        disMiss()
    }
    

}