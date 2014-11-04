//
//  VolunteersViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-03.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteersViewController:UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var tableView:UITableView?
    
    @IBAction func clearAllVolunteers(sender:AnyObject) {
        println("Clear all volunteers")
    }
    
    @IBAction func addVolunteer(sender:AnyObject) {
        println("Add volunteer")
    }
    
    @IBAction func sendToChicagoCares(sender:AnyObject) {
        println("Send to Chicago Cares")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        return cell
    }
    
}