//
//  VolunteerService.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class VolunteerService
{
    
    //add a new volunteer into the db
    class func addNewVolunteer(fName:String, lName:String, team:String, phone:String, email:String, isOver18:Bool) -> Volunteer
    {
        let db:DatabaseHandler = DatabaseHandler.sharedInstance
        var volunteer:Volunteer = db.createNewVolunteer(fName, lName: lName, team: team, phone: phone, email: email, isOver18: isOver18)
        return volunteer
    }
    
    //update an existing volunteer in the db
    class func updateVolunteer(volunteer:Volunteer, attributes:NSDictionary) -> Volunteer {
        let db:DatabaseHandler = DatabaseHandler.sharedInstance
        var v:Volunteer = db.updateVolunteer(volunteer, attributes: attributes)
        return v
    }
    
    //get all saved volunteers from the db
    class func getAllVolunteers() -> [Volunteer]
    {
        let db:DatabaseHandler = DatabaseHandler.sharedInstance
        var volunteers:[Volunteer] = db.getAllVolunteers()
        return volunteers
    }
    
    //delete volunteers from the db
    class func removeVolunteers(volunteers:[Volunteer])
    {
        let db:DatabaseHandler = DatabaseHandler.sharedInstance
        db.deleteVolunteers(volunteers)
    }
    
}