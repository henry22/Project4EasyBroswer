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
    var progressView: UIProgressView!
    var websites = ["apple.com", "yahoo.com"]
    
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
        let url = NSURL(string: "https://" + websites[0])!
        //Creates a new NSURLRequest object from that NSURL, and gives it to our web view to load
        webView.loadRequest(NSURLRequest(URL: url))
        //Allows users to swipe from the left or right edge to move backward or forward in their web browsing
        webView.allowsBackForwardNavigationGestures = true
        
        //Using a custom title for our bar button rather than a system icon
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
        
        //Creates a new UIProgressView instance, giving it the default style
        progressView = UIProgressView(progressViewStyle: .Default)
        //Tells the progress view set its layout size so that it fits its contents fully
        progressView.sizeToFit()
        //Creates a new UIBarButtonItem using the customView parameter, where we wrap up our UIProgressView in a UIBarButtonItem so that it can go into our toolbar
        let progressButton = UIBarButtonItem(customView: progressView)
        
        //.FlexibleSpace, which creates a flexible space. It doesn't need a target or action because it can't be tapped
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        //Now we're calling the refreshTapped() method
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: "reload")
        
        //An array containing the flexible space and the refresh button, then sets it to be our view controller's toolbarItems array
        toolbarItems = [progressButton, spacer, refresh]
        //Show the toolbar and its items will be loaded from our current view
        navigationController?.toolbarHidden = false
        
        //The addObserver() method takes four parameters: who the observer is (we're the observer, so we use self), what property we want to observe (we want the estimatedProgress property), which value we want (we want the value that was just set, so we want the new one), and a context value
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        //If the estimatedProgress value of the web view has changed, we set the progress property of our progress view to the new estimatedProgress value
        if keyPath == "estimatedProgress" {
            //estimatedProgress is a Double,UIProgressView's progress property is a Float, so we need to create a new Float from the Double
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func openTapped() {
        //Using nil for the message, because this alert doesn't need one.
        //Using the preferredStyle of .ActionSheet because we're prompting the user for more information.
        //Adding a dedicated Cancel button using style .Cancel. It has a handler of nil which will just hide the alert controller.
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        
        for website in websites {
            alertController.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
        
   
    func openPage(action: UIAlertAction!) {
        //Use the title property of the action(apple.com, yahoo.com),put "http://" in front of it, then construct an NSURL out of it.
        let url = NSURL(string: "http://" + action.title)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        //All this method does it update our view controller's title property to be the title of the web view.
        title = webView.title
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.URL
        
        if let host = url!.host {
            for website in websites {
                if website.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    return
                }
            }
        }
        decisionHandler(.Cancel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

