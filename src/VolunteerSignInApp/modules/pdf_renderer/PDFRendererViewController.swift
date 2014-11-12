//
//  PDFRendererViewController.swift
//  VolunteerSignInApp
//  
//  Created by Paul Yuan on 2014-10-24.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class PDFRendererViewController:GAITrackedViewController, UIWebViewDelegate
{
    
    @IBOutlet var webView:UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView?.delegate = self
        self.webView?.backgroundColor = UIColor.blackColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.screenName = "PDF Preview"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //generate PDF with volunteers in db
        PDFRenderer.generatePDF()
        
        //show the pdf in webview
        let fileName:String = Constants.PDF.FILE_NAME.rawValue
        self._showPDF(fileName)
    }
    
    //show PDF file in webview
    func _showPDF(fileName:String)
    {
        let fileURI:String = PDFRenderer.getFileURIWithFileName(fileName)
        let url:NSURL? = NSURL.fileURLWithPath(fileURI)?
        if url != nil
        {
            let request:NSURLRequest = NSURLRequest(URL: url!)
            self.webView?.scalesPageToFit = true
            self.webView?.loadRequest(request)
        }
        else
        {
            println("Error: file note found - " + fileName)
        }
    }
    
}