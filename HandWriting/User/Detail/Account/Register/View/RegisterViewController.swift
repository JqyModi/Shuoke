//
//  RegisterViewController.swift
//  HandWriting
//
//  Created by mac on 17/9/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterViewController: UIViewController {

//    var registerView: RegisterView?
    var registerView: RegisterViewWithMob?
    let zoneStr = "86"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.loginViewBGColor
        initView()
        // Do any additional setup after loading the view.
        
        initEvent()
        //改变导航按钮着色
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        
//        registerView = RegisterView(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-300)/2, width: 300, height: 300))
//        self.view.addSubview(registerView!)
        
        registerView = RegisterViewWithMob(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-300 - TabbarHeight - NavigationBarHeight)/2, width: 300, height: 300))
        registerView?.userName?.text = testPhone
        self.view.addSubview(registerView!)
        
    }
    
    func initEvent(){
        registerView?.loginDelegate = self
    }
}

extension RegisterViewController: RegisterViewWithMobDelegate{
    func codeAction(name: String) {
        //请求短信验证码
        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: name, zone: zoneStr, result:{(error) in
            if (!(error != nil)){
                // 请求成功
                SVProgressHUD.showSuccess(withStatus: "验证码发送成功，请注意查收")
                self.registerView?.code?.setTitle("已发送", for: .normal)
                self.registerView?.code?.setTitleColor(UIColor.SendCodeTextColor, for: .normal)
                self.registerView?.code?.backgroundColor = UIColor.SendCodeBGColor
            }else{
                // error
                SVProgressHUD.showSuccess(withStatus: "验证码发送失败")
            }
        })
    }
    func loginAction(name: String, code: String) {
        //提交短信验证码
        SMSSDK.commitVerificationCode(code, phoneNumber: name, zone: zoneStr, result: {(error) in
            if (!(error != nil)){
                // 验证成功
                SVProgressHUD.showSuccess(withStatus: "验证成功,下一步设置密码")
                //验证成功跳转到设置密码界面
                let settingPwdVc = SettingPassViewController()
                settingPwdVc.mob = name
                
                self.modalTransitionStyle = .crossDissolve
                settingPwdVc.title = "设置密码"
                
                settingPwdVc.forgetOrRegister = "reg"
                self.navigationController?.push(viewController: settingPwdVc, animated: true)
                
            }else{
                // error
                SVProgressHUD.showSuccess(withStatus: "验证失败")
            }
        })
    }
    
    func closeAction(){
        self.dismiss(animated: true, completion: {
            
        })
    }
}
