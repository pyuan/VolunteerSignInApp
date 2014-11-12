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
    
    //create a PDF file in the file system with the default file name
    class func generatePDF()
    {
        let fileName:String = Constants.PDF.FILE_NAME.rawValue
        let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
        UIGraphicsBeginPDFContextToFile(fileURI, CGRectZero, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, PDF_WIDTH, PDF_HEIGHT), nil)
        
        /*
        let from:CGPoint = CGPointMake(0, 0)
        let to:CGPoint = CGPointMake(200, 300)
        self.drawLineBetweenPoints(from, to: to)
        
        self.drawImagesFromTemplate()
        */
        
        self.drawTextFromTemplate()
        
        UIGraphicsEndPDFContext()
    }
    
    //draw all the labels in the template xib
    class private func drawTextFromTemplate()
    {
        var objects:NSArray = NSBundle.mainBundle().loadNibNamed(TEMPLATE_XIB_NAME, owner: nil, options: nil)
        var mainView:FormTemplateView = objects.objectAtIndex(0) as FormTemplateView
        
        for var i:Int=0; i<mainView.subviews.count; i++
        {
            var view:UIView = mainView.subviews[i] as UIView
            if view.isKindOfClass(UILabel.classForCoder()) {
                var label:UILabel = view as UILabel
                self.drawText(label.text!, inRect: label.frame)
            }
        }
    }
    
    //draw all the images in the template xib
    class private func drawImagesFromTemplate()
    {
        var objects:NSArray = NSBundle.mainBundle().loadNibNamed(TEMPLATE_XIB_NAME, owner: nil, options: nil)
        var mainView:UIView = objects.objectAtIndex(0) as UIView
        
        for var i:Int=0; i<mainView.subviews.count; i++
        {
            var view:UIView = mainView.subviews[i] as UIView
            if view.isKindOfClass(UIImageView.classForCoder()) {
                var imageView:UIImageView = view as UIImageView
                self.drawImageToFill(imageView.image!, inRect: imageView.frame)
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
    class private func drawImageToFill(image:UIImage, inRect rect:CGRect)
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
    
    //draw text into the PDF
    class private func drawText(text:String, inRect rect:CGRect)
    {
        // Prepare the text using a Core Text Framesetter.
        let stringRef:CFStringRef = text
        let currentText:CFAttributedStringRef = CFAttributedStringCreate(nil, stringRef, nil)
        let framesetter:CTFramesetterRef = CTFramesetterCreateWithAttributedString(currentText)
        
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