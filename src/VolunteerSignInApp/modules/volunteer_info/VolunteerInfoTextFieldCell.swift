//
//  VolunteerInfoTextFieldCell.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol VolunteerInfoTextFieldCellDelegate {
    func volunteerInfoTextFieldNext(model:VolunteerInfoFormTextFieldModel?)
    func volunteerInfoTextFieldOnFocus(model:VolunteerInfoFormTextFieldModel?)
}

class VolunteerInfoTextFieldCell:UITableViewCell, UITextFieldDelegate
{
    
    @IBOutlet var textField:UITextField?
    
    var model:VolunteerInfoFormTextFieldModel?
    var delegate:VolunteerInfoTextFieldCellDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.textField?.font = UIFont.DEFAULT_LABEL()
        self.textField?.textColor = UIColor.CHICAGO_CARES.BLUE
        self.textField?.addTarget(self, action: "onTextFieldValueChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.textField?.addTarget(self, action: "onTextFieldValueChangeEnd:", forControlEvents: UIControlEvents.EditingDidEnd)
        self.textField?.addTarget(self, action: "onTextFieldFocus:", forControlEvents: UIControlEvents.EditingDidBegin)
        self.textField?.delegate = self
    }
    
    func update(model:VolunteerInfoFormTextFieldModel) {
        self.model = model
        self.textField?.placeholder = model.placeholder
        self.textField?.text = model.value
        
        //set keyboard attributes based on key
        var keyboardType = UIKeyboardType.Default
        var capType = UITextAutocapitalizationType.Words
        var returnKeyType = UIReturnKeyType.Next
        switch model.key
        {
            case "phone" :
                keyboardType = UIKeyboardType.PhonePad
                break
            case "email":
                keyboardType = UIKeyboardType.EmailAddress
                capType = UITextAutocapitalizationType.None
                returnKeyType = UIReturnKeyType.Done
                break
            default:
                keyboardType = UIKeyboardType.Default
        }
        self.textField?.keyboardType = keyboardType
        self.textField?.autocapitalizationType = capType
        self.textField?.returnKeyType = returnKeyType
    }
    
    func onTextFieldValueChange(sender:AnyObject) {
        let field:UITextField = sender as UITextField
        self.model?.value = field.text
    }
    
    //trim white space
    func onTextFieldValueChangeEnd(sender:AnyObject) {
        let field:UITextField = sender as UITextField
        var whiteSpaceCharSet:NSCharacterSet = NSCharacterSet(charactersInString: " ")
        var newText:String = field.text.stringByTrimmingCharactersInSet(whiteSpaceCharSet)
        field.text = newText
        
        //update model
        self.onTextFieldValueChange(sender)
    }
    
    func onTextFieldFocus(sender:AnyObject) {
        self.delegate?.volunteerInfoTextFieldOnFocus(self.model)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField?.resignFirstResponder()
        self.delegate?.volunteerInfoTextFieldNext(self.model)
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        self.textField?.becomeFirstResponder()
        return true
    }
    
    deinit {
        self.textField?.removeTarget(self, action: "onTextFieldValueChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.textField?.removeTarget(self, action: "onTextFieldValueChangeEnd:", forControlEvents: UIControlEvents.EditingDidEnd)
        self.textField?.removeTarget(self, action: "onTextFieldFocus:", forControlEvents: UIControlEvents.EditingDidBegin)
    }
    
}