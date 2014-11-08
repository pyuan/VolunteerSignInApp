//
//  Constants.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation

class Constants
{

    enum STORYBOARD_NAMES:String
    {
        case VOLUNTEER_INFO = "VolunteerInfo"
        case VOLUNTEER_SIGN_IN = "VolunteerSignIn"
        case VOLUNTEERS = "Volunteers"
        case SIGNATURE = "Signature"
    }
    
    enum NOTIFICATION_CENTER_OBSERVER_NAMES:String
    {
        case SHOW_SETTINGS = "notificationShowSettings"
        case SHOW_PDF_VIEWER = "notificationShowPDF"
    }
    
    enum SIGNATURE_SIZE:Float
    {
        case HEIGHT = 250
    }
    
}