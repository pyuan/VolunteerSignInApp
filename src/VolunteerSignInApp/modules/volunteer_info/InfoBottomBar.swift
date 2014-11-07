//
//  InfoBottomBar.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol InfoBottomBarDelegate {
    func infoBottomBarSave(isOver18:Bool)
}

class InfoBottomBar:UIView
{
    
    @IBOutlet var over18Label:UILabel?
    @IBOutlet var over18Switch:UISwitch?
    @IBOutlet var saveBtn:UIButton?
    
    var delegate:InfoBottomBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.CHICAGO_CARES.BLUE
        
        self.over18Label?.font = UIFont.UICONTROL_LABEL()
        self.over18Label?.textColor = UIColor.CHICAGO_CARES.WHITE
        
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "toggleSwitch")
        tap.numberOfTapsRequired = 1
        self.over18Label?.addGestureRecognizer(tap)
        self.over18Label?.userInteractionEnabled = true
        
        self.over18Switch?.tintColor = UIColor.CHICAGO_CARES.WHITE
        self.over18Switch?.onTintColor = UIColor.CHICAGO_CARES.WHITE
        self.over18Switch?.thumbTintColor = UIColor.CHICAGO_CARES.GREEN
        
        self.saveBtn?.tintColor = UIColor.CHICAGO_CARES.WHITE
        
        var swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "onSwipeLeft")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeLeft)
        
        var swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "onSwipeRight")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(swipeRight)
        
        self.userInteractionEnabled = true
    }
    
    func setIsOver18(isOver18:Bool) {
        self.over18Switch?.setOn(isOver18, animated: true)
    }
    
    func toggleSwitch() {
        self.over18Switch!.setOn(!self.over18Switch!.on, animated: true)
    }
    
    func onSwipeLeft() {
        self.over18Switch?.setOn(false, animated: true)
    }
    
    func onSwipeRight() {
        self.over18Switch?.setOn(true, animated: true)
    }
    
    @IBAction func save() {
        self.delegate?.infoBottomBarSave(self.over18Switch!.on)
    }
    
}