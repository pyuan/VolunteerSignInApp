//
//  UserDefaultsService.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-09.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class UserDefaultsService
{
    
    class func getDefaultForKey(key:Int) -> String
    {
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var value:AnyObject? = defaults.valueForKey(key.description)
        
        if value == nil
        {
            switch key
            {
            case Constants.SETTINGS_KEYS.EMAIL.rawValue:
                value = Constants.DEFAULT_SETTINGS.EMAIL.rawValue
                break
            case Constants.SETTINGS_KEYS.PROGRAM.rawValue:
                value = Constants.DEFAULT_SETTINGS.PROGRAM.rawValue
                break
            case Constants.SETTINGS_KEYS.DATE.rawValue:
                var today:NSDate = NSDate()
                value = TimeUtils.dateToString(today)
                break
            case Constants.SETTINGS_KEYS.ORGNIZATION.rawValue:
                value = Constants.DEFAULT_SETTINGS.ORGNIZATION.rawValue
                break
            case Constants.SETTINGS_KEYS.LOCATION.rawValue:
                value = Constants.DEFAULT_SETTINGS.LOCATION.rawValue
                break
            case Constants.SETTINGS_KEYS.WAIVER.rawValue:
                value = Constants.DEFAULT_SETTINGS.WAIVER.rawValue
                break
            default:
                value = ""
            }
        }
        
        return value!.description
    }
    
    //set the value for a key, if value is empty or is one of the defaults, set value as nil
    class func setDefaultForKey(value:String, forKey key:Int)
    {
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var isSameAsDefaultValue:Bool = false
        var analyticsKey:String = ""
        
        switch key
        {
        case Constants.SETTINGS_KEYS.EMAIL.rawValue:
            isSameAsDefaultValue = value == Constants.DEFAULT_SETTINGS.EMAIL.rawValue
            break
        case Constants.SETTINGS_KEYS.PROGRAM.rawValue:
            isSameAsDefaultValue = value == Constants.DEFAULT_SETTINGS.PROGRAM.rawValue
            analyticsKey = "program name"
            break
        case Constants.SETTINGS_KEYS.ORGNIZATION.rawValue:
            isSameAsDefaultValue = value == Constants.DEFAULT_SETTINGS.ORGNIZATION.rawValue
            analyticsKey = "organization name"
            break
        case Constants.SETTINGS_KEYS.LOCATION.rawValue:
            isSameAsDefaultValue = value == Constants.DEFAULT_SETTINGS.LOCATION.rawValue
            analyticsKey = "location"
            break
        case Constants.SETTINGS_KEYS.WAIVER.rawValue:
            isSameAsDefaultValue = value == Constants.DEFAULT_SETTINGS.WAIVER.rawValue
            break
        default:
            isSameAsDefaultValue = false
        }
        
        value.isEmpty || isSameAsDefaultValue ? defaults.setObject(nil, forKey: key.description) : defaults.setObject(value, forKey: key.description)
        
        //track saved setting if set and different from default, dont track waiver
        if !value.isEmpty && !isSameAsDefaultValue && !analyticsKey.isEmpty
        {
            AnalyticsService.registerEvent(Constants.ANALYTICS_CATEGORIES.SAVE_SETTINGS_ACTION.rawValue, action: analyticsKey, label: value)
        }
    }
    
    //return the program date time string with duration
    class func getProgramDateTime() -> String
    {
        var dateString:String = self.getDefaultForKey(Constants.SETTINGS_KEYS.DATE.rawValue)
        var date:NSDate? = TimeUtils.stringToDate(dateString)
        if date == nil {
            date = NSDate()
        }
        
        var formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY hh:mm a"
        dateString = formatter.stringFromDate(date!)
        
        var duration:Double = Double((self.getDefaultForKey(Constants.SETTINGS_KEYS.DURATION.rawValue) as NSString).floatValue)
        var toDate:NSDate = date!.dateByAddingTimeInterval(60 * 60 * duration)
        formatter.dateFormat = "hh:mm a"
        dateString += " - " + formatter.stringFromDate(toDate)
        
        return dateString
    }
    
}