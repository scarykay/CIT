//  DetailsViewController.swift

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    
    var featuredItem:TeamDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // page 121
        if(featuredItem != nil){
            nameTF.text = featuredItem!.name
            cityTF.text = "\(featuredItem!.city)"
            stateTF.text = "\(featuredItem!.state)"
            zipcodeTF.text = "\(featuredItem!.zipcode)"
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disMiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func done(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        disMiss()
        
    }


    @IBAction func cancel(sender: UIBarButtonItem) {
         disMiss()
    }
    
    @IBAction func saveInCloud(sender: UIButton) {
        cloudKitHelper.saveRecord(self.nameTF.text!, city : self.cityTF.text!, state : self.stateTF.text!, zipcode: self.zipcodeTF.text!)
        self.nameTF.text = nil
        self.cityTF.text = nil
        self.stateTF.text = nil
        self.zipcodeTF.text = nil
        disMiss()
        
    }
    
}

