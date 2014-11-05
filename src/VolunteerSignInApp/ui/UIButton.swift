//
//  UIButton.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

extension UIButton
{
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.font = UIFont.DEFAULT_BUTTON_LABEL()
    }
    
}