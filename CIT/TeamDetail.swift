//
//  TeamDetail.swift
//  CIT


import Foundation
import CloudKit

class TeamDetail : NSObject{
    var record : CKRecord!
    var name : String!
    var city : String!
    var state : String!
    var zipcode : String!
    
    weak var database : CKDatabase!
    var date: NSDate
    init(record : CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        self.name = record.objectForKey("name") as! String!
        self.city = record.objectForKey("city") as! String!
        self.state = record.objectForKey("state") as! String!
        self.zipcode = record.objectForKey("zipcode") as! String!
        self.date = record.creationDate!
    }
    
}
