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
        println(masterNC.viewControllers)
        var masterVC:VolunteersViewController = masterNC.viewControllers[0] as VolunteersViewController
        masterVC.delegate = detailVC
        
        self.viewControllers = [masterNC, detailNC]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
        return false
    }
    
}