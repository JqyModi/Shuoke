//
//  WritingDetailViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI

protocol WritingDetailDelegate {
    func popView(detailName: String, selTitle: String)
}
class WritingDetailViewController: HandWritingViewController, BothamTableViewController, WritingDetailUI, WritingDetailPresenterDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<WritingDetail, WritingDetailTableViewCell>!
    var delegate: UITableViewDelegate!
    
    var detailDelegate: WritingDetailDelegate?
    var itemTitle: String?
    
    override func viewDidLoad() {
        
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "WritingDetailTableView"
        pullToRefreshHandler.addTo(scrollView: tableView)
        
        tableView.separatorStyle = .none
//        tableView.delegate = self
        tableView.backgroundColor = UIColor.pageBackgroundColorGray
        super.viewDidLoad()
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
    }
    
    func rightAction() {
        //
        print("rightAction")
//        detailDelegate?.dismiss(isClose: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func selItem(detailName: String, title: String) {
        detailDelegate?.popView(detailName: detailName, selTitle: title)
    }
    
    //设置选中字体变白色:但是会拦截Item点击事件
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as? WritingDetailTableViewCell
//        cell?.keyLabel.textColor = UIColor.white
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as? WritingDetailTableViewCell
//        cell?.keyLabel.textColor = UIColor.cellTextColorDarkGray
//    }
}

