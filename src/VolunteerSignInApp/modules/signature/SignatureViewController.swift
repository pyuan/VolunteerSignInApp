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
    
    @IBOutlet var signatureImageView:UIImageView!
    
    var _lastPoint:CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signatureImageView.contentMode = UIViewContentMode.ScaleAspectFit
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        super.touchesBegan(touches, withEvent: event)
        var touch:UITouch = touches.anyObject() as UITouch
        self._lastPoint = touch.locationInView(self.view)
        
        //begin graphics image context
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.signatureImageView.image?.drawInRect(CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
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
        var currentPoint:CGPoint = touch.locationInView(self.view)
        
        //draw line between previous point and current point
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self._lastPoint.x, self._lastPoint.y)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        
        //update bitmap
        self.signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
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
        self.signatureImageView.image = nil
    }
    
}