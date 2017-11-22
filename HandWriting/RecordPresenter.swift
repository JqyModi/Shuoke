//
//  RecordPresenter.swift
//  HandWriting
//
//  Created by mac on 17/9/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

class RecordPresenter: BothamPresenter, BothamPullToRefreshPresenter, BothamNavigationPresenter{
    //初始化
    private weak var ui: RecordUI?
    private var item: User?
    
    var records: [Record]?
    
    private let wireframe: RecordWireframe
    
    init(ui: RecordUI, wireframe: RecordWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        print("加载布局完成")
        
        /*
         填充数据
         */
        loadData()
    }
    
    //添加广播cookie
    func viewDidAppear() {
//        observeTextFields()
    }
    
    func viewDidDisappear() {
        //移除通知监听
//        if let observer = nttdobserver {
//            NotificationCenter.default.removeObserver(observer)
//        }
    }
    func didStartRefreshing() {
        print("开始刷新操作")
        //填充数据
        loadData()
        self.ui?.stopRefreshing()
    }
    private func load(items: [Record]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: Record) {
        //
        print("Item点击事件")
        let model = item.model!
//        type=yuedu   pid= 411      每日推荐
//        type=beitie  pid=""        碑帖
//        type=note    pid= ""       课程讲义
//        type=yuedu   pid= 413      书法世界
//        type=yuedu   pid= 414      文房雅趣
//        type=yuedu   pid= 412      名家名作
        
//        video
//        note
//        beitie
//        read  yuedu
//        peixun
        
        switch model {
        case "read":   //阅读
            let detailData = NSMutableDictionary()
            detailData.setValue(1, forKey: "pid")
            detailData.setValue(item.id, forKey: "id")
            detailData.setValue(item.name, forKey: "title")
            
            wireframe.presentStudyDetailViewController(detailData)
            break;
        case "beitie":  //碑帖
            let detailData = NSMutableDictionary()
            detailData.setValue(item.id, forKey: "id")
            detailData.setValue(item.name, forKey: "title")
            
            wireframe.presentCopyBookDetailViewController(detailData)
            break;
        case "note":    //讲义
            let detailData = NSMutableDictionary()
            detailData.setValue(item.url!, forKey: "video")
            detailData.setValue(item.name, forKey: "title")
            
            wireframe.presentLectureDetailViewController(detailData)
            break;
        case "video":    //视频
            let video = Video(name: item.name!, img_url: "", img_url_s: "", video_url: item.url!)
            wireframe.presentVideoDetailViewController(item: video)
            break;
        case "peixun":    //培训
            break;
        default:
            print("*****")
            break;
        }
    }
    
    func loadData(){
        //获取token
        let loginUser = UserServece.readWithNSKeyedUnarchiver() as! LoginUser
        let token = loginUser.access_token
        let page = 1
        //闭包调用
        getRecord(token: token!, page: page) { [weak self](records) in
            print("records.count = \(records.count)")
            self?.records = records
            if records.count > 0 {
                self?.load(items: records)
            }
        }
    }
}
