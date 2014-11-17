//
//  PDFRenderer.swift
//  VolunteerSignInApp
//
//  source: http://www.raywenderlich.com/6581/how-to-create-a-pdf-with-quartz-2d-in-ios-5-tutorial-part-1
//  Created by Paul Yuan on 2014-10-24.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import CoreText

class PDFRenderer
{
    
    class var TEMPLATE_XIB_NAME : String { return "FormTemplate" }
    class var PDF_WIDTH : CGFloat { return 792 }
    class var PDF_HEIGHT : CGFloat { return 612 }
    class var VOLUNTEERS_PER_PAGE : Int { return 10 }
    
    //create a PDF file in the file system with the default file name
    class func generatePDF()
    {
        let fileName:String = Constants.PDF.FILE_NAME.rawValue
        let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
        UIGraphicsBeginPDFContextToFile(fileURI, CGRectZero, nil)
        
        let volunteers:[Volunteer] = VolunteerService.getAllVolunteers()
        var group:[Volunteer] = [Volunteer]()
        for var i:Int=0; i<volunteers.count; i++
        {
            let volunteer:Volunteer = volunteers[i]
            group.append(volunteer)

            if group.count > PDFRenderer.VOLUNTEERS_PER_PAGE || i == volunteers.count - 1
            {
                self.startNewPDFPageFromTemplate(group)
                group = [Volunteer]()
            }
        }

        UIGraphicsEndPDFContext()
    }
    
    //start a new page in the PDF
    class func startNewPDFPageFromTemplate(volunteers:[Volunteer])
    {
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, PDF_WIDTH, PDF_HEIGHT), nil)
        
        //load template and populate with data
        var objects:NSArray = NSBundle.mainBundle().loadNibNamed(TEMPLATE_XIB_NAME, owner: nil, options: nil)
        var template:FormTemplateView = objects.objectAtIndex(0) as FormTemplateView
        
        //render view with volunteers
        template.setVolunteers(volunteers)
        
        //render all the text labels
        self.drawTextFromTemplate(template)
        
        //render all the uiimages
        self.drawImagesFromTemplate(template)
        
        //TODO: draw all lines
        
        /*
        let from:CGPoint = CGPointMake(0, 0)
        let to:CGPoint = CGPointMake(200, 300)
        self.drawLineBetweenPoints(from, to: to)
        
        self.drawImagesFromTemplate()
        */
    }
    
    //draw all the labels in the template xib
    class private func drawTextFromTemplate(template:UIView)
    {
        for var i:Int=0; i<template.subviews.count; i++
        {
            var view:UIView = template.subviews[i] as UIView
            if view.isKindOfClass(UILabel.classForCoder())
            {
                let label:UILabel = view as UILabel
                let fontName:String = label.font.fontName
                let fontSize:CGFloat = label.font.pointSize
                let fontColor:UIColor = label.textColor
                self.drawText(label.text!, fontName: fontName, fontSize: fontSize, fontColor: fontColor, inRect: label.frame)
            }
        }
    }
    
    //draw all the images in the template xib
    class private func drawImagesFromTemplate(template:UIView)
    {
        for var i:Int=0; i<template.subviews.count; i++
        {
            var view:UIView = template.subviews[i] as UIView
            if view.isKindOfClass(UIImageView.classForCoder()) {
                var imageView:UIImageView = view as UIImageView
                if imageView.image != nil {
                    self.drawImageToFill(imageView, inRect: imageView.frame)
                }
            }
        }
    }
    
    //draw a line between 2 points
    class private func drawLineBetweenPoints(from:CGPoint, to:CGPoint)
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
    
    //draw an image into the PDF and resize it to fill rect proportionally
    class private func drawImageToFill(imageView:UIImageView, inRect rect:CGRect)
    {
        let image:UIImage = imageView.image!
        
        //move image up because unlike textfields, images do not get flipped
        var adjusted:CGRect = CGRectMake(rect.origin.x, rect.origin.y - rect.height, rect.width, rect.height)
        let diffW:CGFloat = abs(adjusted.size.width - image.size.width)
        let diffH:CGFloat = abs(adjusted.size.height - image.size.height)
        let scaleX:CGFloat = adjusted.width / image.size.width
        let scaleY:CGFloat = adjusted.height / image.size.height
        let scale:CGFloat = diffW < diffH ? scaleX : scaleY
        let w:CGFloat = image.size.width * scale
        let h:CGFloat = image.size.height * scale
        let x:CGFloat = adjusted.origin.x + (adjusted.width - w)/2
        let y:CGFloat = adjusted.origin.y + (adjusted.height - h)/2
        var frame:CGRect = CGRectMake(x, y, w, h)
        
        //for signature, need to position left aligned and add offset vertically
        if imageView.tag == FormTemplateView.TAG_SIGNATURES {
            frame.origin = CGPointMake(adjusted.origin.x, adjusted.origin.y - frame.height/2)
        }
        
        //render image in rect
        image.drawInRect(frame)
    }
    
    //draw text into the PDF
    class private func drawText(text:String, fontName:String, fontSize:CGFloat, fontColor:UIColor, inRect rect:CGRect)
    {
        /*let context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextFillRect(context, rect)*/
        
        let font:CTFontRef = CTFontCreateWithName(fontName, fontSize, nil)
        let attributes:NSMutableDictionary = NSMutableDictionary()
        attributes.setValue(font, forKey: kCTFontAttributeName)
        attributes.setValue(fontColor.CGColor, forKey: kCTForegroundColorAttributeName)
        
        let attString:NSAttributedString = NSAttributedString(string: text, attributes: attributes)
        let framesetter:CTFramesetterRef = CTFramesetterCreateWithAttributedString(attString)
        
        let framePath:CGMutablePathRef = CGPathCreateMutable()
        CGPathAddRect(framePath, nil, rect)
        
        // Get the frame that will do the rendering.
        let currentRange:CFRange = CFRangeMake(0, 0)
        let frameRef:CTFrameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, nil)
        
        // Get the graphics context.
        let currentContext:CGContextRef = UIGraphicsGetCurrentContext()
        
        // Put the text matrix into a known state. This ensures
        // that no old scaling factors are left in place.
        CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity)
        
        // Core Text draws from the bottom-left corner up, so flip
        // the current transform prior to drawing.
        CGContextTranslateCTM(currentContext, 0, rect.origin.y*2)
        CGContextScaleCTM(currentContext, 1.0, -1.0)
        
        // Draw the frame.
        CTFrameDraw(frameRef, currentContext)
        
        // Add these two lines to reverse the earlier transformation.
        CGContextScaleCTM(currentContext, 1.0, -1.0)
        CGContextTranslateCTM(currentContext, 0, -rect.origin.y*2)
    }
    
    //get the full pathf or a file with the file name
    class func getFileURIWithFileName(fileName:String) -> String
    {
        let arrayPaths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path:NSString = arrayPaths.objectAtIndex(0) as NSString
        let pdfFileName:NSString = path.stringByAppendingPathComponent(fileName)
        return pdfFileName
    }
    
}