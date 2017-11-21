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
    
    init(ui: PageHomeUI, wireframe: PageHomeWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    init(wireframe: PageHomeWireframe) {
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        print("加载布局完成")
        //填充数据
//        load(items: [PageHome(name: "每日推荐"),
//                     PageHome(name: "常用碑帖"),
//                     PageHome(name: "课程讲义"),
//                     PageHome(name: "书法视界"),
//                     PageHome(name: "文房雅趣"),
//                     PageHome(name: "名家名作")])
    }
    private func load(items: [PageHome]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: PageHome) {
        print("................")
        
    }
}