//
//  ShareOptionsViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-09.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

protocol ShareOptionsDelegate {
    func shareOptionsShowPDFPreview()
    func shareOptionsEmailPDF()
}

class ShareOptionsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    class var POPOVER_SIZE:CGSize { return CGSizeMake(200, 87) }
    
    @IBOutlet var tableView:UITableView?
    
    var delegate:ShareOptionsDelegate?
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel.text = indexPath.row == 0 ? "Preview PDF" : "Email PDF"
        
        //remove separator inset
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0 {
            self.delegate?.shareOptionsShowPDFPreview()
        }
        else {
            self.delegate?.shareOptionsEmailPDF()
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}