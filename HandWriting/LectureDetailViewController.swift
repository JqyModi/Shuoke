//
//  LectureDetailViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import UIKit
import SVProgressHUD
import SCLAlertView_Objective_C

class LectureDetailViewController: HandWritingViewController, LectureDetailUI {
    //获取WebView
    @IBOutlet weak var contentWebView: UIWebView!
    
    var currentURL = ""
    
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        contentWebView.delegate = self
        
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        //显示右上角下载按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下载", style: .plain, target: self, action: "downloadFileForPath")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: Loading)
        
    }
    
    func show(item: URL) {
        
        if item.absoluteString.contains("mobile") {
//            let filePath = Bundle.main.path(forResource: item.absoluteString, ofType: nil)
//            let url = URL.init(fileURLWithPath: filePath!)
            let url = URL.init(fileURLWithPath: item.absoluteString)
            contentWebView.scalesPageToFit = true
            let request = URLRequest(url: url)
            self.contentWebView.loadRequest(request)
        }else{
            //设置URL
            //文档而言太大。Word 和 PowerPoint 文档必须小于 10 兆字节;Excel 必须小于五个兆字节
            //判断文件是否大于10M
            let DailyDetailBaseURL = "https://view.officeapps.live.com/op/view.aspx?src="
            let urlStr = DailyDetailBaseURL + item.absoluteString
            self.currentURL = item.absoluteString
            Thread {
                let data = NSData(contentsOf: item)
                //+1是因为省略了小数部分
                let size = (data?.length)! / (1024*1024) + 1
                if size > 10 {
                    //显示下载布局
                    self.showDownloadButton()
                    DispatchQueue.main.async(execute: {
                        SVProgressHUD.showError(withStatus: "文件过大,预览失败,请下载查看~")
                    })
                }else{
                    let request = URLRequest(url: URL(string: urlStr)!)
                    self.contentWebView.loadRequest(request)
                }
                }.start()
        }
    }
    
    /*
     方式1.获取手机屏幕宽度并设置给webViewHtml
     方式2.网页端加<style>img{width: 100%;}</style>
     */
    func setWebViewHtmlImageFitPhone(){
        let width = SCREEN_WIDTH
        //...
    }
    
    func showDownloadButton(){
        self.contentWebView.isHidden = true
        let bgView = UIView()
        bgView.backgroundColor = UIColor.TableBackgroundColor
        bgView.width = 280
        bgView.height = 280
        bgView.top = (self.view.height - bgView.height - TabbarHeight)/2
        bgView.left = (self.view.width - bgView.width)/2
        let label = UILabel()
        label.width = bgView.width - 16
        label.height = 30
        label.top = (bgView.height-label.height)/2
        label.left = (bgView.width-label.width)/2
        label.textAlignment = .center
        label.textColor = UIColor.BrownTextColor
        label.text = "文件过大无法预览, 请下载查看~"
        bgView.addSubview(label)
        
        let downloadBtn = UIButton()
        downloadBtn.width = 100
        downloadBtn.height = 30
        downloadBtn.top = label.bottom + 30
        downloadBtn.left = (bgView.width-downloadBtn.width)/2
        downloadBtn.backgroundColor = UIColor.Tabbar1Color
        downloadBtn.setTitle("下载", for: .normal)
        downloadBtn.setTitleColor(UIColor.white, for: .normal)
        downloadBtn.addTarget(self, action: "downloadFileForPath" , for: .touchUpInside)
        bgView.addSubview(downloadBtn)
        self.view.addSubview(bgView)
    }
    
    func downloadFileForPath(){
        //
        SVProgressHUD.showInfo(withStatus: "文件开始下载~")
        downloadFile(path: self.currentURL,name: self.title!) { (path,progress) in
            print("path: \(path)  --  progress: \(progress)")
            //弹出下载进度条dialog
            if progress != 0 {
                SVProgressHUD.showProgress(Float(progress), status: "文件下载中...")
                if !path.isEmpty && progress == 1.0 {
                    SVProgressHUD.show(withStatus: "文件下载完成,请到用户中心中查看下载~")
                    SVProgressHUD.dismiss(withDelay: 3)
                }
            }
        }
    }
}
extension LectureDetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
