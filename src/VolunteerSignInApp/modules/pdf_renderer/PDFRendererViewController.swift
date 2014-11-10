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
import MessageUI

class PDFRendererViewController:UIViewController, MFMailComposeViewControllerDelegate
{
    
    @IBOutlet var webView:UIWebView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let fileName:String = Constants.PDF.FILE_NAME.rawValue
        self._createPDF(fileName)
        self._showPDF(fileName)
        //self._createEmailWithPDF(fileName)
    }
    
    func _createPDF(fileName:String)
    {
        let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
        UIGraphicsBeginPDFContextToFile(fileURI, CGRectZero, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil)
        
        let from:CGPoint = CGPointMake(0, 0)
        let to:CGPoint = CGPointMake(200, 300)
        self._drawLineFromPoint(from, to: to)
        
        self._drawImagesFromTemplate()
        
        UIGraphicsEndPDFContext()
    }
    
    //draw all the images in the template xib
    func _drawImagesFromTemplate()
    {
        var objects:NSArray = NSBundle.mainBundle().loadNibNamed("FormTemplate", owner: nil, options: nil)
        var mainView:UIView = objects.objectAtIndex(0) as UIView
        
        for var i:Int=0; i<mainView.subviews.count; i++
        {
            var view:UIView = mainView.subviews[i] as UIView
            if view.isKindOfClass(UIImageView.classForCoder()) {
                var imageView:UIImageView = view as UIImageView
                self._drawImageToFill(imageView.image!, inRect: imageView.frame)
            }
        }
    }
    
    //draw an image into the PDF
    func _drawImageToFill(image:UIImage, inRect rect:CGRect)
    {
        let diffW:CGFloat = abs(rect.size.width - image.size.width)
        let diffH:CGFloat = abs(rect.size.height - image.size.height)
        let scaleX:CGFloat = rect.width / image.size.width
        let scaleY:CGFloat = rect.height / image.size.height
        let scale:CGFloat = diffW > diffH ? scaleX : scaleY
        let w:CGFloat = rect.width * scale
        let h:CGFloat = rect.height * scale
        let x:CGFloat = rect.origin.x + (rect.width-w)/2
        let y:CGFloat = rect.origin.y + (rect.height-h)/2
        let frame:CGRect = CGRectMake(x, y, w, h)
        image.drawInRect(frame)
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
    
    func _createEmailWithPDF(fileName:String)
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Hello Paul")
            
            let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
            let pdfData:NSData = NSData(contentsOfFile: fileURI)!
            mail.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: fileName)
            mail.setMessageBody("<h1>Check out my PDF file</h1><br/>This is not a <b>virus</b>!", isHTML: true)
            
            self.presentViewController(mail, animated: true, completion: nil)
        }
        else {
            println("MFMailComposeViewController cannot send mail")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!)
    {
        switch result.value
        {
        case MFMailComposeResultCancelled.value:
            println("MFMailComposeResultCancelled")
            break
        case MFMailComposeResultSaved.value:
            println("MFMailComposeResultSaved")
            break
        case MFMailComposeResultSent.value:
            println("MFMailComposeResultSent")
            break
        case MFMailComposeResultFailed.value:
            println("MFMailComposeResultFailed")
            break
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}