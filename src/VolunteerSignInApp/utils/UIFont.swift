//
//  UIFont.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit


extension UIFont
{
    class func DEFAULT_LABEL() -> UIFont { return UIFont(name: "Gotham-Book", size: 16.0)! }
    class func DEFAULT_BUTTON_LABEL() -> UIFont { return UIFont(name: "Gotham-Medium", size: 16.0)! }
    class func DEFAULT_NAV_BAR_TITLE() -> UIFont { return UIFont(name: "Gotham-Book", size: 20.0)! }
    class func UICONTROL_LABEL() -> UIFont { return UIFont(name: "Gotham-Book", size: 14.0)! }
    
    class func NOTES_DATE_LABEL() -> UIFont { return UIFont(name: "Gotham-Bold", size: 14.0)! }
    class func NOTES_TEXT() -> UIFont { return UIFont(name: "Georgia", size: 20.0)! }
}