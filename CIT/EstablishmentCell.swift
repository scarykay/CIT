//
// EstablishmentCell.swift

import UIKit
//import UIWidgets

class EstablishmentCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var coordinatorLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var webLabel: UILabel!
    
    
    let model: CloudKitHelper = CloudKitHelper.sharedInstance()
    

}