//
//  UIBarButtonItem.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem
{
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        var att:NSMutableDictionary = NSMutableDictionary()
        att[NSFontAttributeName] = UIFont.DEFAULT_BUTTON_LABEL()
        att[NSForegroundColorAttributeName] = UIColor.CHICAGO_CARES.BLUE
        self.setTitleTextAttributes(att, forState: UIControlState.Normal)
    }
    
}