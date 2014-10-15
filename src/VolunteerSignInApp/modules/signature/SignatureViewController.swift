//
//  SignatureViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-10-14.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class SignatureViewController:UIViewController
{
    
    let BRUSH_SIZE:CGFloat = 5.0
    let BRUSH_ALPHA:CGFloat = 1.0
    let BRUSH_COLOR_RED:CGFloat = 0.0
    let BRUSH_COLOR_GREEN:CGFloat = 0.0
    let BRUSH_COLOR_BLUE:CGFloat = 0.0
    
    @IBOutlet var tempDrawImage:UIImageView!
    @IBOutlet var mainImage:UIImageView!
    
    var _mouseSwiped:Bool = false
    var _lastPoint:CGPoint = CGPoint()

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        super.touchesBegan(touches, withEvent: event)
        self._mouseSwiped = false
        var touch:UITouch = touches.anyObject() as UITouch
        self._lastPoint = touch.locationInView(self.view)
        self.tempDrawImage.image = nil
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        super.touchesMoved(touches, withEvent: event)
        self._mouseSwiped = true
        var touch:UITouch = touches.anyObject() as UITouch
        var currentPoint:CGPoint = touch.locationInView(self.view)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.tempDrawImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self._lastPoint.x, self._lastPoint.y)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), BRUSH_SIZE)
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), BRUSH_COLOR_RED, BRUSH_COLOR_GREEN, BRUSH_COLOR_BLUE, BRUSH_ALPHA)
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal)
        
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempDrawImage.alpha = BRUSH_ALPHA
        
        self._lastPoint = currentPoint
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        super.touchesEnded(touches, withEvent: event)
        UIGraphicsEndImageContext()
        
        if !self._mouseSwiped
        {
            UIGraphicsBeginImageContext(self.view.frame.size)
            self.tempDrawImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), BRUSH_SIZE)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), BRUSH_COLOR_RED, BRUSH_COLOR_GREEN, BRUSH_COLOR_BLUE, BRUSH_ALPHA)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self._lastPoint.x, self._lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self._lastPoint.x, self._lastPoint.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            CGContextFlush(UIGraphicsGetCurrentContext())
            self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContext(self.mainImage.frame.size)
        self.mainImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: BRUSH_ALPHA)
        self.tempDrawImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: BRUSH_ALPHA)
        self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempDrawImage.image = nil
        UIGraphicsEndImageContext()
    }
    
}