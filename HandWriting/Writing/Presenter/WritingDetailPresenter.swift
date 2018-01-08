//
//  WritingDetialPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
@objc protocol WritingDetailPresenterDelegate {
    func selItem(detailName: String, title: String)
}

class WritingDetailPresenter: BothamPresenter, BothamPullToRefreshPresenter, BothamNavigationPresenter {
    private let writingName: String
    private weak var ui: WritingDetailUI?
    weak var writingDetailPresenterDelegate: WritingDetailPresenterDelegate?
    
    init(ui: WritingDetailUI, writingName: String) {
        self.ui = ui
        self.writingName = writingName
    }
    
    func viewDidLoad() {
        ui?.title = writingName.uppercased()
        loadWritingDetail()
    }
    func didStartRefreshing() {
        //刷新
        loadWritingDetail()
    }
    private func loadWritingDetail() {
        //构造数据填充
        var writingDetails: [WritingDetail]?
        switch writingName {
        case "选择文章":
            writingDetails = [WritingDetail(name: "唐诗300首"),WritingDetail(name: "宋词300首")
                ,WritingDetail(name: "三字经"),WritingDetail(name: "名人名言")
                ,WritingDetail(name: "励志名言")]
            break
        case "选择字体":
            writingDetails = [WritingDetail(name: "楷书"),WritingDetail(name: "隶书")
//                ,WritingDetail(name: "草书")
//                ,WritingDetail(name: "行书")
//                ,WritingDetail(name: "篆书")
//                ,WritingDetail(name: "颜体")
//                ,WritingDetail(name: "欧体")
                ,WritingDetail(name: "钟齐翰墨体")]
            break
        case "画笔大小":
            writingDetails = [WritingDetail(name: "较细"),WritingDetail(name: "适中")
                ,WritingDetail(name: "较粗")]
            break
        case "练字记录":
            return
        case "今日已练":
            return
        case "练习字数":
            writingDetails = [WritingDetail(name: "一字帖"),WritingDetail(name: "六字帖")
                ,WritingDetail(name: "九字帖")]
            break
        default:
            return
        }
        
//        ui?.configureHeader(series)
        
        self.ui?.show(items: writingDetails!)
        self.ui?.stopRefreshing()
    }
    
    func itemWasTapped(_ item: WritingDetail) {
        self.writingDetailPresenterDelegate?.selItem(detailName: writingName,title: item.name)
    }
}
