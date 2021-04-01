//
//  AuthViewController.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let wv = WKWebView(frame: .zero, configuration: config)
        return wv
    }()
    
    public var completionHandler: ((Bool) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        guard let url = AuthManager.shared.signedInURL else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        //Exchange the code to an access Token
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"})?.value else { return }
        print("Code:\(code)")
        //webView.isHidden = true
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] (success) in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }
}
