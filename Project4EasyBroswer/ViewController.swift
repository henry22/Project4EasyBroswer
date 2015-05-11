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
    
    func openTapped() {
        //Using nil for the message, because this alert doesn't need one.
        //Using the preferredStyle of .ActionSheet because we're prompting the user for more information.
        //Adding a dedicated Cancel button using style .Cancel. It has a handler of nil which will just hide the alert controller.
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction(title: "apple.com", style: .Default, handler: openPage))
        alertController.addAction(UIAlertAction(title: "slashdot.org", style: .Default, handler: openPage))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

