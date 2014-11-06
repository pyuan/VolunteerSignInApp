//
//  VolunteerInfoViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-03.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteerSignInViewController:UIViewController
{
    
    @IBOutlet var bottomView:UIView?
    
    private var signatureVC:SignatureViewController?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshSignatureView()
    }
    
    //programmatically add signature view controller
    private func refreshSignatureView()
    {
        if self.signatureVC == nil {
            var storyboard:UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.SIGNATURE.rawValue, bundle: nil)
            self.signatureVC = storyboard.instantiateInitialViewController() as? SignatureViewController
            self.addChildViewController(self.signatureVC!)
            self.view.addSubview(self.signatureVC!.view)
            self.signatureVC!.didMoveToParentViewController(self)
        }
        
        //re-adjust signature view
        self.signatureVC!.view.frame = self.bottomView!.frame
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        self.refreshSignatureView()
    }
    
}