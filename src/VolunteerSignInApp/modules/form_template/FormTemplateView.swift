//
//  FormTemplateView.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-02.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class FormTemplateView:UIView
{
    
    @IBOutlet var program:UILabel?
    @IBOutlet var date:UILabel?
    @IBOutlet var location:UILabel?
    @IBOutlet var instruction:UILabel?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //fill in program info
        var title:String = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.PROGRAM.rawValue) + " (" + UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.ORGNIZATION.rawValue) + ")"
        self.program?.text = title
        self.date?.text = UserDefaultsService.getProgramDateTime()
        self.location?.text = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.LOCATION.rawValue)
        
        var volunteers:[Volunteer] = VolunteerService.getAllVolunteers()
        self.drawTable(belowElement: self.instruction, volunteers: volunteers)
    }
    
    
    private func drawTable(belowElement element:UIView?, volunteers:[Volunteer])
    {
        var header:UIView = self.drawTableHeader(belowElement: element)
        //self.drawVolunteersRows(belowElement: header, volunteers: volunteers)
    }
    
    //draw the table header row below the specified element
    private func drawTableHeader(belowElement element:UIView?) -> UIView
    {
        var firstlabel:UILabel?
        var y:CGFloat = element != nil ? element!.frame.origin.y + self.instruction!.frame.height + 25 : 25
        var x:CGFloat = element != nil ? element!.frame.origin.x : 25
        
        var data:NSArray = VolunteerFormService.getPDFColumns()
        for i in 0..<data.count
        {
            x += 10 //offset label
            
            var d:NSDictionary = data[i] as NSDictionary
            var title:String = d.valueForKey("label") as String
            var w:CGFloat = d.valueForKey("width") as CGFloat
            var label:UILabel = UILabel(frame: CGRectMake(x, y, w, 25))
            label.text = title
            self.addSubview(label)
            
            if firstlabel == nil {
                firstlabel = label
            }
            
            x += w //set x for the next label
        }
        
        return firstlabel!
    }
    
    //draw the volunteer rows below the specified element
    private func drawVolunteersRows(belowElement element:UIView?, volunteers:[Volunteer])
    {
        var y:CGFloat = element != nil ? element!.frame.origin.y + self.instruction!.frame.height + 25 : 25
        var x:CGFloat = element != nil ? element!.frame.origin.x : 25
        
        var data:NSArray = VolunteerFormService.getPDFColumns()
        for i in 0..<data.count
        {
            x += 10 //offset label
            
            var d:NSDictionary = data[i] as NSDictionary
            var title:String = d.valueForKey("label") as String
            var w:CGFloat = d.valueForKey("width") as CGFloat
            var label:UILabel = UILabel(frame: CGRectMake(x, y, w, 25))
            label.text = title
            self.addSubview(label)
            
            x += w //set x for the next label
        }
    }
    
}