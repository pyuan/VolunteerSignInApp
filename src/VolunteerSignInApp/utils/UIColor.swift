//
//  UIColor.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-02.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit


extension UIColor
{
    
    //from  Dong Yu Li, constant colour values
    struct CHICAGO_CARES
    {
        static let BLUE = UIColor(rgba: "#005ea2");
        static let GREEN = UIColor(rgba: "#82C341");
        static let GREY = UIColor(rgba: "#939598");
        static let BLACK = UIColor(rgba: "#000000");
        static let WHITE = UIColor(rgba: "#FFFFFF");
    }
    
    class var DEFAULT_SEPARATOR_COLOR:UIColor { return UIColor(rgba: "#e0e0e0") }
    
    //from  Dong Yu Li, to create a UIColor from rgba
    convenience init(rgba: String) {
        //println("calculating color with hex \(rgba)");
        
        var red: CGFloat   = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index = advance(rgba.startIndex, 1)
            let hex = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                if hex.utf16Count == 6 {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if hex.utf16Count == 8 {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9")
                }
            } else {
                println("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
}