//
//  SettingsButton.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-07.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class SettingsButton:UIButton
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let icon:UIImage = UIImage(named: "icon_settings")!
        self.setImage(icon, forState: UIControlState.Normal)
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
}