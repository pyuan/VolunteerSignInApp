//
//  EmailUtils.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-10.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import MessageUI

class EmailUtils
{
    
    class func generatePDFEmail(delegate:MFMailComposeViewControllerDelegate?) -> MFMailComposeViewController
    {
        let mail:MFMailComposeViewController = MFMailComposeViewController()
        mail.mailComposeDelegate = delegate
        
        //set email "to" field
        let receipient:String = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.EMAIL.rawValue)
        mail.setToRecipients([receipient])
        
        //set email subject
        let program:String = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.PROGRAM.rawValue)
        let location:String = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.LOCATION.rawValue)
        let subject:String = "Sign-in sheet for " + program + " at " + location
        mail.setSubject(subject)
        
        //add pdf attachment
        let fileName:String = Constants.PDF.FILE_NAME.rawValue
        let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
        let pdfData:NSData = NSData(contentsOfFile: fileURI)!
        mail.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: fileName)
        
        //set message
        let date:String = UserDefaultsService.getProgramDateTime()
        var msg:String = "<h3>Sign-In</h3>"
        msg += "<b>Program: </b>" + program + "<br/>"
        msg += "<b>Date: </b>" + date + "<br/>"
        msg += "<b>Location: </b>" + location + "<br/>"
        mail.setMessageBody(msg, isHTML: true)
        
        return mail
    }
    
}