//
//  PageImageViewController.swift
//  HandWriting
//
//  Created by mac on 2017/11/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class PageImageViewController: UIViewController {
    
    private struct Constants {
//        static let FontSize: CGFloat = 14
//        static let TabHeight: CGFloat = 35
//        static let TabPaddingLeft: CGFloat = 20
//        static let TabPaddingRight: CGFloat = 20
        static let FontSize: CGFloat = 0
        static let TabHeight: CGFloat = 0
        static let TabPaddingLeft: CGFloat = 0
        static let TabPaddingRight: CGFloat = 0
    }
    
    //View
    var viewPager:ViewPagerController? {
        didSet {
            let options = ViewPagerOptions(viewPagerWithFrame: self.view.bounds)
            //带图标
            //options.tabType = ViewPagerTabType.imageWithText
            //options.tabViewImageSize = CGSize(width: 20, height: 20)
            options.tabType = ViewPagerTabType.basic
            options.tabViewTextFont = UIFont.systemFont(ofSize: Constants.FontSize)
            //太小会导致整个Item布局被缩短:默认50
            options.tabViewHeight = Constants.TabHeight
            options.tabViewPaddingLeft = Constants.TabPaddingLeft
            options.tabViewPaddingRight = Constants.TabPaddingRight
            options.isTabHighlightAvailable = true
            options.tabViewTextDefaultColor = UIColor.cellTextColorDarkGray
            //设置指示器颜色
            //options.tabViewBackgroundDefaultColor
            options.tabViewBackgroundHighlightColor = UIColor.tabIndicatorViewBackgroundColor1
            options.tabIndicatorViewBackgroundColor = UIColor.white

            viewPager?.options = options
            viewPager?.dataSource = self
            viewPager?.delegate = self
            //设置全局背景色
            viewPager?.view.backgroundColor = UIColor.pageBackgroundColorGray
            //解决状态栏遮挡
            //viewPager.view.top = 21
        }
    }
    
    //Model
    var items: [CopyBookDetail]?
    
    var tabItems: [ViewPagerTab]?
    
    var selectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化ViewPager指示器按钮
        initTabItems()
        
        //初始化ViewPager
        viewPager = ViewPagerController()
        self.addChildViewController(viewPager!)
        self.view.addSubview(viewPager!.view)
        viewPager!.didMove(toParentViewController: self)
        self.view.backgroundColor = UIColor.black
    }

    func initTabItems() {
        tabItems = [ViewPagerTab]()
        for index in (0..<items!.count) {
            tabItems?.append(ViewPagerTab(title: ""))
        }
    }
}

extension PageImageViewController: ViewPagerControllerDataSource, ViewPagerControllerDelegate ,ImageViewControllerDelegate {
    
    func numberOfPages() -> Int {
        return tabItems!.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        let vc = ImageViewController()
        vc.delegate = self
        vc.imageURL = URL(string: (BASEURL + (items?[position].img_url)!))
        return vc
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabItems!
    }
    
    func startViewPagerAtIndex() -> Int {
        return self.selectIndex!
    }
    
    //Mark:- ImageViewControllerDelegate
    func tapImageView() {
        dismiss(animated: true, completion: nil)
    }
}

