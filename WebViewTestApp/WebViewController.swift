//
//  WebViewController.swift
//  Embedded Web View Test
//
//  Created by Arlen Burroughs on 10/6/23.
//

import Foundation
import UIKit
import WebKit
import SafariServices

class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var errorText: UILabel!
    var progressView: UIProgressView!
    
    var url: URL!
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded")
        progressView.isHidden = true
    }
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("WebView error 2: ", error.localizedDescription)
        errorText.text = error.localizedDescription
        errorText.isHidden = false
        progressView.isHidden = true
    }
    
    func setUrl(urlStr : String) {
        if (urlStr != "") {
            url = URL(string:urlStr)!
            print("setUrl: ", urlStr)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        title = "WKWebView"
        
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        // Create web view and progress bar
        progressView = UIProgressView(progressViewStyle: .default)
        view.addSubview(progressView)
        progressView.center = CGPoint(x: view.frame.size.width  / 2,
                                     y: view.frame.size.height / 2)

        print("Loading url: ", url.absoluteString)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
