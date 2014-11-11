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
    
    //initialize analytics library
    class func initialize()
    {
        //init google analytics
        // Optional: automatically send uncaught exceptions to Google Analytics.
        GAI.sharedInstance().trackUncaughtExceptions = true
        
        // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
        GAI.sharedInstance().dispatchInterval  = 20
        
        // Optional: set Logger to VERBOSE for debug information.
        GAI.sharedInstance().logger.logLevel = GAILogLevel.Error
        
        // Initialize tracker. Replace with your tracking ID.
        GAI.sharedInstance().trackerWithTrackingId(self.GOOGLE_ANALYTICS_ID)
    }
    
    //send an event
    class func registerEvent(category:String, action:String, label:String)
    {
        let tracker:GAITracker? = GAI.sharedInstance().defaultTracker
        let value:NSNumber = 0
        let params:NSMutableDictionary = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value).build()
        tracker?.send(params)
    }
    
}