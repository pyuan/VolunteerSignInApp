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
    
    //get the fields for the volunteer info popover
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
    
    //get the columns for the pdf
    class func getPDFColumns() -> NSArray
    {
        var items:NSArray = JSONFileService.getPDFColumns()
        return items
    }
    
}