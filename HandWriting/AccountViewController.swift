//
//  AccountViewController.swift
//  HandWriting
//
//  Created by mac on 9/5/17.
//  Copyright © 2017 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SCLAlertView_Objective_C

protocol AccountViewControllerDelegate {
    func refreshTableItem()
}

class AccountViewController: HandWritingViewController, BothamTableViewController, AccountUI {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<Account, AccountTableViewCell>!
    var delegate: UITableViewDelegate!
    
    var loginUser: LoginUser?
    
    var refreshItemDelegate: AccountViewControllerDelegate?
    
    var isItemEnabled = false
    
    var currentSelect = 0
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "AccountTableView"
        //        pullToRefreshHandler.addTo(scrollView: tableView)
        self.tableView.separatorStyle = .none
        //设置Item不可交互
        if isItemEnabled {
            self.tableView.isUserInteractionEnabled = true
        }else{
            self.tableView.isUserInteractionEnabled = false
        }
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
        //刷新界面
        self.tableView.reloadData()
    }
    
    func showDialog(account: Account) {
        let alert = SCLAlertView(newWindowWidth: SCREEN_WIDTH-50)
        
        //处理性别输入
        if account.key == "性别" {
            let w = (SCREEN_WIDTH-70)
            let sexView = SexChoiceView(frame: CGRect(x: 0, y: 0, width: w, height: 30))
            sexView.sexDelegate = self
            alert?.addCustomView(sexView)
            alert?.showCustom(UIImage.init(named: "pen_dialog"), color: UIColor.DialogColor, title: "性别", subTitle: "请选择性别", closeButtonTitle: "确定", duration: TimeInterval(Int.max))
        }else{
            let textField = alert?.addTextField(account.value)
            alert?.addButton("确认", actionBlock: {
                //回填数据到Item: 更新本地数据
                print("确认点击")
                let text = textField?.text
                let key = account.key
                //获取本地持久化数据
                let loginUser = UserServece.readWithNSKeyedUnarchiver() as! LoginUser
                switch key {
                case "姓名":
                    loginUser.name = text!
                    break;
                case "昵称":
                    loginUser.nick = text!
                    break;
                case "身份":
                    loginUser.type = text!
                    break;
                case "学校":
                    loginUser.school = text!
                    break;
                case "班级":
                    loginUser.className = text!
                    break;
                case "邮箱":
                    loginUser.email = text!
                    break;
                case "地址":
                    loginUser.addr = text!
                    break;
                case "简介":
                    loginUser.remark = text!
                    break;
                default:
                    break;
                }
                //将数据重新持久化到本地
                UserServece.saveWithNSKeyedArchiver(obj1: loginUser)
                //刷新列表数据
                self.refreshItemDelegate?.refreshTableItem()
            })
            alert?.showEdit(account.key, subTitle: "请输入更改后的\(account.key)", closeButtonTitle: "取消", duration: TimeInterval(Int.max))
        }
    }
    
    //确定按钮点击事件
    func rightAction(){
        print("确定")
        //获取本地持久化数据
        let loginUser = UserServece.readWithNSKeyedUnarchiver() as! LoginUser?
        //将数据提交到服务器
        updateUserInfo(loginUser: loginUser!)
        //刷新数据？
//        self.refreshItemDelegate?.refreshTableItem()
        //关闭当前界面: 返回用户中心界面
        self.navigationController?.popToRootViewController(animated: true)
    }
}
extension AccountViewController: SexChoiceDelegate {
    func itemSelect(index: Int) {
//        if index == 0 {
//            print("性别男")
//        }else if index == 1 {
//            print("性别女")
//        }
        currentSelect = index
        //获取本地持久化数据
        let loginUser = UserServece.readWithNSKeyedUnarchiver() as! LoginUser
        loginUser.sex = self.currentSelect
        //将数据重新持久化到本地
        UserServece.saveWithNSKeyedArchiver(obj1: loginUser)
        //刷新列表数据
        self.refreshItemDelegate?.refreshTableItem()
    }
}
