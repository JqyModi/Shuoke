//
//  WritingPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
class WritingPresenter: BothamPresenter, BothamNavigationPresenter, WritingWireframeDelegate {
    //初始化
    private weak var ui: WritingUI?
    private let wireframe: WritingWireframe
    var data: [Writing]?
    
    let ArticleKEY = "ArticleKEY"
    let TtfKEY = "TtfKEY"
    let SizeKEY = "SizeKEY"
    
    init(ui: WritingUI, wireframe: WritingWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        print("加载布局完成")
        
        wireframe.delegate = self
        
        //填充数据
        data = [Writing(key: "选择文章", value: "唐诗300首"),
                Writing(key: "选择字体", value: "楷书"),
                Writing(key: "画笔大小", value: "适中"),
                //Writing(key: "练字记录", value: "0"),
                //Writing(key: "今日已练", value: "0"),
                //Writing(key: "练习字数", value: "一字帖"),
                Writing(key: "", value: "开始练习")]
        load(items: data!)
    }
    private func load(items: [Writing]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: Writing) {
        if item.value != "开始练习" {
            wireframe.presentWritingDetailViewController(item.key)
        }else{
            let data = NSMutableDictionary()
            data.setValue(self.data?[0].value, forKey: ArticleKEY)
            data.setValue(self.data?[1].value, forKey: TtfKEY)
            data.setValue(self.data?[2].value, forKey: SizeKEY)
            wireframe.presentWritingStartViewController(data)
        }
    }
    
    func selItem(detailName: String, title: String) {
        switch detailName {
        case "选择文章":
            data?.remove(at: 0)
            let writing = Writing(key: detailName, value: title)
            data?.insert(writing, at: 0)
            break
        case "选择字体":
            data?.remove(at: 1)
            let writing = Writing(key: detailName, value: title)
            data?.insert(writing, at: 1)
            break
        case "画笔大小":
            data?.remove(at: 2)
            let writing = Writing(key: detailName, value: title)
            data?.insert(writing, at: 2)
            break
        case "练习字数":
            data?.remove(at: 3)
            let writing = Writing(key: detailName, value: title)
            data?.insert(writing, at: 3)
            break
        default:
            break
        }
        load(items: data!)
    }
}
