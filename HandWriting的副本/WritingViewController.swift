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
