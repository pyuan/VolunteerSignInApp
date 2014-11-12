//
//  JSONFileService.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class JSONFileService
{
    
    //load volunter info form data
    class func getVolunteerInfoForm() -> NSArray
    {
        var items:NSArray = self.loadJSONFromBundle("volunteer_info") as NSArray
        return items
    }
    
    //load pdf form columns data
    class func getPDFColumns() -> NSArray
    {
        var items:NSArray = self.loadJSONFromBundle("form_template_columns") as NSArray
        return items
    }
    
    //read local json file for data
    private class func loadJSONFromBundle(fileNameWithoutExtension:String) -> AnyObject
    {
        var filePath = NSBundle.mainBundle().pathForResource(fileNameWithoutExtension, ofType: "json") as String?
        var raw:NSData? = NSData.dataWithContentsOfMappedFile(filePath!) as NSData?
        var jsonData:AnyObject = NSJSONSerialization.JSONObjectWithData(raw!, options: NSJSONReadingOptions.MutableContainers, error: nil)!
        return jsonData
    }
    
}