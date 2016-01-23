//
//  CITonly.swift
//  CIT
//
//  Created by Mary K Paquette on 1/23/16.
//  Copyright © 2016 Mary K Paquette. All rights reserved.
//

import UIKit
class CITonly: UITableViewController {
    
    
    var featuredItem:TeamDetail?
    
    let model: CloudKitHelper = CloudKitHelper.sharedInstance()
    
    func configureView() {
      //  dfsdfs = "
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // model.delegate = self;
        cloudKitHelper.fetchTodos(nil)

        // page 121
        if(featuredItem != nil){
         //   coordinatorCell.text = "\(cloudKitHelper.todos.zipcode)"
            
        }
    }
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
       configureView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

