//
//  VideoPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/21.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import SVProgressHUD

class VideoPresenter: BothamPresenter, BothamPullToRefreshPresenter, BothamNavigationPresenter, VideoViewControllerDelegate {
    //初始化
    private weak var ui: VideoUI?
    private let wireframe: VideoWireframe
    
    var currentPage = 1
    var data = [Video]()
    
    init(ui: VideoUI, wireframe: VideoWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        print("加载布局完成")
        //填充数据
        getVideoData(jiegou: 0, bianpang: 0, bihua: 0, class1: 0, page: currentPage) { [weak self](items) in
            //开始填充数据
            self?.data = items
            self?.load(items: (self?.data)!)
        }
        //接收加载数据通知
        NotificationCenter.default.addObserver(self, selector: #selector(loadMoreData(notify:)), name: NSNotification.Name(rawValue: "NotifyLoadMore"), object: nil)
    }
    
    @objc func loadMoreData(notify: Notification){
        print("开始加载数据")
        self.currentPage = self.currentPage + 1
        
        getVideoData(jiegou: 0, bianpang: 0, bihua: 0, class1: 0, page: currentPage) { [weak self](items) in
            //开始填充数据
            self?.data = (self?.data)! + items
            self?.load(items: (self?.data)!)
        }
    }
    
    func didStartRefreshing() {
        print("开始刷新操作")
        //填充数据
        getVideoData { (items) in
            //开始填充数据
            self.data = items
            self.load(items: (self.data))
        }

        self.ui?.stopRefreshing()
    }
    private func load(items: [Video]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: Video) {
        wireframe.presentVideoDetailViewController(item: item)
    }
    
    func loadCategoryData(items: [Video]) {
        if items.count > 0 {
            self.load(items: items)
        }else{
            SVProgressHUD.showInfo(withStatus: "暂无相关数据")
            print("数据为空")
        }
        
    }
}
