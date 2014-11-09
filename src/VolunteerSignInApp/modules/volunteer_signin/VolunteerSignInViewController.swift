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
    
    @IBOutlet var dateLabel:UILabel?
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var instructionLabel:UILabel?
    @IBOutlet var waiverTextView:UITextView?
    
    @IBOutlet var wrapperView:UIView?
    @IBOutlet var containerView:UIView?
    @IBOutlet var blankView:UIView?
    @IBOutlet var blankLabel:UILabel?
    @IBOutlet var profileButton:UIBarButtonItem?
    
    var delegate:VolunteerSignInDelegate?
    
    private var signatureVC:SignatureViewController?
    private var volunteerInfoPopoverController:UIPopoverController?
    private var volunteer:Volunteer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.blankLabel?.font = UIFont.DEFAULT_LABEL()
        self.blankLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        
        self.dateLabel?.font = UIFont.MICE_TYPE()
        self.dateLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        
        self.titleLabel?.font = UIFont.TITLE_LABEL()
        self.titleLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        
        var paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        var attributedText:NSMutableAttributedString = NSMutableAttributedString(string: self.instructionLabel!.text!)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        self.instructionLabel?.attributedText = attributedText
        self.instructionLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        self.instructionLabel?.numberOfLines = 3
        self.instructionLabel?.sizeToFit()
        
        self.waiverTextView?.editable = false
        self.waiverTextView?.textColor = UIColor.CHICAGO_CARES.GREY
        self.waiverTextView?.font = UIFont.WAIVER()
        
        //reset view
        self.volunteersViewSelectVolunteer(nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.volunteersViewSelectVolunteer(self.volunteer)
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
            self.containerView?.addSubview(self.signatureVC!.view)
            self.signatureVC!.didMoveToParentViewController(self)
        }
        
        //re-adjust signature view
        let h:CGFloat = CGFloat(Constants.SIGNATURE_SIZE.HEIGHT.rawValue)
        self.containerView?.frame = CGRectMake(0, self.wrapperView!.frame.height-h, self.wrapperView!.frame.width, h)
        self.signatureVC?.view.frame = CGRectMake(0, 0, self.containerView!.frame.width, self.containerView!.frame.height)
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
        
        //update title with volunteer name
        let title:String = volunteer == nil ? "" : volunteer!.getDisplayName()
        self.title = title
        
        //update views visibility
        self.wrapperView?.hidden = volunteer == nil
        self.blankView?.hidden = !self.wrapperView!.hidden
        
        var view:UIView = self.profileButton?.valueForKey("view") as UIView
        view.hidden = volunteer == nil
        
        if volunteer != nil
        {
            //update date text
            self.dateLabel?.text = UserDefaultsService.getProgramDateTime()
            
            //update title text
            self.titleLabel?.text = "Hi " + volunteer!.fName + ", welcome to the " + UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.PROGRAM.rawValue)
            
            //update waiver text
            self.waiverTextView?.text = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.WAIVER.rawValue)
            
            //update signature
            var signature:UIImage? = volunteer!.signature != nil ? UIImage(data: volunteer!.signature!) : nil
            self.signatureVC?.setSignature(signature)
            
            //weird bug where signature doesn't show up right away until alignment is refreshed
            TimeUtils.performAfterDelay(0.25, completionHandler: {() -> Void in
                self.refreshSignatureView()
            })
        }
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
        else
        {
            //save signature for volunteer in db
            var attributes:NSMutableDictionary = self.volunteer!.getAttributes().mutableCopy() as NSMutableDictionary
            attributes["signature"] = UIImagePNGRepresentation(signature)
            VolunteerService.updateVolunteer(self.volunteer!, attributes: attributes)
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}