//
//  SettingPassViewController.swift
//  HandWriting
//
//  Created by mac on 17/9/15.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SVProgressHUD

class SettingPassViewController: UIViewController {
    
    var settingPassView: SettingPassView?
    var mob: String = ""
    
    var forgetOrRegister: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.loginViewBGColor
        initView()
        // Do any additional setup after loading the view.
        
        initEvent()
        
        handleEvent()
        
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        
        settingPassView = SettingPassView(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-300-NavigationBarHeight-TabbarHeight)/2, width: 300, height: 300))
        settingPassView?.forgetOrRegister = self.forgetOrRegister
        debugPrint("settingPassView?.forgetOrRegister = \(settingPassView?.forgetOrRegister)")
        self.view.addSubview(settingPassView!)
    }
    
    func initEvent(){
        settingPassView?.settingPassViewDelegate = self
    }
    
    @objc private func keyBoardDidChangeFrame(notification: Notification) {
        
        //        "[AnyHashable(\"UIKeyboardCenterBeginUserInfoKey\"): NSPoint: {187.5, 796}, AnyHashable(\"UIKeyboardIsLocalUserInfoKey\"): 1, AnyHashable(\"UIKeyboardCenterEndUserInfoKey\"): NSPoint: {187.5, 538}, AnyHashable(\"UIKeyboardBoundsUserInfoKey\"): NSRect: {{0, 0}, {375, 258}}, AnyHashable(\"UIKeyboardFrameEndUserInfoKey\"): NSRect: {{0, 409}, {375, 258}}, AnyHashable(\"UIKeyboardAnimationCurveUserInfoKey\"): 7, AnyHashable(\"UIKeyboardFrameBeginUserInfoKey\"): NSRect: {{0, 667}, {375, 258}}, AnyHashable(\"UIKeyboardAnimationDurationUserInfoKey\"): 0.25]"
        
        debugPrint("func --> \(#function) : line --> \(#line)")
        
        //以键值方式获取通知中键盘信息
        let keyBoardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        //计算键盘弹出后View的Y值
        let keyBY = keyBoardFrame.minY
        let loginY = settingPassView?.frame.maxY
        //判断键盘是否覆盖
        var y: CGFloat = 0
        if loginY! > keyBY {
            debugPrint("遮挡状态")
            y = (settingPassView?.frame.maxY)! - keyBoardFrame.minY
            //通过动画方式改变改变loginView的Y值
            UIView.animate(withDuration: 0.6) {
                //            self.loginView?.transform = CGAffineTransform(translationX: 0, y: -y1)
                self.settingPassView?.frame = CGRect(x: (SCREEN_WIDTH-300)/2, y: y, width: 300, height: 300)
            }
        }else {
            debugPrint("不遮挡状态")
            y = (SCREEN_HEIGHT-300-NavigationBarHeight-TabbarHeight)/2
            UIView.animate(withDuration: 0.6) {
                //            self.loginView?.transform = CGAffineTransform(translationX: 0, y: -y1)
                self.settingPassView?.frame = CGRect(x: (SCREEN_WIDTH-300)/2, y: y, width: 300, height: 300)
            }
        }
        debugPrint("y = \(y)")
    }
    
    private func handleEvent() {
        //注册一个键盘改变通知
        let center = NotificationCenter.default
        //监听所有键盘改变事件：object: nil
        center.addObserver(self, selector: #selector(SettingPassViewController.keyBoardDidChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        
    }
    
}
extension SettingPassViewController: SettingPassViewDelegate{
    //确认注册
    func nextAction(pwd: String, confirmpwd: String, forgetOrRegister: String) {
        debugPrint("确认注册")
        //判断两次输入密码是否一致
        if pwd == confirmpwd {
            let mob = self.mob
            
            if forgetOrRegister == "reg" {
                //提交信息到服务端: mob/pwd
                submitRegitser(mob: mob, pwd: pwd, finished: { (isSuccess) in
                    if isSuccess {
                        debugPrint("注册提交")
                        //跳转到登录页
                        self.modalTransitionStyle = .crossDissolve
                        //连续返回两级
                        let index = self.navigationController?.viewControllers.index(of: self)
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[index!-2])!, animated: true)
                    }
                })
            }else {
                //提交信息到服务端: mob/pwd
                forgotPassword(mob: mob, pwd: pwd, finished: { (isSuccess) in
                    if isSuccess {
                        debugPrint("找回密码提交")
                        //跳转到登录页
                        self.modalTransitionStyle = .crossDissolve
                        //连续返回两级
                        let index = self.navigationController?.viewControllers.index(of: self)
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[index!-2])!, animated: true)
                    }
                })
            }
            
        }else{
            SVProgressHUD.showError(withStatus: "两次输入密码不一致,请重新输入")
        }
        
    }
}
