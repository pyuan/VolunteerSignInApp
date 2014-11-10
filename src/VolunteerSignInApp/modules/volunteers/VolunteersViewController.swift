//
//  VolunteersViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-03.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

protocol VolunteersViewDelegate {
    func volunteersViewSelectVolunteer(volunteer:Volunteer?)
}

class VolunteersViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, VolunteerInfoViewDelegate, VolunteerSignInDelegate, ShareOptionsDelegate, MFMailComposeViewControllerDelegate
{
    
    @IBOutlet var tableView:UITableView?
    @IBOutlet var addVolunteerButton:UIBarButtonItem?
    @IBOutlet var shareButton:UIBarButtonItem?
    @IBOutlet var bottomBar:UIToolbar?
    
    var delegate:VolunteersViewDelegate?
    
    private var popoverController:UIPopoverController?
    private var volunteers:[Volunteer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.backgroundColor = UIColor.DEFAULT_SEPARATOR_COLOR
        self.reload()
    }
    
    //reload data from db and refresh view
    private func reload() {
        self.volunteers = VolunteerService.getAllVolunteers()
        self.tableView?.reloadData()
    }
    
    //remove all volunteers from the db after confirmation
    @IBAction func clearAllVolunteers(sender:AnyObject)
    {
        if self.volunteers?.count > 0
        {
            let msg:String = "Are you sure you want to remove ALL " + self.volunteers!.count.description + " participant" + (self.volunteers!.count > 1 ? "s" : "") + "? This cannot be undone."
            let alert:UIAlertController = UIAlertController(title: Constants.ALERT.TITLE_ERROR.rawValue, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            let cancel:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                alert.dismissViewControllerAnimated(false, completion: nil)
            }
            let submit:UIAlertAction = UIAlertAction(title: "Yes, I'm sure", style: UIAlertActionStyle.Default) { (action) -> Void in
                //remove from db
                VolunteerService.removeVolunteers(self.volunteers!)
                
                var indexPaths:[NSIndexPath] = [NSIndexPath]()
                for var i:Int=0; i<self.volunteers?.count; i++ {
                    let indexPath:NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    indexPaths.append(indexPath)
                }
                self.volunteers?.removeAll(keepCapacity: false)
                self.tableView?.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                self.selectVolunteer(nil)
                alert.dismissViewControllerAnimated(false, completion: nil)
            }
            alert.addAction(cancel)
            alert.addAction(submit)
            self.presentViewController(alert, animated: false, completion: nil)
        }
        else
        {
            let alert:UIAlertController = UIAlertController(title: "Sorry", message: "You don't have any participant to remove. Add one by tapping the '+' button.", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(defaultAction)
            self.presentViewController(alert, animated: false, completion: nil)
        }
    }
    
    @IBAction func addVolunteer(sender:AnyObject) {
        self.showVolunteerInfoPopover()
    }
    
    @IBAction func share(sender:AnyObject) {
        self.showShareOptionsPopover()
    }
    
    @IBAction func showSettings(sender:AnyObject) {
        let notif:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notif.postNotificationName(Constants.NOTIFICATION_CENTER_OBSERVER_NAMES.SHOW_SETTINGS.rawValue, object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.volunteers!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseId:String = "Cell"
        var cell:VolunteerCell = self.tableView?.dequeueReusableCellWithIdentifier(reuseId) as VolunteerCell
        
        //remove separator inset
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        var volunteer:Volunteer = self.volunteers![indexPath.row]
        cell.update(volunteer)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        self.selectVolunteer(nil)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            var volunteer:Volunteer = self.volunteers![indexPath.row]
            self.deleteVolunteer(volunteer)
        }
    }
    
    //allow tap again to deselect
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    {
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        if cell.selected {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            self.selectVolunteer(nil)
            return nil
        }
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var volunteer:Volunteer = self.volunteers![indexPath.row]
        self.delegate?.volunteersViewSelectVolunteer(volunteer)
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
        return UIView() //footer
    }
    
    //delete a volunteer from db and refresh the view
    private func deleteVolunteer(volunteer:Volunteer)
    {
        //update selection
        self.selectVolunteer(nil)
        
        //remove from db
        VolunteerService.removeVolunteers([volunteer])
        
        //remove from table
        for var i:Int=0; i<self.volunteers?.count; i++
        {
            var v:Volunteer = self.volunteers![i]
            if v === volunteer
            {
                var indexPath:NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                self.volunteers?.removeAtIndex(indexPath.row)
                self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                break
            }
        }
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
                    
                    //force cell to show select animation by first deselecting it
                    var cell:VolunteerCell? = self.tableView?.cellForRowAtIndexPath(indexPath) as? VolunteerCell
                    cell?.setSelected(false, animated: false)
                    
                    //select cell
                    self.tableView?.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
                    self.delegate?.volunteersViewSelectVolunteer(v)
                    
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
            self.delegate?.volunteersViewSelectVolunteer(nil)
        }
    }
    
    //show volunteer info in a popover positioned next to the add button
    private func showVolunteerInfoPopover()
    {
        var addButtonView:UIView = self.addVolunteerButton?.valueForKey("view") as UIView
        var frame:CGRect = CGRect(x: addButtonView.frame.origin.x-1, y: addButtonView.frame.origin.y + 20, width: addButtonView.frame.width, height: addButtonView.frame.height)
        self.popoverController = PopoverManager.showVolunteerInfo(frame, volunteer: nil, inView: self.view, delegate: self)
    }
    
    //show share options in a popover positioned next to the share button
    private func showShareOptionsPopover()
    {
        var shareButtonView:UIView = self.shareButton?.valueForKey("view") as UIView
        var frame:CGRect = CGRect(x: shareButtonView.frame.origin.x-1, y: self.bottomBar!.frame.origin.y + 5, width: shareButtonView.frame.width, height: shareButtonView.frame.height)
        self.popoverController = PopoverManager.showShareOptions(frame, inView: self.view, delegate: self)
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval)
    {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.popoverController?.dismissPopoverAnimated(true)
    }
    
    //create email and attach pdf
    private func emailPDF(fileName:String)
    {
        if MFMailComposeViewController.canSendMail()
        {
            var mailController:MFMailComposeViewController = EmailService.generatePDFEmail(self)
            self.presentViewController(mailController, animated: true, completion: nil)
        }
        else {
            println("MFMailComposeViewController cannot send mail")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!)
    {
        switch result.value
        {
        case MFMailComposeResultCancelled.value:
            println("MFMailComposeResultCancelled")
            break
        case MFMailComposeResultSaved.value:
            println("MFMailComposeResultSaved")
            break
        case MFMailComposeResultSent.value:
            println("MFMailComposeResultSent")
            break
        case MFMailComposeResultFailed.value:
            println("MFMailComposeResultFailed")
            break
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**** delegate method ****/
    func volunteerInfoClose(volunteer: Volunteer?)
    {
        self.popoverController?.dismissPopoverAnimated(true)
        self.popoverController = nil
        self.reload()
        self.selectVolunteer(volunteer)
    }
    
    func volunteerSignInSaved(volunteer: Volunteer?) {
        self.reload()
        self.selectVolunteer(volunteer)
    }
    
    func volunteerSignInDeleted(volunteer: Volunteer) {
        self.deleteVolunteer(volunteer)
    }
    
    func shareOptionsEmailPDF()
    {
        self.popoverController?.dismissPopoverAnimated(true)
        self.popoverController = nil
        self.emailPDF(Constants.PDF.FILE_NAME.rawValue)
    }
    
    func shareOptionsShowPDFPreview()
    {
        self.popoverController?.dismissPopoverAnimated(true)
        self.popoverController = nil
        let notif:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notif.postNotificationName(Constants.NOTIFICATION_CENTER_OBSERVER_NAMES.SHOW_PDF_VIEWER.rawValue, object: nil)
    }
    
}