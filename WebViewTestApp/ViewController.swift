//
//  ViewController.swift
//  Embedded Web View Test
//
//  Created by Arlen Burroughs on 10/6/23.
//

import UIKit
import WebKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var textInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set in last used url string
        textInput.text = UserDefaults.standard.string(forKey: "last-used-url")
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let url = URL(string: getUrlString()) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    @IBAction func wkWebViewPressed(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "webView") as? WebViewController else {
            return
        }
        vc.setUrl(urlStr: getUrlString())
        present(vc, animated: true)
    }
    
    func getUrlString() -> String {
        var urlStr = textInput.text ?? ""
        UserDefaults.standard.set(urlStr, forKey: "last-used-url")

        if (urlStr == "") { urlStr = "w3schools.com" }
        if(!urlStr.hasPrefix("http://") && !urlStr.hasPrefix("https://")) {
            urlStr = "https://" + urlStr
        }
        return urlStr;
    }
}
