//
//  AnalyticsService.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-10.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class AnalyticsService
{
    
    class var GOOGLE_ANALYTICS_ID:String { return "UA-12214566-24" }
    
    class func initialize()
    {
        //init google analytics
        // Optional: automatically send uncaught exceptions to Google Analytics.
        GAI.sharedInstance().trackUncaughtExceptions = true
        
        // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
        GAI.sharedInstance().dispatchInterval  = 20
        
        // Optional: set Logger to VERBOSE for debug information.
        GAI.sharedInstance().logger.logLevel = GAILogLevel.Verbose
        
        // Initialize tracker. Replace with your tracking ID.
        GAI.sharedInstance().trackerWithTrackingId(self.GOOGLE_ANALYTICS_ID)
    }
    
}