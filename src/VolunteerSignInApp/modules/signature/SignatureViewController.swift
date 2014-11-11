//
//  SignatureViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-10-14.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol SignatureViewDelegate {
    func signatureViewOnSave(signature:UIImage?)
}

class SignatureViewController:UIViewController
{
    
    let BRUSH_SIZE:CGFloat = 5.0
    let BRUSH_ALPHA:CGFloat = 1.0
    let BRUSH_COLOR_RED:CGFloat = 0.0
    let BRUSH_COLOR_GREEN:CGFloat = 0.0
    let BRUSH_COLOR_BLUE:CGFloat = 0.0
    
    @IBOutlet var signatureImageView:UIImageView?
    @IBOutlet var line:UIView?
    @IBOutlet var signLabel:UILabel?
    
    var delegate:SignatureViewDelegate?
    
    var _lastPoint:CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signatureImageView?.contentMode = UIViewContentMode.Center
        self.line?.backgroundColor = UIColor.DEFAULT_SEPARATOR_COLOR
        self.signLabel?.font = UIFont.MICE_TYPE()
        self.signLabel?.textColor = UIColor.CHICAGO_CARES.GREY
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    //update the signature image with a new volunteer and show animation
    func setSignature(image:UIImage?)
    {
        var doWhileOut:() -> Void = {
            self.signatureImageView!.alpha = 0
        }
        
        var doWhileIn:() -> Void  = {
            self.signatureImageView!.alpha = 1
        }
        
        var middleHandler:() -> Void = {
            self.signatureImageView!.image = image
        }
        
        var completionHandler:() -> Void = {
            
        }
        
        AnimationUtils.outAndIn(doWhileOut, middleHandler: middleHandler, doWhileIn: doWhileIn, completionHandler: completionHandler)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        super.touchesBegan(touches, withEvent: event)
        var touch:UITouch = touches.anyObject() as UITouch
        self._lastPoint = touch.locationInView(self.signatureImageView)
        
        //begin graphics image context
        UIGraphicsBeginImageContext(self.signatureImageView!.frame.size)
        self.signatureImageView?.image?.drawInRect(CGRectMake(0, 0, self.signatureImageView!.frame.width, self.signatureImageView!.frame.height))
        
        //setup graphics context
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), BRUSH_SIZE)
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), BRUSH_COLOR_RED, BRUSH_COLOR_GREEN, BRUSH_COLOR_BLUE, BRUSH_ALPHA)
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        super.touchesMoved(touches, withEvent: event)
        var touch:UITouch = touches.anyObject() as UITouch
        var currentPoint:CGPoint = touch.locationInView(self.signatureImageView)
        
        //draw line between previous point and current point
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self._lastPoint.x, self._lastPoint.y)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        
        //update bitmap
        self.signatureImageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        
        //update current point
        self._lastPoint = currentPoint
    }
    
    //end graphics image context
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        super.touchesEnded(touches, withEvent: event)
        UIGraphicsEndImageContext()
    }
    
    //clear the image bitmap
    @IBAction func clear() {
        self.signatureImageView?.image = nil
        
        //track analytics
        AnalyticsService.registerEvent(Constants.ANALYTICS_CATEGORIES.UI_ACTION.rawValue, action: Constants.ANALYTICS_EVENTS.SIGNATURE_CLEAR.rawValue, label: Constants.ANALYTICS_EVENTS.SIGNATURE_CLEAR.rawValue)
    }
    
    //trigger save on the signature
    @IBAction func save() {
        let signature:UIImage? = self.signatureImageView?.image
        self.delegate?.signatureViewOnSave(signature)
        
        //track analytics
        AnalyticsService.registerEvent(Constants.ANALYTICS_CATEGORIES.UI_ACTION.rawValue, action: Constants.ANALYTICS_EVENTS.SIGNATURE_SAVE.rawValue, label: Constants.ANALYTICS_EVENTS.SIGNATURE_SAVE.rawValue)
    }
    
}