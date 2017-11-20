//
//  UserPresenter.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
class UserPresenter: BothamPresenter, BothamNavigationPresenter, UserViewControllerDelegate {
    //初始化
    private weak var ui: UserUI?
    private let wireframe: UserWireframe
    
    init(ui: UserUI, wireframe: UserWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        print("加载布局完成")
        //填充数据
//        load(items: [User(icon: "account", name: "账号管理"),User(icon: "collect", name: "我的收藏")
//            ,User(icon: "record", name: "浏览记录"),User(icon: "clear", name: "清空缓存")
//            ,User(icon: "feedback", name: "意见反馈"),User(icon: "share", name: "分享给好友")
//            ,User(icon: "update", name: "检测更新"),User(icon: "about", name: "关于")])
        load(items: [User(icon: "password", name: "修改密码"),User(icon: "record", name: "浏览记录")
            ,User(icon: "theme", name: "主题切换")
            ,User(icon: "download", name: "下载列表")
            ,User(icon: "clear", name: "清空缓存")
//            ,User(icon: "feedback", name: "意见反馈"),User(icon: "share", name: "分享好友")
//            ,User(icon: "about", name: "关于")
            ,User(icon: "switch_account", name: "切换账号")
            ,User(icon: "exit", name: "退出")])
    }
    private func load(items: [User]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: User) {
        wireframe.presentUserDetailViewController(item: item, tag: 0)
    }
    
    func showDetaiView(tag: Int) {
        var item: User?
        switch tag {
        case 101:
            //编辑资料
            item = User(icon: "", name: "编辑资料")
            wireframe.presentUserDetailViewController(item: item!, tag: tag)
            break
        case 102:
            //更换头像
            item = User(icon: "", name: "更换头型")
            wireframe.presentUserDetailViewController(item: item!, tag: tag)
            break
        case 103:
            //登录及资料显示
            item = User(icon: "", name: "显示资料")
            wireframe.presentUserDetailViewController(item: item!, tag: tag)
            break
        case 104:
            //左边按钮
            item = User(icon: "", name: "姓名")
            wireframe.presentUserDetailViewController(item: item!, tag: tag)
            break
        case 105:
            //右边按钮
            item = User(icon: "", name: "学校")
            wireframe.presentUserDetailViewController(item: item!, tag: tag)
            break
        default:
            break
        }
    }
}
