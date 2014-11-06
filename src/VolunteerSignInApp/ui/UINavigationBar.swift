//
//  UINavigationBar.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar
{
    
    public override func awakeFromNib()
    {
        super.awakeFromNib()
        
        var att:NSMutableDictionary = NSMutableDictionary()
        att[NSForegroundColorAttributeName] = UIColor.CHICAGO_CARES.GREY
        att[NSFontAttributeName] = UIFont.DEFAULT_NAV_BAR_TITLE()
        self.titleTextAttributes = att
    }
    
}