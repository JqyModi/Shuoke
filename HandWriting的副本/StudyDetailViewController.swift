//
//  StudyDetailViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import UIKit
import SVProgressHUD

class StudyDetailViewController: HandWritingViewController, StudyDetailUI {
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
        let js = NSString(format: "var script = document.createElement('script');script.type = 'text/javascript';script.text = \"function ResizeImages() { var myimg,oldwidth;var maxwidth = '%f';for(i=0;i <document.images.length;i++){myimg = document.images[i];if(myimg.width > maxwidth){oldwidth = myimg.width;myimg.width = maxwidth;}}}\";document.getElementsByTagName('head')[0].appendChild(script);", width)
        contentWebView.stringByEvaluatingJavaScript(from: js as String)
        contentWebView.stringByEvaluatingJavaScript(from: "ResizeImages();")
    }
}
extension StudyDetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        setWebViewHtmlImageFitPhone()
        SVProgressHUD.dismiss()
    }
}
