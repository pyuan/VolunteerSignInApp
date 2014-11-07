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

class VolunteerSignInViewController:UIViewController, VolunteersViewDelegate, VolunteerInfoViewDelegate
{
    
    @IBOutlet var wrapperView:UIView?
    @IBOutlet var blankView:UIView?
    @IBOutlet var blankLabel:UILabel?
    @IBOutlet var bottomView:UIView?
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshSignatureView()
        self.volunteersViewSelectVolunteer(nil)
    }
    
    @IBAction func showVolunteerInfo(sender:AnyObject) {
        self.showVolunteerInfoPopover()
    }
    
    //programmatically add signature view controller
    private func refreshSignatureView()
    {
        if self.signatureVC == nil {
            var storyboard:UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.SIGNATURE.rawValue, bundle: nil)
            self.signatureVC = storyboard.instantiateInitialViewController() as? SignatureViewController
            self.addChildViewController(self.signatureVC!)
            self.wrapperView?.addSubview(self.signatureVC!.view)
            self.signatureVC!.didMoveToParentViewController(self)
        }
        
        //re-adjust signature view
        self.signatureVC!.view.frame = self.bottomView!.frame
    }
    
    //show volunteer info in a popover positioned next to the add button
    private func showVolunteerInfoPopover()
    {
        var view:UIView = self.profileButton?.valueForKey("view") as UIView
        var frame:CGRect = CGRect(x: view.frame.origin.x-4, y: view.frame.origin.y + 25, width: view.frame.width, height: view.frame.height)
        self.volunteerInfoPopoverController = PopoverManager.showVolunteerInfo(frame, volunteer: self.volunteer, inView: self.view, delegate: self)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        self.refreshSignatureView()
        self.volunteerInfoPopoverController?.dismissPopoverAnimated(true)
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
    
}