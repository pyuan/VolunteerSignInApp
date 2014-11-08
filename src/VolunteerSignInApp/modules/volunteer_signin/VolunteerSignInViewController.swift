//
//  VolunteerInfoViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-03.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol VolunteerSignInDelegate {
    func volunteerSignInSaved(volunteer:Volunteer?)
}

class VolunteerSignInViewController:UIViewController, VolunteersViewDelegate, VolunteerInfoViewDelegate, SignatureViewDelegate
{
    
    @IBOutlet var wrapperView:UIView?
    @IBOutlet var blankView:UIView?
    @IBOutlet var blankLabel:UILabel?
    @IBOutlet var profileButton:UIBarButtonItem?
    
    var delegate:VolunteerSignInDelegate?
    
    private var signatureVC:SignatureViewController?
    private var volunteerInfoPopoverController:UIPopoverController?
    private var volunteer:Volunteer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blankLabel?.text = "Select a volunteer from the left to sign in."
        self.blankLabel?.font = UIFont.DEFAULT_LABEL()
        self.blankLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        
        //reset view
        self.volunteersViewSelectVolunteer(nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshSignatureView()
    }
    
    @IBAction func showVolunteerInfo(sender:AnyObject) {
        self.showVolunteerInfoPopover()
    }
    
    //programmatically add signature view controller
    private func refreshSignatureView()
    {
        if self.signatureVC == nil
        {
            var storyboard:UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.SIGNATURE.rawValue, bundle: nil)
            self.signatureVC = storyboard.instantiateInitialViewController() as? SignatureViewController
            self.signatureVC?.delegate = self
            self.addChildViewController(self.signatureVC!)
            self.signatureVC?.view.clipsToBounds = true
            self.wrapperView?.addSubview(self.signatureVC!.view)
            self.signatureVC!.didMoveToParentViewController(self)
        }
        
        //re-adjust signature view
        let isLandscape:Bool = UIInterfaceOrientationIsLandscape(self.interfaceOrientation)
        let h:CGFloat = CGFloat(isLandscape == true ? Constants.SIGNATURE_SIZE.LANDSCAPE_HEIGHT.rawValue : Constants.SIGNATURE_SIZE.PORTRAIT_HEIGHT.rawValue)
        let frame:CGRect = CGRectMake(0, self.wrapperView!.frame.height-h, self.wrapperView!.frame.width, h)
        self.signatureVC?.view.frame = frame
        println(self.wrapperView?.frame)
    }
    
    //show volunteer info in a popover positioned next to the add button
    private func showVolunteerInfoPopover()
    {
        var view:UIView = self.profileButton?.valueForKey("view") as UIView
        var frame:CGRect = CGRect(x: view.frame.origin.x-2, y: view.frame.origin.y + 25, width: view.frame.width, height: view.frame.height)
        self.volunteerInfoPopoverController = PopoverManager.showVolunteerInfo(frame, volunteer: self.volunteer, inView: self.view, delegate: self)
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval)
    {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.volunteerInfoPopoverController?.dismissPopoverAnimated(true)
        self.volunteerInfoPopoverController = nil
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        self.refreshSignatureView()
    }
    
    /**** delegate methods ****/
    func volunteersViewSelectVolunteer(volunteer: Volunteer?)
    {
        self.volunteer = volunteer
        
        let title:String = volunteer == nil ? "" : volunteer!.getDisplayName()
        self.title = title
        
        self.wrapperView?.hidden = volunteer == nil
        self.blankView?.hidden = !self.wrapperView!.hidden
        
        var view:UIView = self.profileButton?.valueForKey("view") as UIView
        view.hidden = volunteer == nil
    }
    
    func volunteerInfoClose(volunteer: Volunteer?)
    {
        self.volunteerInfoPopoverController?.dismissPopoverAnimated(true)
        self.volunteerInfoPopoverController = nil
        self.delegate?.volunteerSignInSaved(volunteer)
    }
    
    func signatureViewOnSave(signature: UIImage?)
    {
        var alert:UIAlertController = UIAlertController(title: "Thanks!", message: "You are now signed in.", preferredStyle: UIAlertControllerStyle.Alert)
        let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        
        if signature == nil
        {
            alert.title = "Ooops!"
            alert.message = "Please go through the waiver and sign your name above."
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}