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
    
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var iconLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconLabel?.textAlignment = NSTextAlignment.Right
        self.iconLabel?.font = UIFont.VOLUNTEER_CELL_ICON()
        
        //set selected background
        var selectedBg:UIView = UIView(frame: self.frame)
        selectedBg.backgroundColor = UIColor.CHICAGO_CARES.BLUE
        self.selectedBackgroundView = selectedBg
        
        self.setSelected(false, animated: true)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.titleLabel?.textColor = selected ? UIColor.CHICAGO_CARES.WHITE : UIColor.CHICAGO_CARES.BLUE
        self.iconLabel?.textColor = selected ? UIColor.yellowColor() : UIColor.redColor()
    }
    
    //update for the volunteer
    func update(volunteer:Volunteer?)
    {
        self.titleLabel?.text = volunteer!.getDisplayName()
        self.iconLabel?.text = volunteer!.signature == nil ? "!" : ""
        self.iconLabel?.hidden = volunteer!.signature != nil
    }
    
}