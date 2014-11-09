//
//  SettingsTextView.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-08.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class SettingsTextView:UITextView
{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let notif:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notif.addObserver(self, selector: "onEditEnd:", name: UITextViewTextDidEndEditingNotification, object: nil)
    }
    
    //trim white space
    func onEditEnd(sender:AnyObject) {
        var whiteSpaceCharSet:NSCharacterSet = NSCharacterSet(charactersInString: " \n")
        var newText:String = self.text.stringByTrimmingCharactersInSet(whiteSpaceCharSet)
        if newText.isEmpty {
            newText = Constants.DEFAULT_SETTINGS.WAIVER.rawValue
        }
        self.text = newText
    }
    
}