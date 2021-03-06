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
    class func MICE_TYPE() -> UIFont { return UIFont(name: "Gotham-Book", size: 10.0)! }
    class func SETTINGS_BY_TYPE() -> UIFont { return UIFont(name: "Gotham-Book", size: 12.0)! }
    class func TITLE_LABEL() -> UIFont { return UIFont(name: "Gotham-Medium", size: 16.0)! }
    class func WAIVER() -> UIFont { return UIFont(name: "Gotham-Book", size: 12)! }
    class func VOLUNTEER_CELL_ICON() -> UIFont { return UIFont(name: "Gotham-Medium", size: 16)! }
    
    class func PDF_TITLE() -> UIFont { return UIFont(name: "Gotham-Medium", size: 14)! }
    class func PDF_TABLE_HEADER() -> UIFont { return UIFont(name: "Gotham-Medium", size: 10)! }
    class func PDF_TABLE_BODY() -> UIFont { return UIFont(name: "Gotham-Book", size: 10)! }
    
    //class func NOTES_DATE_LABEL() -> UIFont { return UIFont(name: "Gotham-Bold", size: 14.0)! }
    //class func NOTES_TEXT() -> UIFont { return UIFont(name: "Georgia", size: 20.0)! }
}