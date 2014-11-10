//
//  MainSplitViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-10-14.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class MainSplitViewController:UISplitViewController, UISplitViewControllerDelegate
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //instantiate detail view controller
        var storyboard:UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.VOLUNTEER_SIGN_IN.rawValue, bundle: nil)
        var detailNC:UINavigationController = storyboard.instantiateInitialViewController() as UINavigationController
        var detailVC:VolunteerSignInViewController = detailNC.viewControllers[0] as VolunteerSignInViewController
        
        //instantiate master view controller
        storyboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.VOLUNTEERS.rawValue, bundle: nil)
        var masterNC:UINavigationController = storyboard.instantiateInitialViewController() as UINavigationController
        var masterVC:VolunteersViewController = masterNC.viewControllers[0] as VolunteersViewController
        
        masterVC.delegate = detailVC
        detailVC.delegate = masterVC
        
        self.viewControllers = [masterNC, detailNC]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        
        let notif:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notif.addObserver(self, selector: "showSettings", name: Constants.NOTIFICATION_CENTER_OBSERVER_NAMES.SHOW_SETTINGS.rawValue, object: nil)
        notif.addObserver(self, selector: "showPDFPreview", name: Constants.NOTIFICATION_CENTER_OBSERVER_NAMES.SHOW_PDF_VIEWER.rawValue, object: nil)
    }
    
    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
        return false
    }
    
    @IBAction func unwindToMain(s:UIStoryboardSegue) { }
    
    func showSettings()
    {
        var storyboard:UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.SETTINGS.rawValue, bundle: nil)
        var controller:UIViewController = storyboard.instantiateInitialViewController() as UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func showPDFPreview()
    {
        var storyboard:UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.PDF_PREVIEW.rawValue, bundle: nil)
        var controller:UIViewController = storyboard.instantiateInitialViewController() as UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    deinit {
        let notif:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notif.removeObserver(self)
    }
    
}