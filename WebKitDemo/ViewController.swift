//
//  ViewController.swift
//  WebKitDemo
//
//  Created by Somya on 11/11/20.
//  Copyright © 2020 Somya. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    var fetchedMessage: String = ""
//
//    // Setup WKUserContentController instance for injecting user script
//
//    var userController:WKUserContentController = WKUserContentController()
//
//    lazy var MyWebView: WKWebView = {
//
//    let webCfg:WKWebViewConfiguration = WKWebViewConfiguration()
//
//    // Setup WKUserContentController instance for injecting user script
//
//    var userController:WKUserContentController = WKUserContentController()
//
//    // Add a script message handler for receiving messages over `nativeProcess` messageHandler. The controller needs to confirm
//
//    // with WKScriptMessageHandler protocol
//
//    userController.add(self, name: "nativeProcess")
//
//    // Configure the WKWebViewConfiguration instance with the WKUserContentController
//
//    webCfg.userContentController = userController;
//        // Assign the size of the WebView. Change this according to your need
//
//    let webView = WKWebView(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: self.view.frame.height-200.0), configuration: webCfg)
//
//    return webView
//
//    }()
//

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView?.uiDelegate = self
        let request = URLRequest(url: URL(string: "https://gifted-spence-ba10b0.netlify.app/#/")!)
        webView?.configuration.userContentController.add(self, name: "nativeProcess")
        webView?.navigationDelegate = self
        webView?.load(request)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("functionFromNative()", completionHandler: { result, error in

               if let res = result as? String {
                self.textLabel.text = res
                   print(res)
               }
           })
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
    {
         let body = message.body
         if let dict = body as? Dictionary<String, AnyObject> {
         if let test = dict["key1"] {
            print("JavaScript is sending a message ")
            fetchedMessage = test as? String ?? ""
            }
        }
    }
    
    
    @IBAction func setValueButton(_ sender: Any) {
         let num1 = 4
         let num2 = 8
        self.webView?.evaluateJavaScript("addTwoNumbers(\(num1),\(num2));")  { (result, error) in
                guard error == nil else {
                    print(error?.localizedDescription)
                    print("there was an error")
                    return
                }
                if let value = result as? String {
                               self.textLabel.text = value
                }
            }
        }
    
    @IBAction func getValueButton(_ sender: Any) {
        self.webView?.evaluateJavaScript("functionFromNative()", completionHandler: { (result, error) in
            if let value = result as? String {
                self.textLabel.text = value
            } else {
                self.textLabel.text = "No input"
            }
        })
        
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        self.textLabel.text = "No input"
    }
    
}

