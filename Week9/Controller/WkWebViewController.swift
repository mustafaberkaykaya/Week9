//
//  WkWebViewController.swift
//  Week9
//
//  Created by Mustafa Berkay Kaya on 1.12.2021.
//

import UIKit
import WebKit

class WkWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://www.themoviedb.org/?language=tr"
        let request = URLRequest(url: URL(string: url)!)
        self.webView.load(request)
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        
        webView.navigationDelegate = self
        webView.scrollView.bounces = true
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(WkWebViewController.refreshWebView), for: UIControl.Event.valueChanged) 
        webView.scrollView.addSubview(refreshControl)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading"{
            if webView.isLoading {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
    
    @objc
    func refreshWebView(sender: UIRefreshControl) {
        webView.reload()
        sender.endRefreshing()
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(String(describing: navigationAction.request))
        decisionHandler(.allow)
    }
}
