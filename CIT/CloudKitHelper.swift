import Foundation
import CloudKit

let EstablishmentType = "TeamDetail"


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
      var items = [TeamDetail]()
    
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
        //todoRecord.setValue(coordinator, forKey: "coordinator")
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
    
    // Mark -  --- adding on in Feb 2016
    
    func establishment(ref: CKReference) -> TeamDetail! {
        let matching = items.filter {$0.record.recordID == ref.recordID}
        var e : TeamDetail!
        if matching.count > 0 {
            e = matching[0]
        }
        return e
    }
    
    func fetchEstablishments(location:CLLocation,
        radiusInMeters:CLLocationDistance) {
            // 1
            let radiusInKilometers = radiusInMeters / 1000.0
            // 2
            let locationPredicate = NSPredicate(format: "distanceToLocation:fromLocation:(%K,%@) < %f",
                "Location",
                location,
                radiusInKilometers)
            // 3
            let query = CKQuery(recordType: EstablishmentType,
                predicate:  locationPredicate)
            // 4
            publicDB.performQuery(query, inZoneWithID: nil) {
                results, error in
                if error != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.errorUpdating(error!)
                        return
                    }
                } else {
                    self.items.removeAll(keepCapacity: true)
                    for _ in results!{
                        let establishment = TeamDetail!()
                        self.items.append(establishment)
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.modelUpdated()
                        return
                    }
                }
            }
    }
    
    func fetchEstablishments(location: CLLocation,
        rec: CKRecord?,  //mkp
        radiusInMeters:CLLocationDistance,
        completion:    (results:[TeamDetail]!, error:NSError!) -> ()) {
            let radiusInKilometers = radiusInMeters / 1000.0 //1
            //Apple Campus location = 37.33182, -122.03118
            let location = CLLocation(latitude: 37.33182, longitude: -122.03118)
            
            let locationPredicate = NSPredicate(format: "distanceToLocation:fromLocation:(%K,%@) < %f",
                "Location",
                location,
                radiusInKilometers) //2
            let query = CKQuery(recordType: EstablishmentType,
                predicate:  locationPredicate) //3
            publicDB.performQuery(query, inZoneWithID: nil) { //4
                results, error in
                var res = [TeamDetail]()
                if let records = results {
                    for _ in records {
                        let establishment = TeamDetail!()
                        res.append(establishment)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    completion(results: res, error: error)
                }
            }
    }
    
    // -------- end of addition
    
    
    
    
}
let cloudKitHelper = CloudKitHelper()

