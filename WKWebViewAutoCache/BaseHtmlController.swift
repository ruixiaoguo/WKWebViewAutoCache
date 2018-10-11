//
//  BaseHtmlController.swift
//  ShopProject-Swift
//
//  Created by grx on 2018/9/12.
//  Copyright © 2018年 grx. All rights reserved.
//

import UIKit
import WebKit

class BaseHtmlController: UIViewController,WKNavigationDelegate,WKUIDelegate {
    // webView
    lazy var webView: WKWebView = WKWebView()
    // 进度条
    lazy var progressView:UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = YCColorBlue
        progress.trackTintColor = YCColorDarkLight
        return progress
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.progressView.frame = CGRect(x:0,y:Int(0),width:Int(Main_Screen_Width),height:2)
        self.progressView.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.progressView.progress = 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //增加离线缓存监听
        URLProtocol.wk_registerScheme("http")
        URLProtocol.wk_registerScheme("https")
        JWCacheURLProtocol.startListeningNetWorking()
        
        webView = WKWebView( frame: CGRect(x:0,y:Int(0),width:Int(Main_Screen_Width),height:(Int(Main_Screen_Height))))
        /// 设置代理
        webView.navigationDelegate = self
        webView.uiDelegate = self;
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.view.addSubview(webView)
        self.view.addSubview(self.progressView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //移除离线缓存监听
        JWCacheURLProtocol.cancelListeningNetWorking()
    }
    
    func startLoadWithTitle(title:String,url:String) {
        let requst = NSURLRequest(url:NSURL(string: url)! as URL)
        webView.load(requst as URLRequest)
        self.navigationItem.title = title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("con is deinit")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
    }
}

extension BaseHtmlController{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
        // 网页真实高度
        webView.evaluateJavaScript("document.body.scrollHeight") {(result, error) in
            if let tempHeight: Double = result as? Double {
                print("webheight: \(tempHeight)")
            }
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            print(webView.estimatedProgress)
        }
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let strRequest = navigationAction.request.url?.absoluteString
        printLog(message: "拦截======\(String(describing: strRequest))")
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    
}
