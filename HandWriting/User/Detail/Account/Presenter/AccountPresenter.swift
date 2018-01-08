//
//  AccountPresenter.swift
//  HandWriting
//
//  Created by mac on 9/5/17.
//  Copyright © 2017 modi. All rights reserved.
//

import Foundation
import BothamUI
class AccountPresenter: BothamPresenter, BothamNavigationPresenter, AccountViewControllerDelegate {
    //初始化
    private weak var ui: AccountUI?
    private let item: User?
//    private let wireframe: AccountWireframe
    
    var loginUser: LoginUser?
    
    init(ui: AccountUI, item: User) {
        self.ui = ui
        self.item = item
    }
    
    func viewDidLoad() {
        //设置标题文字
        ui?.title = item?.name.uppercased()
        debugPrint("加载布局完成")
        
        self.loadUserInfo()
        
//        NotificationCenter.default.addObserver(self, selector: Selector("refreshItem"), name: NSNotification.Name(rawValue: NotifyRefreshUserListItem), object: nil)
    }
    
    func refreshItem(){
        self.loadUserInfo()
    }
    
    func loadUserInfo(){
        //获取本地持久化数据
        self.loginUser = UserServece.readWithNSKeyedUnarchiver() as! LoginUser?
        
        //填充数据
        if (loginUser?.access_token?.characters.count)!>0 {
            load(items: [Account(key: "姓名", value: (loginUser?.name)!),Account(key: "昵称", value: (loginUser?.nick)!)
                ,Account(key: "性别", value: String(describing: (loginUser?.sex)!)),Account(key: "身份", value: String(describing: (loginUser?.type)!))
                ,Account(key: "学校", value: (loginUser?.school)!),Account(key: "班级", value: (loginUser?.className)!)
                ,Account(key: "邮箱", value: (loginUser?.email)!),Account(key: "地址", value: (loginUser?.addr)!)
                ,Account(key: "简介", value: (loginUser?.remark)!)])
        }
    }
    
    func getLoginUser(notification: NSNotification){
        loginUser = notification.object as? LoginUser
    }
    
    private func load(items: [Account]) {
        self.ui?.show(items: items)
    }
    
    func itemWasTapped(_ item: Account) {
        ui?.showDialog(account: item)
    }
    
    func refreshTableItem() {
        self.refreshItem()
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
}
//extension AccountPresenter: AccountViewControllerDelegate{
//    
//}


