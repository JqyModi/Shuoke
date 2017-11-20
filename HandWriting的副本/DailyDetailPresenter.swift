//
//  DailyDetailPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/24.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
class DailyDetailPresenter: BothamPresenter {
    private let detailData: NSMutableDictionary
    private weak var ui: DailyDetailUI?
    
    init(ui: DailyDetailUI, detailData: NSMutableDictionary) {
        self.ui = ui
        self.detailData = detailData
    }
    
    func viewDidLoad() {
        let title = detailData.value(forKey: "title") as! String
        ui?.title = title.uppercased()
        loadDailyDetail()
    }
    private func loadDailyDetail() {
        //构造数据填充
        //http://shuoke360.cn/api/copybook?token=gstshuoke360&type=yuedu&pid=411&id=1115
        let DailyDetailBaseURL = "http://shuoke360.cn/api/copybook?token=gstshuoke360&type=yuedu"
        let pid = detailData.value(forKey: "pid")
        let id = detailData.value(forKey: "id")
        let urlStr = DailyDetailBaseURL + "&pid=\(pid!)&id=\(id!)"
        
        self.ui?.show(item: URL(string: urlStr)!)
    }
}
