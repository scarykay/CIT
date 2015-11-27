import Foundation
import CloudKit

protocol CloudKitDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}


class CloudKitHelper {
    var container : CKContainer
    var publicDB : CKDatabase
    let privateDB : CKDatabase
    var delegate : CloudKitDelegate?
    var todos = [TeamDetail]()
    
    class func sharedInstance() -> CloudKitHelper {
        return cloudKitHelper
    }
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    
    func saveRecord(
        todo : NSString,
        city : NSString,
        state : NSString,
        zipcode : NSString){
        //location : CLLocation,
        //latitude:  CLLocationDegrees,
        //longitude: CLLocationDegrees) {
                
        //let location = CLLocation(latitude: latitude, longitude: longitude)
        let todoRecord = CKRecord(recordType: "TeamDetail")
        todoRecord.setValue(todo, forKey: "name")
        todoRecord.setValue(city, forKey: "city")
        todoRecord.setValue(state, forKey: "state")
        todoRecord.setValue(zipcode, forKey: "zipcode")
        //todoRecord.setValue(location, forKey: "location")

        
        publicDB.saveRecord((todoRecord), completionHandler: { (record, error) -> Void in
            NSLog("Before saving in cloud kit : \(self.todos.count)")
            NSLog("Saved in cloudkit")
            self.fetchTodos(record)
        })
    }
    
    func fetchTodos(insertedRecord: CKRecord?) {
        let predicate = NSPredicate(value: true)
        //let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let sort = NSSortDescriptor(key: "state", ascending: true)
        
        let query = CKQuery(recordType: "TeamDetail",
            predicate:  predicate)
        query.sortDescriptors = [sort]
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error!)
                    return
                }
            } else {
                self.todos.removeAll()
                for record in results!{
                    let todo = TeamDetail(record: record as CKRecord, database: self.publicDB)
                    self.todos.append(todo)
                }
                if let tmp = insertedRecord {
                    let todo = TeamDetail(record: insertedRecord! as CKRecord, database: self.publicDB)
                   self.todos.insert(todo, atIndex: 0)
                    print("hello fix me.")
                }
                NSLog("fetch after save : \(self.todos.count)")
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    return
                }
            }
        }
    }
}
let cloudKitHelper = CloudKitHelper()

