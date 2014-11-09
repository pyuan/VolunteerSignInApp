//
//  SettingsViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-07.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController:UIViewController, UITextFieldDelegate, UITextViewDelegate
{
    
    @IBOutlet var wrapperView:UIView?
    @IBOutlet var versionLabel:UILabel?
    @IBOutlet var madeByLabel:UILabel?
    
    @IBOutlet var emailField:UITextField?
    @IBOutlet var actName:UITextField?
    @IBOutlet var actDate:UITextField?
    @IBOutlet var actDuration:UITextField?
    @IBOutlet var actOrg:UITextField?
    @IBOutlet var actLocation:UITextField?
    @IBOutlet var waiverTextView:UITextView?
    
    private var originalCenter:CGPoint?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.wrapperView?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.wrapperView?.layer.cornerRadius = 5
        self.wrapperView?.clipsToBounds = true
        
        self.madeByLabel?.font = UIFont.SETTINGS_BY_TYPE()
        self.madeByLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        
        var info:NSDictionary = NSBundle.mainBundle().infoDictionary! as NSDictionary
        var versionNumber:String = info.objectForKey("CFBundleShortVersionString") as String
        var buildNumber:String = info.objectForKey("CFBundleVersion") as String
        self.versionLabel?.text = "v." + versionNumber + "." + buildNumber
        self.versionLabel?.font = UIFont.MICE_TYPE()
        self.versionLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        
        self.emailField?.delegate = self
        self.actName?.delegate = self
        self.actDate?.delegate = self
        self.actDuration?.delegate = self
        self.actOrg?.delegate = self
        self.actLocation?.delegate = self
        self.waiverTextView?.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let notif:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notif.addObserver(self, selector: "onKeyboardShow", name: UIKeyboardDidShowNotification, object: nil)
        notif.addObserver(self, selector: "onKeyboardHide", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let notif:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notif.removeObserver(self)
    }
    
    func onKeyboardShow()
    {
        var isLandscape:Bool = UIInterfaceOrientationIsLandscape(self.interfaceOrientation)
        if isLandscape && self.originalCenter == nil {
            self.slideUp()
        }
    }
    
    func onKeyboardHide()
    {
        var isLandscape:Bool = UIInterfaceOrientationIsLandscape(self.interfaceOrientation)
        if isLandscape && self.originalCenter != nil {
            self.slideBack()
        }
    }
    
    func slideUp()
    {
        let firstResponder:UIView? = self.getFirstResponder() as? UIView
        let amount:CGFloat = firstResponder != nil && firstResponder === self.waiverTextView ? 325 : 55
        self.originalCenter = self.view.center
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
            
            self.view.center = CGPointMake(self.originalCenter!.x, self.originalCenter!.y - amount)
            
            }, completion: {(finished:Bool) -> Void in })
    }
    
    func slideBack()
    {
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
            
            self.view.center = self.originalCenter!
            self.originalCenter = nil
            
            }, completion: {(finished:Bool) -> Void in })
    }
    
    //go to the next field when return/next is tapped
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        var tag:Int = textField.tag + 1
        var nextField:UIView? = self.view.viewWithTag(tag)
        if nextField != nil {
            nextField?.becomeFirstResponder()
        }
        return true
    }
    
    //get the element that is currently the first responder
    private func getFirstResponder() -> AnyObject?
    {
        if self.isFirstResponder() {
            return self
        }
        
        for var i:Int=0; i<self.wrapperView?.subviews.count; i++ {
            var subview:UIView = self.wrapperView!.subviews[i] as UIView
            if subview.isFirstResponder() {
                return subview
            }
        }
        
        return nil
    }
    
    //update the user preferences
    @IBAction func onDone()
    {
        println("done")
        self.performSegueWithIdentifier("unwindToMain", sender: self)
    }
    
}