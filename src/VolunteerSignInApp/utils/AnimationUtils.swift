//
//  AnimationUtils.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-08.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class AnimationUtils
{
    
    class func outAndIn(doWhileOut:() -> Void, middleHandler:() -> Void, doWhileIn:() -> Void, completionHandler:() -> Void)
    {
        
        var animateIn:() -> Void =
        {
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
                
                doWhileIn()
                
                }, completion: {(finished:Bool) -> Void in
                    
                    completionHandler()
                    
                })
        }
        
        var animateOut:() -> Void =
        {
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
                
                doWhileOut()
                
                }, completion: {(finished:Bool) -> Void in
                    
                    middleHandler()
                    animateIn()
                    
            })
        }
        
        animateOut()
    }
    
}