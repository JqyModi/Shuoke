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
        
        //
        handleEvent()
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
        }
        
        if tabBarController != nil {
            tabbarHeight = (self.tabBarController?.tabBar.height)!
        }
    
        loginView = LoginView(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-300-NavigationBarHeight-TabbarHeight)/2, width: 300, height: 300))
        loginView?.loginDelegate = self
        self.view.addSubview(loginView!)
        
        //测试登录
        loginView?.userName?.text = testMob
        loginView?.password?.text = testPassword
    }

    @objc private func keyBoardDidChangeFrame(notification: Notification) {
        
//        "[AnyHashable(\"UIKeyboardCenterBeginUserInfoKey\"): NSPoint: {187.5, 796}, AnyHashable(\"UIKeyboardIsLocalUserInfoKey\"): 1, AnyHashable(\"UIKeyboardCenterEndUserInfoKey\"): NSPoint: {187.5, 538}, AnyHashable(\"UIKeyboardBoundsUserInfoKey\"): NSRect: {{0, 0}, {375, 258}}, AnyHashable(\"UIKeyboardFrameEndUserInfoKey\"): NSRect: {{0, 409}, {375, 258}}, AnyHashable(\"UIKeyboardAnimationCurveUserInfoKey\"): 7, AnyHashable(\"UIKeyboardFrameBeginUserInfoKey\"): NSRect: {{0, 667}, {375, 258}}, AnyHashable(\"UIKeyboardAnimationDurationUserInfoKey\"): 0.25]"
        
        debugPrint("func --> \(#function) : line --> \(#line)")
        
        //以键值方式获取通知中键盘信息
        let keyBoardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        //计算键盘弹出后View的Y值
        let keyBY = keyBoardFrame.minY
        let loginY = loginView?.frame.maxY
        //判断键盘是否覆盖
        var y: CGFloat = 0
        if loginY! > keyBY {
            debugPrint("遮挡状态")
            y = (loginView?.frame.maxY)! - keyBoardFrame.minY
            //通过动画方式改变改变loginView的Y值
            UIView.animate(withDuration: 0.6) {
                //            self.loginView?.transform = CGAffineTransform(translationX: 0, y: -y1)
                self.loginView?.frame = CGRect(x: (SCREEN_WIDTH-300)/2, y: y, width: 300, height: 300)
            }
        }else {
            debugPrint("不遮挡状态")
            y = (SCREEN_HEIGHT-300-NavigationBarHeight-TabbarHeight)/2
            UIView.animate(withDuration: 0.6) {
                //            self.loginView?.transform = CGAffineTransform(translationX: 0, y: -y1)
                self.loginView?.frame = CGRect(x: (SCREEN_WIDTH-300)/2, y: y, width: 300, height: 300)
            }
        }
        debugPrint("y = \(y)")
    }
    
    private func handleEvent() {
        //注册一个键盘改变通知
        let center = NotificationCenter.default
        //监听所有键盘改变事件：object: nil
        center.addObserver(self, selector: #selector(LoginViewController.keyBoardDidChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        
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
//                    self.navigationController?.popToRootViewController(animated: true)
                    //跳转到主页 ：这句不一定对，大意是这个：
                    let delegate = UIApplication.shared.delegate as? AppDelegate
                    delegate?.installRootViewControllerIntoWindow((delegate?.window)!)
                }else {
                    debugPrint("func --> \(#function) : line --> \(#line)")
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

