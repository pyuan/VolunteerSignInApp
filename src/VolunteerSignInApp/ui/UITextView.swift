//
//  UITextView.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-08.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

extension UITextView
{
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont.DEFAULT_LABEL()
        self.textColor = UIColor.CHICAGO_CARES.BLUE
    }
    
}