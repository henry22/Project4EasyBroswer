//
//  ViewController.swift
//  Project4EasyBroswer
//
//  Created by Henry on 5/5/15.
//  Copyright (c) 2015 Henry. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    //Override the actual loading of the view – we don't want that empty thing on the storyboard, we want our own code
    override func loadView() {
        //Create a new instance of Apple's WKWebView web browser component and assign it to a variable called webView
        webView = WKWebView()
        //Setting the web view's navigationDelegate property to self, which means "when any web page navigation happens,please tell me."
        webView.navigationDelegate = self
        //Make our view (the root view of the view controller) that web view
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

