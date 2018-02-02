//
//  ViewPagerController.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import CBMDTabbarController
import SVProgressHUD

class HomeViewPagerController: HandWritingViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let tabs1: [ViewPagerTab] = [
        ViewPagerTab(title: "Apple", image: UIImage(named: "apple")),
        ViewPagerTab(title: "Carrot", image: UIImage(named: "carrot")),
        ViewPagerTab(title: "Grapes", image: UIImage(named: "grapes")),
        ViewPagerTab(title: "Lemon", image: UIImage(named: "lemon")),
        ViewPagerTab(title: "Orange", image: UIImage(named: "orange")),
        ViewPagerTab(title: "Strawberry", image: UIImage(named: "strawberry")),
        ViewPagerTab(title: "Watermelon", image: UIImage(named: "watermelon"))
    ]
    
    let tabs2: [ViewPagerTab] = [
        ViewPagerTab(title: "Cheese", image: UIImage(named: "cheese")),
        ViewPagerTab(title: "Cupcake", image: UIImage(named: "cupcake")),
        ViewPagerTab(title: "Doughnut", image: UIImage(named: "doughnut")),
        ViewPagerTab(title: "Fish", image: UIImage(named: "fish")),
        ViewPagerTab(title: "Meat", image: UIImage(named: "meat")),
        ViewPagerTab(title: "Milk", image: UIImage(named: "milk")),
        ViewPagerTab(title: "Water", image: UIImage(named: "water"))
    ]
    
    var tabs: [ViewPagerTab] = [
        ViewPagerTab(title: "Fries", image: UIImage(named: "fries")),
        ViewPagerTab(title: "Hamburger", image: UIImage(named: "hamburger")),
        ViewPagerTab(title: "Beer", image: UIImage(named: "pint")),
        ViewPagerTab(title: "Pizza", image: UIImage(named: "pizza")),
        ViewPagerTab(title: "Orange", image: UIImage(named: "orange")),
        ViewPagerTab(title: "Sandwich", image: UIImage(named: "sandwich"))
    ]
    
    var tabItems = [
        ViewPagerTab(title: "每日推荐"),
        ViewPagerTab(title: "常用碑帖"),
        ViewPagerTab(title: "课程讲义"),
        ViewPagerTab(title: "书法视界"),
        ViewPagerTab(title: "文房雅趣"),
        ViewPagerTab(title: "名家名作")
    ]
    
    //MARK: -itemControllers
    let dailyViewController = ServiceLocator.sharedInstance.provideDailyViewController() as! UIViewController
    let copyBookViewController = ServiceLocator.sharedInstance.provideCopyBookViewController() as! UIViewController
    let lectureViewController = ServiceLocator.sharedInstance.provideLectureViewController() as! UIViewController
    let sightViewController = ServiceLocator.sharedInstance.provideSightViewController() as! UIViewController
    let famousViewController = ServiceLocator.sharedInstance.provideFamousViewController() as! UIViewController
    let studyViewController = ServiceLocator.sharedInstance.provideStudyViewController() as! UIViewController
    
    var itemControllers = NSMutableArray()
    
    
    var viewPager:ViewPagerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //将item加入到数组中
        itemControllers.add(dailyViewController)
        itemControllers.add(copyBookViewController)
        itemControllers.add(lectureViewController)
        itemControllers.add(sightViewController)
        itemControllers.add(famousViewController)
        itemControllers.add(studyViewController)
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        //设置导航栏文字
        self.title = "主页"
        
        let options = ViewPagerOptions(viewPagerWithFrame: self.view.bounds)
        //带图标
//        options.tabType = ViewPagerTabType.imageWithText
//        options.tabViewImageSize = CGSize(width: 20, height: 20)
        options.tabType = ViewPagerTabType.basic
        options.tabViewTextFont = UIFont.systemFont(ofSize: 14)
        //太小会导致整个Item布局被缩短:默认50
        options.tabViewHeight = 35
        options.tabViewPaddingLeft = 20
        options.tabViewPaddingRight = 20
        options.isTabHighlightAvailable = true
        options.tabViewTextDefaultColor = UIColor.cellTextColorDarkGray
        //设置指示器颜色
//        options.tabViewBackgroundDefaultColor
        options.tabViewBackgroundHighlightColor = UIColor.tabIndicatorViewBackgroundColor1
        options.tabIndicatorViewBackgroundColor = UIColor.white
        
        
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        //设置全局背景色
        viewPager.view.backgroundColor = UIColor.pageBackgroundColorGray
        //设置导航栏背景色
//        configureNavigationBar()
        //
        configTabbarStyle()
        //解决状态栏遮挡
//        viewPager.view.top = 21
        self.addChildViewController(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParentViewController: self)
        
        //测试看下一次进入时是否记录token
//        debugPrint("token = \(UserDefaults.standard.object(forKey: "access_token"))")
//        SVProgressHUD.show(withStatus: UserDefaults.standard.object(forKey: "access_token") as! String!)
        
        appDelegate.allowRotation = 1
    }
    
//    override var shouldAutorotate: Bool {
//        return true
//    }
    
    private func configureNavigationBar() {
        
        navigationController?.navigationBar.backgroundColor = UIColor.tabIndicatorViewBackgroundColor1
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    private func configTabbarStyle(){
        let tabbarItem1 = tabBarItem as! CBMaterialTabbarItem
        tabbarItem1.rippleLayerColor = UIColor.Tabbar1Color

        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //搜索按钮响应
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        //
    }
    
    //准备跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //处理导航栏情况
        if let destination = segue.destination as? SearchViewController {
            destination.modalPresentationStyle = .popover
//            destination.modalTransitionStyle = .coverVertical
        }
    }
    
}

