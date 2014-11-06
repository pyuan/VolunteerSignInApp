//
//  VolunteerFormService.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class VolunteerFormService
{
    
    class func getFormFields() -> [VolunteerInfoFormTextFieldModel]
    {
        var items:NSArray = JSONFileService.getVolunteerInfoForm()
        var fields:[VolunteerInfoFormTextFieldModel] = [VolunteerInfoFormTextFieldModel]()
        for item in items {
            var attributes:NSDictionary = item as NSDictionary
            var field:VolunteerInfoFormTextFieldModel = VolunteerInfoFormTextFieldModel(attributes: attributes)
            fields.append(field)
        }
        return fields
    }
    
}