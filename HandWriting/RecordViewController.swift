//
//  RecordViewController.swift
//  HandWriting
//
//  Created by mac on 17/9/18.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    var tableView: UITableView?
    var records: [Record]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
        //耗时操作
        
        loadData()
        
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
        tableView?.register(RecordCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView?.backgroundColor = UIColor.tabBackgroundColor
        //添加view
        self.view.addSubview(tableView!)
    }
    
    func loadData(){
        //获取token
        let loginUser = UserServece.readWithNSKeyedUnarchiver() as! LoginUser
        let token = loginUser.access_token
        let page = 1
        //闭包调用
        getRecord(token: token!, page: page) { [weak self](records) in
            debugPrint("records.count = \(records.count)")
            self?.records = records
            if records.count > 0 {
                self?.tableView?.reloadData()
            }
        }
    }

}

extension RecordViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RecordCell
//        if (cell != nil) {
//            //单元格样式设置为UITableViewCellStyleDefault
//            cell = RecordCell.init(style: .default, reuseIdentifier: "cell")
//        }
        let index = indexPath.row
        if let item = records?[index] {
            cell?.name?.text = item.name
            cell?.type?.text = item.model
            //格式化时间
            let date2 = NSDate(timeIntervalSince1970: TimeInterval.init(item.dateline!)!)
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "yyyy-MM-dd"
            let dateString2 = formatter2.string(from: date2 as Date)
            cell?.time?.text = dateString2
        }
        
        return cell!
    }
    
    //设置单元格的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
