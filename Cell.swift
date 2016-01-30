//
//  Cell.swift
//  CIT
//
//  Created by Mary K Paquette on 1/30/16.
//  Copyright © 2016 Mary K Paquette. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

@IBOutlet weak var coordinatorLabel: UILabel!
@IBOutlet weak var phoneLabel: UILabel!
@IBOutlet weak var webLabel: UILabel!
   
    
    var featuredItem: TeamDetail! {
        didSet {
            self.configureView()
        }
    }
    
    let model: CloudKitHelper = CloudKitHelper.sharedInstance()
    
   // MARK: View Setup For Cell -------------
   func configureView() {
            //title = featuredItem.city
            
            if let Label = coordinatorLabel {
                if let value = featuredItem.city {
                    Label.text = value
                }
            }
            
            if let Label = phoneLabel {
                if let value = featuredItem.zipcode {
                    Label.text = value
                }
            }
            
            if let Label = webLabel {
                if let value = featuredItem.state {
                    Label.text = value
                }
            }
    
            
        }


     func updateJournalEntry() {
            
            if let entry = featuredItem {
               entry.date = NSDate()
                entry.city = coordinatorLabel.text
                entry.state = phoneLabel.text
                entry.zipcode = webLabel.text
            //    entry.name = locationLabel.text
       }
    }
    
    

  
}