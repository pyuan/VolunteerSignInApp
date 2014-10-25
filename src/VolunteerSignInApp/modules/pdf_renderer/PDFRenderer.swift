//
//  PDFRenderer.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-10-24.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import CoreText

class PDFRenderer
{
    
    class func getFileURIWithFileName(fileName:String) -> String
    {
        let arrayPaths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path:NSString = arrayPaths.objectAtIndex(0) as NSString
        let pdfFileName:NSString = path.stringByAppendingPathComponent(fileName)
        return pdfFileName
    }
    
}