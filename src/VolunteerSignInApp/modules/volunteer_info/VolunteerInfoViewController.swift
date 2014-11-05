//
//  VolunteerInfoViewController.swift
//  VolunteerSignInApp
//
//  Created by Paul Yuan on 2014-11-05.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class VolunteerInfoViewController:UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet var tableView:UITableView?
    @IBOutlet var bottomBar:InfoBottomBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReuseId:String = "textFieldCell"
        var cell:VolunteerInfoTextFieldCell! = tableView.dequeueReusableCellWithIdentifier(cellReuseId, forIndexPath: indexPath) as VolunteerInfoTextFieldCell
        
        return cell
    }
    
}