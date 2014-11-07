//
//  Volunteer.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import CoreData

class Volunteer: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var fName: String
    @NSManaged var lName: String
    @NSManaged var over18: NSNumber
    @NSManaged var phone: String
    @NSManaged var signature: NSData
    @NSManaged var team: String
    
    func getDisplayName() -> String {
        return self.fName + " " + self.lName
    }
    
    func update(attributes:NSDictionary) {
        self.fName = attributes["fname"] == nil ? self.fName : attributes["fname"] as String
        self.lName = attributes["lname"] == nil ? self.lName : attributes["lname"] as String
        self.team = attributes["team"] == nil ? self.team : attributes["team"] as String
        self.phone = attributes["phone"] == nil ? self.phone : attributes["phone"] as String
        self.email = attributes["email"] == nil ? self.email : attributes["email"] as String
        self.over18 = attributes["over18"] == nil ? self.over18 : attributes["over18"] as String == "true"
    }

}
