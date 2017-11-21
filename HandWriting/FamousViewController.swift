//
//  FamousViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/24.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SVProgressHUD

class FamousViewController: HandWritingViewController, BothamTableViewController, CommonUI {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<Common, FamousTableViewCell>!
    var delegate1: UITableViewDelegate!
    var isLoadMoreData = false
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "FamousTableView"
        pullToRefreshHandler.addTo(scrollView: tableView)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: Loading)
        configTheme()
        tableView.delegate = self
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
extension FamousViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height < scrollView.contentSize.height{
            isLoadMoreData = true
        } else {
            if isLoadMoreData {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotifyLoadMore"), object: nil, userInfo: nil)
                isLoadMoreData = false
                tableView.delegate = delegate1
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.tableView.delegate = delegate1
    }
}
