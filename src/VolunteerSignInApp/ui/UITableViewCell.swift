//
//  UITableViewCell.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-09.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell
{
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        //set selected background
        var selectedBg:UIView = UIView(frame: self.frame)
        selectedBg.backgroundColor = UIColor.CHICAGO_CARES.BLUE
        self.selectedBackgroundView = selectedBg
    }
    
}