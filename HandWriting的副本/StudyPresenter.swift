//
//  StudyPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

class StudyPresenter: BothamPresenter, BothamPullToRefreshPresenter, BothamNavigationPresenter{
    //初始化
    private weak var ui: CommonUI?
    private let wireframe: PageHomeWireframe
    let pid = 414
    
    var currentPage = 1
    var data = [Common]()
    
    init(ui: CommonUI, wireframe: PageHomeWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        print("加载布局完成")
        
        /*
         填充数据
         {
         "id":"1115",
         "title":"广东“女子书法十家”作品展佛山开幕",
         "img_url_s":"/Public/Uploads/Article/20170607/thumb_59375e07c83be.jpg",
         "view_count":"18"
         }
         联网获取数据
         1、http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=1&type=yuedu&pid=411
         type=yuedu   pid= 414      文房雅趣
         */
        getHomeCommonData(type: "yuedu", pid: pid, page: currentPage) { [weak self](items) in
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
        getHomeCommonData(type: "yuedu", pid: pid, page: currentPage) { [weak self](items) in
            //开始填充数据
            self?.data = (self?.data)! + items
            self?.load(items: (self?.data)!)
        }
    }
    
    func didStartRefreshing() {
        print("开始刷新操作")
        //填充数据
        /*
         联网获取数据
         1、http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=1&type=yuedu&pid=411
         type=yuedu   pid= 414      文房雅趣
         */
        getHomeCommonData(type: "yuedu", pid: pid, page: 1) { [weak self](items) in
            //开始填充数据
            self?.data = items
            self?.load(items: (self?.data)!)
        }
        self.ui?.stopRefreshing()
    }
    private func load(items: [Common]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: Common) {
        let detailData = NSMutableDictionary()
        detailData.setValue(pid, forKey: "pid")
        detailData.setValue(item.id, forKey: "id")
        detailData.setValue(item.title, forKey: "title")
        
        wireframe.presentStudyDetailViewController(detailData)
    }
}
