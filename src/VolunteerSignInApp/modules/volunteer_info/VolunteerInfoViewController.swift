//
//  VolunteerInfoViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-03.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteerInfoViewController:UIViewController
{
    
    @IBOutlet var bottomView:UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //programmatically add signature view controller
        var storyboard:UIStoryboard = UIStoryboard(name: "Signature", bundle: nil)
        var signatureVC:UIViewController = storyboard.instantiateInitialViewController() as UIViewController
        signatureVC.view.frame = self.bottomView!.frame
        self.addChildViewController(signatureVC)
        self.view.addSubview(signatureVC.view)
        signatureVC.didMoveToParentViewController(self)
    }
    
}