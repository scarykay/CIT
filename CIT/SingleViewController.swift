//  SingleViewController.swift

import UIKit

class SingleViewController: UIViewController {
    
    var labelGroup:TeamDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // page 121
       //if(labelGroup != nil){
       //  sNameCIT.text = "\(TeamDetail!.city)"
       //
       // }
        //SingleCell.sNameCIT.text = " "
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func disMiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
    
    
}

