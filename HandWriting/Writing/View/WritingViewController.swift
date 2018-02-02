//
//  WritingViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import CBMDTabbarController

class WritingViewController: HandWritingViewController, BothamTableViewController, WritingUI {
    
//    //MARK: - 访客模式
//    //添加用户是否登录标记
//    var userLogin = UserServece.checkLogin()
//    var visitorLoginView: VisitorLoginView?
//    //loadVIew是苹果专门为手写代码 准备的  等效与 sb / xib
//    //一旦实现这个方法  xib / sb就自动失效
//    //会自动检测 view是否为空  如果为空 会自动调用 loadView方法
////    override func loadView() {
////        userLogin ? super.loadView() : loadVisitorView()
////    }
//    
//    override func viewWillLayoutSubviews() {
//        userLogin ? super.viewWillLayoutSubviews() : loadVisitorView()
//    }
//    
//    private func loadVisitorView() {
//        //view的大小  在 viewDidLoad就会设置
//        visitorLoginView = VisitorLoginView()
//        //设置代理
//        visitorLoginView?.visitorDelegate = self
//        view.addSubview(visitorLoginView!)
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: "visitorWillRegister")
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: "visitorWillLogin")
//        
//    }
//    
//    //MARK:visitorDelegate 协议方法
//    func visitorWillRegister() {
//        print("come on")
//    }
//    
//    func visitorWillLogin() {
//        print("come in")
//    }
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<Writing, WritingTableViewCell>!
    var delegate: UITableViewDelegate!
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "WritingTableView"
//        pullToRefreshHandler.addTo(scrollView: tableView)
        self.tableView.separatorStyle = .none
        super.viewDidLoad()
        
        configTabbarStyle()
    }
    
    private func configTabbarStyle(){
        let tabbarItem1 = tabBarItem as! CBMaterialTabbarItem
        tabbarItem1.rippleLayerColor = UIColor.Tabbar2Color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configTheme()
    }
    
    func configTheme(){
        //判断当前主题
        let name = UserDefaults.standard.object(forKey: THEME) as! String
        switch name {
        case "☀️":
            tableView?.backgroundColor = UIColor.TableBackgroundColor
            break;
        case "🌙":
            tableView?.backgroundColor = UIColor.tabBackgroundColor
            break;
        default:
            break;
        }
        //刷新界面
        self.tableView.reloadData()
    }
}
