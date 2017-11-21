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
        
        settingPassView = SettingPassView(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-300-NavigationBarHeight-TabbarHeight)/2, width: 300, height: 300))
        self.view.addSubview(settingPassView!)
    }
    
    func initEvent(){
        settingPassView?.settingPassViewDelegate = self
    }
    
}
extension SettingPassViewController: SettingPassViewDelegate{
    //确认注册
    func nextAction(pwd: String, confirmpwd: String) {
        print("确认注册")
        //判断两次输入密码是否一致
        if pwd == confirmpwd {
            let mob = self.mob
            //提交信息到服务端: mob/pwd
            submitRegitser(mob: mob, pwd: pwd, finished: { (isSuccess) in
                if isSuccess {
                    //跳转到登录页
                    self.modalTransitionStyle = .crossDissolve
                    //连续返回两级
                    let index = self.navigationController?.viewControllers.index(of: self)
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[index!-2])!, animated: true)
                }
            })
        }else{
            SVProgressHUD.showError(withStatus: "两次输入密码不一致,请重新输入")
        }
        
    }
}
