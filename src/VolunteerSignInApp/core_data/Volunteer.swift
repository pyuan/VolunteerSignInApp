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

}
