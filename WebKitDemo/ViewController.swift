//
//  ViewController.swift
//  WebKitDemo
//
//  Created by Somya on 11/11/20.
//  Copyright © 2020 Somya. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    var fetchedMessage: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView?.uiDelegate = self
        let request = URLRequest(url: URL(string: "https://infallible-edison-a2ffa8.netlify.app/#/")!)
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
        print("-------------reached here---------------")
        print(#function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.calculateSum();
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    @IBAction func setValueButton(_ sender: Any) {
        let num1: Double = 8.0
        let num2: Double = 8.0
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
    
    
    func calculateSum() {
        let num1: Double = 8.0
        let num2: Double = 8.0
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
}

