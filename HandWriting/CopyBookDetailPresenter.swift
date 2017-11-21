//
//  CopyBookDetailPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

class CopyBookDetailPresenter: BothamPresenter {
    
    private let detailData: NSMutableDictionary
    private weak var ui: CopyBookDetailUI?
    
    init(ui: CopyBookDetailUI, detailData: NSMutableDictionary) {
        self.ui = ui
        self.detailData = detailData
    }
    
    func viewDidLoad() {
        let title = detailData.value(forKey: "title") as! String
        ui?.title = title.uppercased()
        loadSeriesDetail()
    }
    
    private func loadSeriesDetail() {
        //联网获取数据并显示
        //http://shuoke360.cn/api/copybook/?token=gstshuoke360&page=0&id=1223&type=beitie
        let id = detailData.value(forKey: "id")
        getCopyBookDetailData(type: "beitie", id: id as! String, page: 1) { [weak self](items) in
            //开始填充数据
            //ui?.configureHeader(series)
            self?.ui?.show(items: items)
        }

    }
}
