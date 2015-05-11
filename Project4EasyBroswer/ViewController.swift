//
//  ViewController.swift
//  Project4EasyBroswer
//
//  Created by Henry on 5/5/15.
//  Copyright (c) 2015 Henry. All rights reserved.
//

import UIKit
import WebKit

//Create a new subclass of UIViewController called ViewController, and tell the compiler that we promise we're safe to use as a WKNavigationDelegate
class ViewController: UIViewController, WKNavigationDelegate {
    
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
        //Creates a new NSURL
        let url = NSURL(string: "https://www.apple.com/tw/")!
        //Creates a new NSURLRequest object from that NSURL, and gives it to our web view to load
        webView.loadRequest(NSURLRequest(URL: url))
        //Allows users to swipe from the left or right edge to move backward or forward in their web browsing
        webView.allowsBackForwardNavigationGestures = true
        
        //Using a custom title for our bar button rather than a system icon
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

