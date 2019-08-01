//
//  HHWebViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/26.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit
import WebKit

class HHWebViewController: HHBaseViewController {

    var request: URLRequest!
    //懒加载webview
    lazy var webView: WKWebView = {
        let web = WKWebView()
        web.allowsBackForwardNavigationGestures = true
        web.navigationDelegate = self
        web.uiDelegate = self
        return web
    }()
    //懒加载进度条
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.trackImage = UIImage.init(named: "")
        progress.progressTintColor = UIColor.white
        return progress
    }()
    
    convenience init(url: String?) {
        self.init()
        self.request = URLRequest(url: URL(string: url ?? "")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.load(request)
    }
    
    override func configUI() {
        super.configUI()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalTo(self.view.hhsnp.edges)
        }
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(reload))
    }
    @objc func reload() {
        webView.reload()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension HHWebViewController: WKNavigationDelegate, WKUIDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = webView.estimatedProgress >= 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
        navigationItem.title = title ?? (webView.title ?? webView.url?.host)
    }
}



