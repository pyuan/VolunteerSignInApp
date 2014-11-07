//
//  VolunteerInfoButton.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteerInfoButton:UIButton
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let icon:UIImage = UIImage(named: "icon_volunteer_info")!
        self.setImage(icon, forState: UIControlState.Normal)
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
}