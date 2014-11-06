//
//  VolunteerInfoFormTextFieldModel.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class VolunteerInfoFormTextFieldModel
{
    
    var key:String = ""
    var placeholder:String = ""
    var value:String = ""
    
    init(attributes:NSDictionary)
    {
        self.key = attributes["key"] as String
        self.placeholder = attributes["placeholder"] as String
    }
    
}