//
//  ShareOptionCell.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-09.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class ShareOptionCell:UITableViewCell
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel.textAlignment = NSTextAlignment.Center
        self.setSelected(false, animated: true)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.textLabel.textColor = selected ? UIColor.CHICAGO_CARES.WHITE : UIColor.CHICAGO_CARES.BLUE
    }
    
}