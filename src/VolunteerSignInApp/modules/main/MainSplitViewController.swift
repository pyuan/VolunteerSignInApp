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
        
        //instantiate master view controller
        var storyboard:UIStoryboard = UIStoryboard(name: "Volunteers", bundle: nil)
        var masterVC:UIViewController = storyboard.instantiateInitialViewController() as UIViewController
        
        //instantiate detail view controller
        storyboard = UIStoryboard(name: "VolunteerInfo", bundle: nil)
        var detailVC:UIViewController = storyboard.instantiateInitialViewController() as UIViewController
        self.viewControllers = [masterVC, detailVC]
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