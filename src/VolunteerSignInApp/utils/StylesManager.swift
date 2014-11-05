//
//  StylesManager.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class StylesManager
{
    
    class func initStyles()
    {
        UIView.appearance().tintColor = UIColor.CHICAGO_CARES.BLUE
        UILabel.appearance().font = UIFont.DEFAULT_LABEL()
        UISwitch.appearance().tintColor = UIColor.CHICAGO_CARES.BLUE
        UISwitch.appearance().onTintColor = UIColor.CHICAGO_CARES.BLUE
    }
    
}