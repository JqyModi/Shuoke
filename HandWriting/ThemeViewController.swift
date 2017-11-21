//
//  ThemeViewController.swift
//  HandWriting
//
//  Created by Modi on 2017/9/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {

    var tableView: UITableView?
    var themes: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //耗时操作
        loadData()
        configTableView()
        
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configTableView(){
        tableView = UITableView()
        tableView?.width = SCREEN_WIDTH
        tableView?.height = SCREEN_HEIGHT
        tableView?.left = 0
        tableView?.top = 0
        
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.tableFooterView = UIView()
        tableView?.register(ThemeTableCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        //配置主题色
        configTheme()
        
        //添加view
        self.view.addSubview(tableView!)
    }
    
    func loadData(){
        self.themes = [String]()
        self.themes?.append("☀️")
        self.themes?.append("🌙")
//        self.themes?.append("白天")
//        self.themes?.append("黑夜")
//        self.tableView?.reloadData()
    }
    
    
    func configTheme(){
        //判断当前主题
        let name = UserDefaults.standard.object(forKey: THEME) as! String
        switch name {
        case "☀️":
            tableView?.backgroundColor = UIColor.tabBackgroundColor
            break;
        case "🌙":
            tableView?.backgroundColor = UIColor.gray
            break;
        default:
            break;
        }
        //刷新界面
//        self.tableView?.reloadData()
    }
}

extension ThemeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ThemeTableCell
        if (cell != nil) {
            cell.name?.text = themes?[index]
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            //设置分割线颜色
//            tableView.separatorColor = UIColor.randomColor()
            //设置分割线内边距: 去默认左边边距
//            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            
            //判断当前主题
            if let name = UserDefaults.standard.object(forKey: THEME) as? String {
                switch name {
                case "☀️":
                    cell.backgroundColor = UIColor.white
                    tableView.backgroundColor = UIColor.tabBackgroundColor
                    break;
                case "🌙":
                    cell.backgroundColor = UIColor.tabBackgroundColor
                    tableView.backgroundColor = UIColor.gray
                    break;
                default:
                    break;
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //判断点击的主题：持久化当前主题
        let row = indexPath.row
        let name = (self.themes?[row])!
        
        UserDefaults.standard.set(name, forKey: THEME)
//        self.configTheme()
        //选择背景色改变
        tableView.reloadData()
    }
}
