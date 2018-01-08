//
//  FamousDetailViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import UIKit
import SVProgressHUD

class FamousDetailViewController: HandWritingViewController, FamousDetailUI {
    //获取WebView
    @IBOutlet weak var contentWebView: UIWebView!
    
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        contentWebView.delegate = self
        
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: Loading)
    }
    
    func show(item: URL) {
        //设置URL
        let request = URLRequest(url: item)
        self.contentWebView.loadRequest(request)
    }
    
    /*
     方式1.获取手机屏幕宽度并设置给webViewHtml
     方式2.网页端加<style>img{width: 100%;}</style>
     */
    func setWebViewHtmlImageFitPhone(){
        let width = SCREEN_WIDTH
        //...
    }
}
extension FamousDetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
