//
//  VolunteersViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-03.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteersViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, VolunteerInfoViewDelegate
{
    
    @IBOutlet var tableView:UITableView?
    @IBOutlet var addVolunteerButton:UIBarButtonItem?
    
    private var volunteerInfoPopoverController:UIPopoverController?
    private var volunteers:[Volunteer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reload()
    }
    
    //reload data from db and refresh view
    private func reload() {
        self.volunteers = VolunteerService.getAllVolunteers()
        self.tableView?.reloadData()
    }
    
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
        return self.volunteers!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseId:String = "Cell"
        var cell:UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier(reuseId) as UITableViewCell
        
        var volunteer:Volunteer = self.volunteers![indexPath.row]
        cell.textLabel.text = volunteer.getDisplayName()
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            //remove from db
            var volunteer:Volunteer = self.volunteers![indexPath.row]
            VolunteerService.removeVolunteers([volunteer])
            
            //remove from table
            self.volunteers?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    //programmatically create line for footer
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let leftMargin:CGFloat = 16
        var footer:UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 1))
        var line:UIView = UIView(frame: CGRectMake(leftMargin, 0, footer.frame.width, footer.frame.height))
        line.backgroundColor = UIColor.DEFAULT_SEPARATOR_COLOR
        footer.addSubview(line)
        return footer
    }
    
    //scroll to and select row, or deselect all rows if no volunteer is specified
    private func selectVolunteer(volunteer:Volunteer?)
    {
        if volunteer != nil
        {
            for var i:Int=0; i<self.volunteers?.count; i++
            {
                var v:Volunteer = self.volunteers![i]
                if v === volunteer
                {
                    let indexPath:NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    self.tableView?.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
                    break
                }
            }
        }
        else
        {
            var selected:NSIndexPath? = self.tableView?.indexPathForSelectedRow()
            if selected != nil {
                self.tableView?.deselectRowAtIndexPath(selected!, animated: true)
            }
        }
    }
    
    //show volunteer info in a popover positioned next to the add button
    private func showVolunteerInfoPopover()
    {
        var view:UIView = self.addVolunteerButton?.valueForKey("view") as UIView
        var frame:CGRect = CGRect(x: view.frame.origin.x-1, y: view.frame.origin.y + 20, width: view.frame.width, height: view.frame.height)
        self.volunteerInfoPopoverController = PopoverManager.showVolunteerInfo(frame, volunteer: nil, inView: self.view, delegate: self)
    }
    
    /**** delegate method ****/
    func volunteerInfoClose(volunteer: Volunteer?)
    {
        self.volunteerInfoPopoverController?.dismissPopoverAnimated(true)
        self.volunteerInfoPopoverController = nil
        self.reload()
        self.selectVolunteer(volunteer)
    }
    
}