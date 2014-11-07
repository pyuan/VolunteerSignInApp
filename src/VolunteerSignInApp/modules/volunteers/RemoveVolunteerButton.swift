//
//  RemoveVolunteerButton.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class RemoveVolunteerButton:UIButton
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let icon:UIImage = UIImage(named: "icon_volunteer_remove")!
        let imageView:UIImageView = UIImageView(image: icon)
        let margin:CGFloat = 3
        imageView.frame = CGRectMake(margin, margin, self.frame.height-margin*2, self.frame.height-margin*2)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.tintColor = UIColor.CHICAGO_CARES.BLUE
        self.addSubview(imageView)
        
        self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.setTitle("All", forState: UIControlState.Normal)
        self.titleLabel?.textAlignment = NSTextAlignment.Left
        self.frame.size = CGSizeMake(80, self.frame.height)
    }
    
}