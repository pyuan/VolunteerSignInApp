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
    
    class var TAG_SIGNATURES : Int { return 999 }
    
    private class var MARGIN_TABLE : CGFloat { return 10 }
    private class var TABLE_ROW_HEIGHT : CGFloat {return 35 }
    
    private var volunteers:[Volunteer] = [Volunteer]()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        //fill in program info
        var title:String = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.PROGRAM.rawValue) + " (" + UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.ORGNIZATION.rawValue) + ")"
        self.program?.text = title
        self.program?.font = UIFont.PDF_TITLE()
        self.program?.sizeToFit()
        
        self.date?.text = UserDefaultsService.getProgramDateTime()
        self.date?.font = UIFont.PDF_TITLE()
        self.date?.sizeToFit()
        
        self.location?.text = UserDefaultsService.getDefaultForKey(Constants.SETTINGS_KEYS.LOCATION.rawValue)
        self.location?.font = UIFont.PDF_TITLE()
        self.location?.sizeToFit()
        
        self.instruction?.font = UIFont.MICE_TYPE()
        self.instruction?.textColor = UIColor.CHICAGO_CARES.GREY
    }
    
    //setup the volunteers for the view
    func setVolunteers(volunteers:[Volunteer])
    {
        self.volunteers = volunteers
        
        //draw table for volunteers info
        self.drawTable(belowElement: self.instruction, volunteers: self.volunteers)
    }
    
    //render the volunteers table with header
    private func drawTable(belowElement element:UIView?, volunteers:[Volunteer])
    {
        var header:UIView = self.drawTableHeader(belowElement: element)
        self.drawVolunteersRows(belowElement: header, volunteers: volunteers)
    }
    
    //draw the table header row below the specified element
    private func drawTableHeader(belowElement element:UIView?) -> UIView
    {
        var firstlabel:UILabel?
        var y:CGFloat = element != nil ? element!.frame.origin.y + element!.frame.height + FormTemplateView.MARGIN_TABLE : FormTemplateView.MARGIN_TABLE
        var x:CGFloat = element != nil ? element!.frame.origin.x : FormTemplateView.MARGIN_TABLE
        
        var data:NSArray = VolunteerFormService.getPDFColumns()
        for i in 0..<data.count
        {
            var d:NSDictionary = data[i] as NSDictionary
            var title:String = d.valueForKey("label") as String
            var w:CGFloat = d.valueForKey("width") as CGFloat
            var label:UILabel = UILabel(frame: CGRectMake(x, y, w, FormTemplateView.TABLE_ROW_HEIGHT/2))
            label.font = UIFont.PDF_TABLE_HEADER()
            label.textColor = UIColor.CHICAGO_CARES.BLUE
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
        var y:CGFloat = element != nil ? element!.frame.origin.y + element!.frame.height + FormTemplateView.TABLE_ROW_HEIGHT : 0
        var x:CGFloat = element != nil ? element!.frame.origin.x : FormTemplateView.MARGIN_TABLE
        
        var columns:NSArray = VolunteerFormService.getPDFColumns()
        for volunteer in self.volunteers
        {
            var label:UILabel?
            var rowX:CGFloat = x
            for i in 0..<columns.count
            {
                var d:NSDictionary = columns[i] as NSDictionary
                var w:CGFloat = d.valueForKey("width") as CGFloat
                label = UILabel(frame: CGRectMake(rowX, y, w, FormTemplateView.TABLE_ROW_HEIGHT))
                
                var title:String = ""
                switch i
                {
                case 0:
                    title = volunteer.getDisplayName()
                    break
                case 1:
                    title = volunteer.team
                    break
                case 2:
                    title = volunteer.phone
                    break
                case 3:
                    title = volunteer.email
                case 4:
                    title = volunteer.over18 == true ? "Yes" : "No"
                    break
                default:
                    if volunteer.signature != nil
                    {
                        var signatureView:UIImageView = UIImageView(frame: label!.frame)
                        signatureView.image = UIImage(data: volunteer.signature!)
                        signatureView.tag = FormTemplateView.TAG_SIGNATURES
                        self.addSubview(signatureView)
                    }
                    break
                }
                
                if !title.isEmpty
                {
                    label!.text = title
                    label!.font = UIFont.PDF_TABLE_BODY()
                    label!.lineBreakMode = NSLineBreakMode.ByTruncatingTail
                    self.addSubview(label!)
                }
   
                rowX += w //set x for the next element in the row
            }
            
            y += label!.frame.height
        }
    }
    
}