//
//  PDFRendererViewController.swift
//  VolunteerSignInApp
//  
//  source: http://www.raywenderlich.com/6581/how-to-create-a-pdf-with-quartz-2d-in-ios-5-tutorial-part-1
//  Created by Paul Yuan on 2014-10-24.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit
import CoreText

class PDFRendererViewController:UIViewController
{
    
    @IBOutlet var webView:UIWebView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let fileName:String = "test.pdf"
        self._createPDF(fileName)
        self._showPDF(fileName)
    }
    
    func _createPDF(fileName:String)
    {
        let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
        UIGraphicsBeginPDFContextToFile(fileURI, CGRectZero, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil)
        
        let from:CGPoint = CGPointMake(0, 0)
        let to:CGPoint = CGPointMake(200, 300)
        self._drawLineFromPoint(from, to: to)
        
        UIGraphicsEndPDFContext()
    }
    
    func _drawLineFromPoint(from:CGPoint, to:CGPoint)
    {
        let context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()
        let components:[CGFloat] = [0.2, 0.2, 0.2, 0.3]
        let color:CGColorRef = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, from.x, from.y)
        CGContextAddLineToPoint(context, to.x, to.y)
        CGContextStrokePath(context)
    }
    
    func _showPDF(fileName:String)
    {
        let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
        let url:NSURL? = NSURL.fileURLWithPath(fileURI)?
        if url != nil
        {
            let request:NSURLRequest = NSURLRequest(URL: url!)
            self.webView?.scalesPageToFit = true
            self.webView?.loadRequest(request)
        }
        else
        {
            println("Error: file note found - " + fileName)
        }
    }
    
}