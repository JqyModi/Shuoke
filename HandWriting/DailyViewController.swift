//
//  DailyViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SVProgressHUD
import XHRefreshControl

class DailyViewController: HandWritingViewController, BothamTableViewController, CommonUI {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<Common, DailyTableViewCell>!
    var delegate1: UITableViewDelegate!
    //显示每日推荐页中轮播广告栏
    var viewPager: ViewPager?
    
    var isLoadMoreData = false
    
    //（1）获取变量
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    appDelegate.allowRotation = 1    //1表示支持横竖屏
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "DailyTableView"
        pullToRefreshHandler.addTo(scrollView: tableView)
        
        tableView.clipsToBounds = true
        
        super.viewDidLoad()

        self.viewPager = ViewPager(frame: CGRect(x: 5, y: 5, width: SCREEN_WIDTH-10, height:  180))
        viewPager?.dataSource = self
        viewPager?.animationNext()
        
        tableView.tableHeaderView = viewPager
        
        //配置上拉。下拉
        configRefresh()
        
        //（2）在viewDidLoad中修改blockRotation变量值
//        appDelegate.blockRotation = true
        
        appDelegate.allowRotation = 1
    }
    
    func configRefresh(){
        let xhRefreshControl = XHRefreshControl(scrollView: tableView, delegate: self)
//        xhRefreshControl?.startLoadMoreRefreshing()
//        xhRefreshControl?.startPullDownRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewPager?.scrollToPage(index: 0)
        SVProgressHUD.dismiss()
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: Loading)
        configTheme()
        self.tableView.delegate = self
        
        //（3）viewWillAppear 设置页面横屏
//        let value = UIInterfaceOrientation.landscapeLeft.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //（4）viewWillDisappear设置页面转回竖屏
//        appDelegate.blockRotation = false
//        let value = UIInterfaceOrientation.portrait.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    //（5）横屏页面是否支持旋转
    // 是否支持自动横屏。看项目可调，可以设置为true
//    override func shouldAutorotate() -> Bool {
//        return false
//    }
//    override var shouldAutorotate: Bool {
//        return true
//    }
    
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
        
        //刷新界面使item主题色生效
        self.tableView.reloadData()
    }
}
extension DailyViewController:ViewPagerDataSource{
    func numberOfItems(viewPager:ViewPager) -> Int {
        return 5;
    }
    
    func viewAtIndex(viewPager:ViewPager, index:Int, view:UIView?) -> UIView {
        var newView = view;
        var label:UILabel?
        if(newView == nil){
//            newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  self.view.frame.height))
//            print("width = \(SCREEN_WIDTH)")
            newView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:  self.view.frame.height))
            //设置广告轮播图片
            let adView = UIImageView(frame: (newView?.frame)!)
//            adView.backgroundColor = UIColor.red
            adView.image = UIImage(named: "ad_01")
            adView.sizeToFit()
            adView.contentMode = .scaleAspectFit
            newView?.contentMode = .scaleAspectFit
            newView?.sizeToFit()
            
            newView?.addSubview(adView)
        }else{
            label = newView?.viewWithTag(1) as? UILabel
        }
        
        label?.text = "Page View Pager  \(index+1)"
        
        return newView!
    }
    
    func didSelectedItem(index: Int) {
        print("select index \(index)")
    }
}

extension DailyViewController: XHRefreshControlDelegate, UITableViewDelegate {
    //下拉刷新
    func beginPullDownRefreshing() {
        print("下拉刷新")
    }
    //上拉加载
    func beginLoadMoreRefreshing() {
        print("上拉加载")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height < scrollView.contentSize.height{
            isLoadMoreData = true
        } else {
            if isLoadMoreData {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotifyLoadMore"), object: nil, userInfo: nil)
                isLoadMoreData = false
                self.tableView.delegate = delegate1
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.tableView.delegate = delegate1
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
