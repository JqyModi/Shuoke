//
//  DownloadPresenter.swift
//  HandWriting
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

class DownloadPresenter: BothamPresenter, BothamPullToRefreshPresenter, BothamNavigationPresenter{
    //初始化
    private weak var ui: DownloadUI?
    private var item: User?
    
    var downloads: [Download]?
    
    var basePath = ""
    
    private let wireframe: DownloadWireframe
    
    init(ui: DownloadUI, wireframe: DownloadWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        debugPrint("加载布局完成")
        
        /*
         填充数据
         */
        loadData()
        
    }
    func didStartRefreshing() {
        debugPrint("开始刷新操作")
        //填充数据
        loadData()
        self.ui?.stopRefreshing()
    }
    private func load(items: [Download]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: Download) {
//        debugPrint("Item点击事件")
        let url = self.basePath + "/" + item.path
//        let detailData = NSMutableDictionary()
//        detailData.setValue(url, forKey: "video")
//        detailData.setValue(item.path.replacingOccurrences(of: ".ppt", with: ""), forKey: "title")
//        wireframe.presentLectureDetailViewController(detailData)
        wireframe.presentDownloadDetailViewController(URL(fileURLWithPath: url))
    }
    
    func loadData(){
        getDownloadFiles { (items,basePath) in
            if items.count > 0 {
                self.load(items: items)
                self.basePath = basePath
            }
        }
    }
}
