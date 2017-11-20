//
//  VideoDetailPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

class VideoDetailPresenter: BothamPresenter {
    //初始化
    private weak var ui: VideoDetailUI?
    private let item: Video
    
    init(ui: VideoDetailUI, item: Video) {
        self.ui = ui
        self.item = item
    }
    
    func viewDidLoad() {
        ui?.title = self.item.name.uppercased()
        
        print("加载布局完成")
        //填充数据
        self.load(item: self.item)
    }
    private func load(item: Video) {
        self.ui?.show(item: item)
    }
}
