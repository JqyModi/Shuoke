//
//  HandWritingViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import Tabman
class HandWritingViewController: BothamViewController, BothamLoadingViewController, BothamPullToRefresh, VisitorLoginViewDelegate {
    
    let loadingView: UIView = {
        let loadingView = BothamLoadingView()
        loadingView.color = UIColor.loadingColor
        return loadingView
    }()
    
    var pullToRefreshHandler: BothamPullToRefreshHandler!
    
    var loadToRefreshHandler: BothamLoadToRefreshHandler!
    
//    open var presenter: BothamPresenter! = nil
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter.viewDidLoad()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        presenter.viewWillAppear()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        presenter.viewDidAppear()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        presenter.viewWillDisappear()
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        presenter.viewDidDisappear()
//    }
    
    //MARK: - 访客模式
    //添加用户是否登录标记
    var userLogin = UserServece.checkLogin()
    var visitorLoginView: VisitorLoginView?
    //loadVIew是苹果专门为手写代码 准备的  等效与 sb / xib
    //一旦实现这个方法  xib / sb就自动失效
    //会自动检测 view是否为空  如果为空 会自动调用 loadView方法
//    override func loadView() {
//        userLogin ? super.loadView() : loadVisitorView()
//    }
    
    override func viewWillLayoutSubviews() {
        userLogin ? super.viewWillLayoutSubviews() : loadVisitorView()
    }
    
    private func loadVisitorView() {
        //view的大小  在 viewDidLoad就会设置
        visitorLoginView = VisitorLoginView()
        //设置代理
        visitorLoginView?.visitorDelegate = self
        
        visitorLoginView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        
        view.addSubview(visitorLoginView!)
        
        title = "用户登录"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: "visitorWillRegister")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: "visitorWillLogin")
        
    }
    
    //MARK:visitorDelegate 协议方法
    func visitorWillRegister() {
        debugPrint("come on")
    }
    
    func visitorWillLogin() {
        debugPrint("come in")
        toLoginController()
    }
    
    /*
     跳转到登录页
     */
    func toLoginController(){
        let viewController = LoginViewController()
        debugPrint("跳转登录页")
        viewController.title = "登录"
        ServiceLocator.sharedInstance.provideUserNavigator()?.present(viewController, animated: true, completion: nil)
    }
}
