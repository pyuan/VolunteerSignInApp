//
//  TimeUtils.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-06.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class TimeUtils
{
    
    class var DATE_FORMAT:String { return "YYYY/MM/dd HH:mm" }
    
    //execute a function block after some delay
    class func performAfterDelay(delayInSeconds:Float, completionHandler: () -> Void)
    {
        var delay:Int64 = Int64(Float(NSEC_PER_SEC) * delayInSeconds)
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(popTime, dispatch_get_main_queue(), {() -> Void in
            completionHandler()
        })
    }
    
    //convert a date to a string
    class func dateToString(date:NSDate) -> String {
        var formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = self.DATE_FORMAT
        var dateString:String = formatter.stringFromDate(date)
        return dateString
    }
    
    //conver string to a date
    class func stringToDate(dateString:String) -> NSDate? {
        var formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = self.DATE_FORMAT
        var date:NSDate? = formatter.dateFromString(dateString)
        return date
    }
    
}