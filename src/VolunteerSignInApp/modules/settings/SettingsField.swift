//
//  SettingsField.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-07.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class SettingsField:UITextField
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: "onTextFieldValueChangeEnd:", forControlEvents: UIControlEvents.EditingDidEnd)
    }
    
    //trim white space
    func onTextFieldValueChangeEnd(sender:AnyObject) {
        var whiteSpaceCharSet:NSCharacterSet = NSCharacterSet(charactersInString: " ")
        var newText:String = self.text.stringByTrimmingCharactersInSet(whiteSpaceCharSet)
        self.text = newText
    }
    
    deinit {
        self.removeTarget(self, action: "onTextFieldValueChangeEnd:", forControlEvents: UIControlEvents.EditingDidEnd)
    }
    
}