//
//  VolunteerCell.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteerCell:UITableViewCell
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set selected background
        var selectedBg:UIView = UIView(frame: self.frame)
        selectedBg.backgroundColor = UIColor.CHICAGO_CARES.BLUE
        self.selectedBackgroundView = selectedBg
        
        self.setSelected(false, animated: true)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.textLabel.textColor = selected ? UIColor.CHICAGO_CARES.WHITE : UIColor.CHICAGO_CARES.BLUE
    }
    
}