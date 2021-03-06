//
//  HomeViewpagerPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

class HomeViewpagerPresenter: BothamPresenter,BothamNavigationPresenter {
    //初始化
    private weak var ui: PageHomeUI?
    private let wireframe: PageHomeWireframe
    var nttdobserver: NSObjectProtocol?
    init(ui: PageHomeUI, wireframe: PageHomeWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    init(wireframe: PageHomeWireframe) {
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        debugPrint("加载布局完成")
        //填充数据
//        load(items: [PageHome(name: "每日推荐"),
//                     PageHome(name: "常用碑帖"),
//                     PageHome(name: "课程讲义"),
//                     PageHome(name: "书法视界"),
//                     PageHome(name: "文房雅趣"),
//                     PageHome(name: "名家名作")])
        observeTextFields()
        
        //测试
        getHomeCommonData(type: "yuedu", pid: 411, page: 1) { (items) in
            //开始插入数据
            debugPrint("############path: " + NSHomeDirectory())
            
            CacheCommonService.insertCommonWithArray(arr: items, type: 1)
        }
        
        getHomeCommonData(type: "beitie", pid: 0, page: 1) { (items) in
            //开始插入数据
            CacheCommonService.insertCommonWithArray(arr: items, type: 2)
        }
        
        getHomeCommonData(type: "note", pid: 0, page: 1) { (items) in
            //开始插入数据
            CacheCommonService.insertCommonWithArray(arr: items, type: 3)
        }
        
        getHomeCommonData(type: "yuedu", pid: 413, page: 1) { (items) in
            //开始插入数据
            CacheCommonService.insertCommonWithArray(arr: items, type: 4)
        }
        
        getHomeCommonData(type: "yuedu", pid: 412, page: 1) { (items) in
            //开始插入数据
            CacheCommonService.insertCommonWithArray(arr: items, type: 5)
        }
        
        getHomeCommonData(type: "yuedu", pid: 414, page: 1) { (items) in
            //开始插入数据
            CacheCommonService.insertCommonWithArray(arr: items, type: 6)
        }
    }
    
    func observeTextFields(){
        //注册跳转广播
        let center = NotificationCenter.default
        nttdobserver = center.addObserver(forName: NSNotification.Name.init(NotifyTapToDetail), object: nil, queue: nil) { (notification) in
            self.presenterViewController(notification: notification)
        }
    }
    func presenterViewController(notification: Notification) {
        //获取数据
        if let detailData = notification.userInfo!["detailData"] as? NSMutableDictionary {
            if let model = detailData["model"] as? String {
                switch model {
                case "read":   //阅读
                    self.wireframe.presentStudyDetailViewController(detailData)
                    break;
                case "beitie":  //碑帖
                    self.wireframe.presentCopyBookDetailViewController(detailData)
                    break;
                case "note":    //讲义
                    self.wireframe.presentLectureDetailViewController(detailData)
                    break;
                case "video_play":    //视频
                    self.wireframe.presentVideoDetailViewController(detailData)
                    break;
                case "peixun":    //培训
                    break;
                default:
                    debugPrint("*****")
                    break;
                }
            }
        }
    }
    
    private func load(items: [PageHome]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: PageHome) {
        debugPrint("................")
        
    }
}
