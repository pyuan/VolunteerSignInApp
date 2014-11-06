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
    
    //execute a function block after some delay
    class func performAfterDelay(delayInSeconds:Float, completionHandler: () -> Void)
    {
        var delay:Int64 = Int64(Float(NSEC_PER_SEC) * delayInSeconds)
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(popTime, dispatch_get_main_queue(), {() -> Void in
            completionHandler()
        })
    }
    
}