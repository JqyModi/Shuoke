//
//  VideoViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/21.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SwiftyJSON
import CBMDTabbarController
import SVProgressHUD

protocol VideoViewControllerDelegate{
    func loadCategoryData(items: [Video])
}
class VideoViewController: HandWritingViewController, BothamTableViewController, VideoUI {
    
//    //MARK: - 访客模式
//    //添加用户是否登录标记
//    var userLogin = UserServece.checkLogin()
//    var visitorLoginView: VisitorLoginView?
//    //loadVIew是苹果专门为手写代码 准备的  等效与 sb / xib
//    //一旦实现这个方法  xib / sb就自动失效
//    //会自动检测 view是否为空  如果为空 会自动调用 loadView方法
//    override func loadView() {
//        userLogin ? super.loadView() : loadVisitorView()
//    }
//
//    //    override func viewWillLayoutSubviews() {
//    //        userLogin ? super.viewWillLayoutSubviews() : loadVisitorView()
//    //    }
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
    
    var dataBihua = NSMutableArray()
    var dataPianpang = NSMutableArray()
    var dataJiegou = NSMutableArray()
    var dataNianji = NSMutableArray()
    
    var data1: NSMutableArray?
    var data2: NSMutableArray?
    var data3: NSMutableArray?
    var data4: NSMutableArray?
    
    var _currentData1Index: NSInteger?
    var _currentData2Index: NSInteger?
    var _currentData3Index: NSInteger?
    var _currentData4Index: NSInteger?
    
    var _currentData1SelectedIndex: NSInteger?
    
    var menu: JSDropDownMenu?
    
    var loadCategoryDelegate: VideoViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<Video, VideoTableViewCell>!
    var delegate1: UITableViewDelegate!
    var isLoadMoreData = false
    
//    override func viewWillLayoutSubviews() {
//        userLogin ? super.viewWillLayoutSubviews() : toLoginController()
//    }
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "VideoTableView"
        pullToRefreshHandler.addTo(scrollView: tableView)
        super.viewDidLoad()
        configHeaderView()
        configCellStyle()

    }
    
    override func viewDidLayoutSubviews() {
        debugPrint("viewDidLayoutSubviews")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configTheme()
        //设置事件委托为滚动
        self.tableView.delegate = self
        //初始化菜单放在此方法中：横竖屏切换需要重新初始化
        configDropDownMenu()
        configureNavigationBar()
    }
    
    /*
     跳转到登录页
     */
//    func toLoginController(){
//        let viewController = LoginViewController()
//        debugPrint("跳转登录页")
//        viewController.title = "登录"
//        ServiceLocator.sharedInstance.provideVideoNavigator()?.present(viewController, animated: true, completion: nil)
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
        //刷新界面
        self.tableView.reloadData()
    }
    
    func configCellStyle(){
//        let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0))
    }
    
    func configHeaderView(){
        
    }
    
    func configDropDownMenu() {
        // 指定默认选中
        _currentData1Index = 0
        _currentData2Index = 0
        _currentData3Index = 0
        _currentData4Index = 0
        _currentData1SelectedIndex = 0;
        
        initMenuData()
        
        let food: NSArray = ["全部美食", "火锅", "川菜", "西餐", "自助餐"]
        let travel: NSArray = ["全部旅游", "周边游", "景点门票", "国内游", "境外游"]
        
        data1 = NSMutableArray()

        let obj = NSMutableDictionary()
        obj.setValue("笔画", forKey: "title")
        obj.setValue(dataBihua, forKey: "data")
//        let obj1 = NSMutableDictionary()
//        obj1.setValue("旅游", forKey: "title")
//        obj1.setValue(travel, forKey: "data")
        data1?.addObjects(from: [obj])
        
        data2 = NSMutableArray()
//        data2?.addObjects(from: ["智能排序", "离我最近", "评价最高", "最新发布", "人气最高", "价格最低", "价格最高"])
        data2 = dataPianpang
        
        data3 = NSMutableArray()
//        data3?.addObjects(from: ["不限人数", "单人餐", "双人餐", "3~4人餐"])
        data3 = dataJiegou
        
        data4 = NSMutableArray()
        data4?.addObjects(from: ["不限", "欧体", "颜体"])
        
        let bWidth = UIScreen.main.bounds.width   ///<    屏幕宽度
        let bHeight = UIScreen.main.bounds.height  ///<    屏幕高度
        menu = JSDropDownMenu(origin: CGPoint.init(x: 0, y: 0), andHeight: 45)
//        menu = JSDropDownMenu(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
        debugPrint("*****************************bwidth = \(bWidth)")
//        SVProgressHUD.showInfo(withStatus: "*****************************bwidth = \(bWidth)")
//        menu = JSDropDownMenu(frame: CGRect(x: 0, y: 0, width: bWidth, height: 45))
        
        menu?.indicatorColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        menu?.separatorColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        menu?.textColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        menu?.dataSource = self
        menu?.delegate = self
        
//        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VideoTableViewCell
//        if cell.frame.minY < 0 {
//            self.view.insertSubview(menu!, aboveSubview: tableView)
//        }else{
//            self.tableView.tableHeaderView = menu
//        }
        //设置分类控件位置
        self.view.addSubview(menu!)
        self.tableView.frame = CGRect(x: 0, y: 45, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-45)
//        self.tableView.top = (menu?.bottom)!
    }
    
    func initMenuData(){
        let jsonStr = readVideoCategory(name: "category")
        let json = JSON.init(parseJSON: jsonStr)
        
        debugPrint("json = \(json)")
        
        //字典－数组－字典
        let dict: NSDictionary = json.dictionaryObject! as NSDictionary
        let attr: NSArray = dict.value(forKey: "attr") as! NSArray
        for (index,item) in attr.enumerated() {
            let dictCate = item as! NSDictionary
            let key = dictCate.value(forKey: "key") as! String
            
            var vals = NSArray()
            switch key {
            case "年级":
                break
            case "笔画":
                vals = dictCate.value(forKey: "vals") as! NSArray
                //加入不限选项以适配单选
                dataBihua.add(VideoCategory(id: "0", isCheck: false, val: "不限", type: "bihua"))
                for item in vals {
                    let dictDetail = item as! NSDictionary
                    let id = dictDetail.value(forKey: "id") as! String
                    let isCheck = Bool.init(dictDetail.value(forKey: "isCheck") as! String)
                    let val = dictDetail.value(forKey: "val") as! String
//                    let type = dictDetail.value(forKey: "type") as! String
                    let type = "bihua"
                    let category = VideoCategory(id: id, isCheck: isCheck!, val: val, type: type)
                    dataBihua.add(category)
                }
                
                break
            case "偏旁":
                vals = dictCate.value(forKey: "vals") as! NSArray
                //加入不限选项以适配单选
                dataPianpang.add(VideoCategory(id: "0", isCheck: false, val: "不限", type: "bianpang"))
                for item in vals {
                    let dictDetail = item as! NSDictionary
                    let id = dictDetail.value(forKey: "id") as! String
                    let isCheck = Bool.init(dictDetail.value(forKey: "isCheck") as! String)
                    let val = dictDetail.value(forKey: "val") as! String
//                    let type = dictDetail.value(forKey: "type") as! String
                    let type = "bianpang"
                    let category = VideoCategory(id: id, isCheck: isCheck!, val: val, type: type)
                    dataPianpang.add(category)
                }
                break
            case "结构":
                vals = dictCate.value(forKey: "vals") as! NSArray
                dataJiegou.add(VideoCategory(id: "0", isCheck: false, val: "不限", type: "jiegou"))
                for item in vals {
                    let dictDetail = item as! NSDictionary
                    let id = dictDetail.value(forKey: "id") as! String
                    let isCheck = Bool.init(dictDetail.value(forKey: "isCheck") as! String)
                    let val = dictDetail.value(forKey: "val") as! String
//                    let type = dictDetail.value(forKey: "type") as! String
                    let type = "jiegou"
                    let category = VideoCategory(id: id, isCheck: isCheck!, val: val, type: type)
                    dataJiegou.add(category)
                }
                break
            default:
                break
            }
            
        }
        
    }
    
    func readVideoCategory(name: String) -> String {
        let fileUrl = Bundle.main.url(forResource: name, withExtension: ".json", subdirectory: nil, localization: nil)
        var json = ""
        do{
            //获取文件句柄:sanzijing.txt
            let fileHandle = try FileHandle(forReadingFrom: fileUrl!)
            //
            let data = fileHandle.readDataToEndOfFile()
            json = String(data: data, encoding: String.Encoding.utf8)!
            debugPrint(json)
            //            self.writingBack?.setDrawText(text: firstStr!)
        }catch{
            debugPrint("文件读取失败")
            json = ""
        }
        return json
    }
    /*
     隐藏状态栏
     */
    override var prefersStatusBarHidden: Bool{
        return false
    }
    private func configureNavigationBar() {
        //解决状态栏遮挡
//        self.menu?.top = 21
//        self.tableView.top = (self.menu?.bottom)! + 100
    }
}

extension VideoViewController: JSDropDownMenuDataSource, JSDropDownMenuDelegate{
    func numberOfColumns(in menu: JSDropDownMenu!) -> Int {
        return 4
    }
    
    func displayByCollectionView(inColumn column: Int) -> Bool {
        if (column==2) {
            
            return true;
        }
        
        return false;
    }
    func haveRightTableView(inColumn column: Int) -> Bool {
        if (column==0) {
            return true;
        }
        return false;
    }
    func widthRatio(ofLeftColumn column: Int) -> CGFloat {
        if (column==0) {
            return 0.3;
        }
        
        return 1;
    }
    func currentLeftSelectedRow(_ column: Int) -> Int {
        if (column==0) {
            
            return _currentData1Index!;
            
        }
        if (column==1) {
            
            return _currentData2Index!;
        }
        
        return 0;
    }
    func menu(_ menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        if (column==0) {
            if (leftOrRight==0) {
                
                return data1!.count;
            } else{
                let menuDic: NSDictionary = data1?.object(at: leftRow) as! NSDictionary
                let data: NSArray = menuDic.object(forKey: "data") as! NSArray
                return data.count
            }
        } else if (column==1){
            
            return data2!.count;
            
        } else if (column==2){
            
            return data3!.count;
        }else if (column == 3) {
            return data4!.count;
        }
        
        return 0;
    }
    func menu(_ menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        switch (column) {
        case 0:
            let obj = self.data1?.object(at: _currentData1Index!) as! NSObject
            let array = obj.value(forKey: "data") as! NSArray
            let category = array.object(at: _currentData1Index!) as! VideoCategory
            return category.val
            
        case 1:
//            let obj = self.data2?.object(at: _currentData2Index!)
//            return obj as! String
            let obj = self.data2?.object(at: _currentData2Index!) as! VideoCategory
            return obj.val
        case 2:
//            let obj = self.data3?.object(at: _currentData3Index!)
//            return obj as! String
            let obj = self.data3?.object(at: _currentData3Index!) as! VideoCategory
            return obj.val
        case 3:
            let obj = self.data4?.object(at: _currentData4Index!)
            return obj as! String
        default:
            return nil
        }
    }
    func menu(_ menu: JSDropDownMenu!, titleForRowAt indexPath: JSIndexPath!) -> String! {
        if (indexPath.column==0) {
            if (indexPath.leftOrRight==0) {
                let menuDic: NSDictionary = data1?.object(at: indexPath.row) as! NSDictionary
                return menuDic.object(forKey: "title") as! String!
            } else{
                let leftRow: NSInteger = indexPath.leftRow;
                let menuDic: NSDictionary = data1?.object(at: leftRow) as! NSDictionary
                let data = menuDic.object(forKey: "data") as! NSArray
                let category = data.object(at: indexPath.row) as! VideoCategory
                return category.val
            }
        } else if (indexPath.column==1) {
//            let obj = self.data2?.object(at: indexPath.row) as! NSObject
//            return obj as! String
            let obj = self.data2?.object(at: indexPath.row) as! VideoCategory
            return obj.val
        } else if (indexPath.column == 2) {
//            let obj = self.data3?.object(at: indexPath.row) as! NSObject
//            return obj as! String
            let obj = self.data3?.object(at: indexPath.row) as! VideoCategory
            return obj.val
        }else{
            let obj = self.data4?.object(at: indexPath.row) as! NSObject
            return obj as! String
        }
    }
    
    func menu(_ menu: JSDropDownMenu!, didSelectRowAt indexPath: JSIndexPath!) {
        if (indexPath.column == 0) {
            
            if(indexPath.leftOrRight==0){
                
                _currentData1Index = indexPath.row;
                
                return;
            }
        } else if(indexPath.column == 1){
            
            _currentData2Index = indexPath.row;
            
        } else if (indexPath.column == 2){
            
            _currentData3Index = indexPath.row;
        }else if (indexPath.column == 3){
            _currentData4Index = indexPath.row;
        }
        
        //判断当前选中的分类有哪些
        
        let obj = self.data1?.object(at: _currentData1Index!) as! NSObject
        let array = obj.value(forKey: "data") as! NSArray
        let category = array.object(at: indexPath.row) as! VideoCategory
        let bh = category.id
        
        let obj1 = self.data2?.object(at: _currentData2Index!) as! VideoCategory
        let pp = obj1.id
        
        let obj2 = self.data3?.object(at: _currentData3Index!) as! VideoCategory
        let jg = obj2.id
        
        let obj3 = self.data4?.object(at: _currentData4Index!) as! NSObject
        let zt: String = obj3 as! String
        var ztID = 0
        if zt == "欧体" {
            ztID = 678
        }else if zt == "颜体" {
            ztID = 679
        }
        
        debugPrint("bh = \(bh)")
        debugPrint("bh = \(pp)")
        debugPrint("bh = \(jg)")
        debugPrint("bh = \(zt)")
        //bug待修复
        getVideoData(jiegou: Int(jg)!, bianpang: Int(pp)!, bihua: Int(bh)!, class1: 0, page: 1, finished:{ (items) in
            //加载数据
            self.loadCategoryDelegate?.loadCategoryData(items: items)
        })
    }
}

extension VideoViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height < scrollView.contentSize.height{
            isLoadMoreData = true
        } else {
            if isLoadMoreData {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotifyLoadMore"), object: nil, userInfo: nil)
                isLoadMoreData = false
            }
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.tableView.delegate = delegate1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.delegate = self
    }
}


