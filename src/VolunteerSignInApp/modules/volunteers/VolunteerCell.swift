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
        self.detailTextLabel?.textColor = selected ? UIColor.yellowColor() : UIColor.redColor()
    }
    
    //update for the volunteer
    func update(volunteer:Volunteer) {
        self.textLabel.text = volunteer.getDisplayName()
        self.detailTextLabel?.text = volunteer.signature == nil ? "!" : ""
        self.detailTextLabel?.hidden = volunteer.signature != nil
    }
    
}