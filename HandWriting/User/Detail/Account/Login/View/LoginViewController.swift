//
//  LoginViewController.swift
//  HandWriting
//
//  Created by mac on 17/9/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

@objc protocol LoginViewControllerDelegate {
    @objc optional func notifyToAccount()
    @objc optional func loadLoginData(name: String, password: String)
}

class LoginViewController: UIViewController {

    var loginView: LoginView?
    
    var delegate: LoginViewControllerDelegate?
    
    var navigationBarHeight: CGFloat = 0
    var tabbarHeight: CGFloat = 0
    
    var firstLogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.loginViewBGColor
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        //改变导航按钮着色
        if (navigationController != nil) {
            self.navigationController?.navigationBar.tintColor = UIColor.white
            navigationBarHeight = (self.navigationController?.navigationBar.height)!
            tabbarHeight = (self.tabBarController?.tabBar.height)!
        }
    
        loginView = LoginView(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-300-navigationBarHeight-tabbarHeight)/2, width: 300, height: 300))
        loginView?.loginDelegate = self
        self.view.addSubview(loginView!)
        
        //测试登录
        loginView?.userName?.text = testMob
        loginView?.password?.text = testPassword
    }

}
extension LoginViewController: LoginViewDelegate{
    
    func loginAction(name: String, password: String) {
        debugPrint("登录")
        if UserServece.checkUserName(name: name) && UserServece.checkPassword(password: password) {
            //向服务器发起请求获取信息及token
            var token = ""
            var loginUser: LoginUser?
            login(mob: name, password: password, finished: { (user) in
                token = user.access_token!
                loginUser = user
                //设置token
                if !token.isEmpty {
                    UserDefaults.standard.set(token, forKey: accessToken)
                    UserDefaults.standard.synchronize()
                    //将数据保存到沙盒中
                    UserServece.saveWithNSKeyedArchiver(obj1: loginUser)
                    self.firstLogin = false
                    //跳转到用户信息界面
                    self.navigationController?.popToRootViewController(animated: true)
                    
                }
            })
            
        }
    }
    
    func forgetAction() {
        debugPrint("忘记密码")
        let forgetVc = ForgetViewController()
        self.modalTransitionStyle = .crossDissolve
        //        self.present(registerViewController, animated: false, completion: {
        //
        //        })
        //设置title方便导航栏显示左侧文字
        forgetVc.title = "找回密码"
        self.navigationController?.push(viewController: forgetVc, animated: true)
    }
    
    func registerAction() {
        debugPrint("注册")
        let registerViewController = RegisterViewController()
        self.modalTransitionStyle = .crossDissolve
//        self.present(registerViewController, animated: false, completion: {
//            
//        })
        //设置title方便导航栏显示左侧文字
        registerViewController.title = "注册"
        self.navigationController?.push(viewController: registerViewController, animated: true)
    }
    
}

