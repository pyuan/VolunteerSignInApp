//
//  VolunteerInfoViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol VolunteerInfoViewDelegate {
    func volunteerInfoClose(volunteer:Volunteer?)
}

class VolunteerInfoViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, InfoBottomBarDelegate, VolunteerInfoTextFieldCellDelegate
{
    
    class var POPOVER_SIZE:CGSize { return CGSizeMake(300, 310) }
    
    @IBOutlet var tableView:UITableView?
    @IBOutlet var bottomBar:InfoBottomBar?
    
    var delegate:VolunteerInfoViewDelegate?
    
    private var fields:[VolunteerInfoFormTextFieldModel] = [VolunteerInfoFormTextFieldModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.bottomBar?.delegate = self
        
        //load form data
        self.fields = VolunteerFormService.getFormFields()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fields.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReuseId:String = "textFieldCell"
        var cell:VolunteerInfoTextFieldCell! = tableView.dequeueReusableCellWithIdentifier(cellReuseId, forIndexPath: indexPath) as VolunteerInfoTextFieldCell
        
        var model:VolunteerInfoFormTextFieldModel = self.fields[indexPath.row]
        cell.delegate = self
        cell.update(model)
        
        return cell
    }
    
    //validate the form entry, must have a first and last name
    private func validateForm(formData:[String:String]) -> Bool
    {
        var isValid:Bool = false
        if formData["fname"]! != "" && formData["lname"]! != "" {
            isValid = true
        }
        return isValid
    }
    
    /**** delegate methods ****/
    func infoBottomBarSave(isOver18: Bool)
    {
        var attributes:[String:String] = [String:String]()
        for field in self.fields {
            attributes[field.key] = field.value
        }
        
        var isValid:Bool = self.validateForm(attributes)
        if isValid
        {
            var volunteer:Volunteer = VolunteerService.addNewVolunteer(attributes["fname"]!, lName: attributes["lname"]!, team: attributes["team"]!, phone: attributes["phone"]!, email: attributes["email"]!, isOver18: isOver18)
            
            self.delegate?.volunteerInfoClose(volunteer)
        }
        else
        {
            let alertController = UIAlertController(title: "Sorry!", message: "First and last names are required.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //switch focus to the next text field
    func volunteerInfoTextFieldNext(model: VolunteerInfoFormTextFieldModel?)
    {
        for var i:Int=0; i<self.fields.count; i++
        {
            var field:VolunteerInfoFormTextFieldModel = self.fields[i]
            if field === model
            {
                var nextRowIndex:Int = i + 1
                if nextRowIndex < self.fields.count
                {
                    var cell:VolunteerInfoTextFieldCell = self.tableView?.cellForRowAtIndexPath(NSIndexPath(forRow: nextRowIndex, inSection: 0)) as VolunteerInfoTextFieldCell
                    cell.becomeFirstResponder()
                }
                break
            }
        }
    }
    
    //adjust table scroll to make sure selected row is in view
    func volunteerInfoTextFieldOnFocus(model: VolunteerInfoFormTextFieldModel?)
    {
        for var i:Int=0; i<self.fields.count; i++
        {
            var field:VolunteerInfoFormTextFieldModel = self.fields[i]
            if field === model
            {
                //slight delay to allow keyboard animation to finish first
                TimeUtils.performAfterDelay(0.5, completionHandler: {() -> Void in
                    let indexPath:NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    self.tableView?.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                })
                break
            }
        }
    }
    
}