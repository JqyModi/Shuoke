//
//  LectureDetailPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
class LectureDetailPresenter: BothamPresenter {
    private let detailData: NSMutableDictionary
    private weak var ui: LectureDetailUI?
    
    init(ui: LectureDetailUI, detailData: NSMutableDictionary) {
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
//        4、讲义详情
//        https://view.officeapps.live.com/op/view.aspx?src="+url
//        url = video
        let DailyDetailBaseURL = "https://view.officeapps.live.com/op/view.aspx?src="
        let video = detailData.value(forKey: "video") as! String
        let urlStr = DailyDetailBaseURL + BASEURL + video
        
        //http://shuoke360.cn//Public/Uploads/Note/20170925/59c8840e7c231.ppt -可打开
        //http://shuoke360.cn//Public/Uploads/Note/20170922/59c4a3bfcb95c.ppt -不可打开
        if video.contains("mobile") {
            self.ui?.show(item: URL(fileURLWithPath: video))
        }else{
            self.ui?.show(item: URL(string: BASEURL + video)!)
        }
    }
}
