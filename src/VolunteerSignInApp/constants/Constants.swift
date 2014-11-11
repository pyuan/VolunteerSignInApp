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
        case SHARE_OPTIONS = "ShareOptions"
        case SETTINGS = "Settings"
        case PDF_PREVIEW = "PDFRenderer"
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
    
    enum DEFAULT_SETTINGS:String
    {
        case EMAIL = "name@email.com"
        case PROGRAM = "Uptown Tech Club"
        case ORGNIZATION = "Chicago Cares"
        case LOCATION = "Brennemann Elementary School, Chicago"
        case WAIVER = "This is a sample waiver."
    }
    
    enum DEFAULT_SETTINGS_NUM:Float
    {
        case DURATION = 1.0
    }
    
    enum SETTINGS_KEYS:Int
    {
        case EMAIL
        case PROGRAM
        case ORGNIZATION
        case LOCATION
        case DATE
        case DURATION
        case WAIVER
    }
    
    enum ALERT:String
    {
        case TITLE_ERROR = "Whoa!"
        case TITLE_SORRY = "Sorry!"
    }
    
    enum PDF:String
    {
        case FILE_NAME = "volunteers.pdf"
    }
    
    enum ANALYTICS_CATEGORIES:String
    {
        case UI_ACTION = "UI Action"
        case SAVE_SETTINGS_ACTION = "Save Settings Action"
    }
    
    enum ANALYTICS_EVENTS:String
    {
        case PREVIEW_PDF = "Preview PDF"
        case EMAIL_PDF = "Email PDF"
        case DELETE_ALL = "Delete All"
        case DELETE = "Delete"
        case DELETE_SWIPE = "Delete from Swipe"
        case EMAIL_PDF_SENT = "Email PDF Sent"
        case EMAIL_PDF_CANCEL = "Email PDF Cancel"
        case SIGNATURE_CLEAR = "Signature Clear"
        case SIGNATURE_SAVE = "Signature Save"
    }
    
    
}







