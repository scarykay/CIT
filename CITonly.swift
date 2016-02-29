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
   // self.configureView()
        }
    }

        let model: CloudKitHelper = CloudKitHelper.sharedInstance()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //model.delegate = self;
            
            cloudKitHelper.fetchTodos(nil)
        }
        
 
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
       return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EstablishmentCell", forIndexPath: indexPath) as! EstablishmentCell
        NSLog("Establishment Cell is active")
       
        configureView()
        return cell
    }

    

    func configureView() {
        if let _: TeamDetail = self.featuredItem {
            
        let cell = tableView.dequeueReusableCellWithIdentifier("EstablishmentCell") as! EstablishmentCell  //1
           
        let establishment = self.featuredItem
            
            if let nameLabel = cell.viewWithTag(100) as? UILabel { //3
                nameLabel.text = establishment.name
            }
            if let cityLabel = cell.viewWithTag(101) as? UILabel {
                cityLabel.text = establishment.city
            }
            if let stateLabel = cell.viewWithTag(102) as? UILabel {
                stateLabel.text = establishment.state
            }
            
                
        }
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