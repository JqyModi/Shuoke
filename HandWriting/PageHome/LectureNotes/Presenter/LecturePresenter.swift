//
//  LecturePresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import Alamofire
import SVProgressHUD

class LecturePresenter: BothamPresenter, BothamPullToRefreshPresenter, BothamNavigationPresenter {
    //初始化
    private weak var ui: CommonUI?
    private let wireframe: PageHomeWireframe
    
    var currentPage = 1
    var data = [Common]()
    
    init(ui: CommonUI, wireframe: PageHomeWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        debugPrint("加载布局完成")
        
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
         type=note   pid= ""      讲义
         */
        getHomeCommonData(type: "note", pid: 0, page: currentPage) { [weak self](items) in
            //开始填充数据
            self?.data = items
            self?.load(items: (self?.data)!)
        }
        
        //接收加载数据通知
        NotificationCenter.default.addObserver(self, selector: #selector(loadMoreData(notify:)), name: NSNotification.Name(rawValue: "NotifyLoadMore"), object: nil)
    }
    
    @objc func loadMoreData(notify: Notification){
        debugPrint("开始加载数据")
        self.currentPage = self.currentPage + 1
        
        getHomeCommonData(type: "note", pid: 0, page: currentPage) { [weak self](items) in
            //开始填充数据
            self?.data = (self?.data)! + items

            self?.load(items: (self?.data)!)
        }
        
//        CacheCommonService.selectCommonsByType(type: 3, page: 1) { [weak self] (commons) in
//            self?.load(items: commons)
//            debugPrint("**********cachecount = \(commons.count)")
//        }
    }
    
    func didStartRefreshing() {
        debugPrint("开始刷新操作")
        //填充数据
        /*
         联网获取数据
         1、http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=1&type=yuedu&pid=411
         type=note   pid= ""      讲义
         */
//        getHomeCommonData(type: "note", pid: 0, page: 1) { [weak self](items) in
//            //开始填充数据
//            self?.data = items
//            self?.load(items: (self?.data)!)
//        }
        
        CacheCommonService.selectCommonsByType(type: 3, page: 1) { [weak self] (commons) in
            self?.load(items: commons)
            debugPrint("**********cachecount = \(commons.count)")
            CacheCommonService.insertCommonWithArray(arr: commons, type: 3)
        }
        
        self.ui?.stopRefreshing()
    }
    private func load(items: [Common]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: Common) {
        //检查网络是否正常
        let manager = NetworkReachabilityManager.init(host: BASEURL)
        if (manager?.isReachable)! {
            debugPrint("网络可用")
            let detailData = NSMutableDictionary()
            detailData.setValue(item.video, forKey: "video")
            detailData.setValue(item.title, forKey: "title")
            wireframe.presentLectureDetailViewController(detailData)
        }else {
            debugPrint("网络不可用")
            SVProgressHUD.showError(withStatus: "当前网络不可用请稍后再试·~~~")
        }
    }
}
