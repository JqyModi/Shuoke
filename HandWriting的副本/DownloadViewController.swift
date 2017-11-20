//
//  DownloadViewController.swift
//  HandWriting
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SVProgressHUD

class DownloadViewController: HandWritingViewController, BothamTableViewController, DownloadUI {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<Download, DownloadTableViewCell>!
    var delegate: UITableViewDelegate!
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.TableBackgroundColor
        tableView.accessibilityLabel = "DownloadTableView"
        pullToRefreshHandler.addTo(scrollView: tableView)
        super.viewDidLoad()
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: Loading)
        configTheme()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
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
