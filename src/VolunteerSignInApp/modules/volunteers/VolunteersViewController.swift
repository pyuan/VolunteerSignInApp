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
    @IBOutlet var addVolunteerButton:UIBarButtonItem?
    
    private var volunteerInfoPopoverController:UIPopoverController?
    
    @IBAction func clearAllVolunteers(sender:AnyObject) {
        println("Clear all volunteers")
    }
    
    @IBAction func addVolunteer(sender:AnyObject) {
        self.showVolunteerInfoPopover()
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
    
    //show volunteer info in a popover positioned next to the add button
    private func showVolunteerInfoPopover()
    {
        var view:UIView = self.addVolunteerButton?.valueForKey("view") as UIView
        var frame:CGRect = CGRect(x: view.frame.origin.x-1, y: view.frame.origin.y + 20, width: view.frame.width, height: view.frame.height)
        self.volunteerInfoPopoverController = PopoverManager.showVolunteerInfo(frame, volunteer: nil, inView: self.view)
    }
    
}