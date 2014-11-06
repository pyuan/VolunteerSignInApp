//
//  PopoverManager.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class PopoverManager
{
    
    //show the volunteer popover in a view
    class func showVolunteerInfo(frame:CGRect, volunteer:Volunteer?, inView view:UIView, delegate:VolunteerInfoViewDelegate?) -> UIPopoverController
    {
        var storyboard:UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAMES.VOLUNTEER_INFO.rawValue, bundle: nil)
        var controller:VolunteerInfoViewController = storyboard.instantiateInitialViewController() as VolunteerInfoViewController
        controller.delegate = delegate
        var popoverController:UIPopoverController = UIPopoverController(contentViewController: controller)
        popoverController.setPopoverContentSize(VolunteerInfoViewController.POPOVER_SIZE, animated: true)
        popoverController.presentPopoverFromRect(frame, inView: view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        return popoverController
    }
    
}