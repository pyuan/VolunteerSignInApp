//
//  VolunteerDeleteButton.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-10.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteerDeleteButton:UIButton
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let icon:UIImage = UIImage(named: "icon_volunteer_remove")!
        self.setImage(icon, forState: UIControlState.Normal)
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
}