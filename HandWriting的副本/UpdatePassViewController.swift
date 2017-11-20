//
//  UpdatePassViewController.swift
//  HandWriting
//
//  Created by mac on 17/9/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SVProgressHUD

class UpdatePassViewController: UIViewController {
    
    var updatePassView: UpdatePassView?
    
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
        
        updatePassView = UpdatePassView(frame: CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-300-NavigationBarHeight-TabbarHeight)/2, width: 300, height: 300))
        self.view.addSubview(updatePassView!)
    }
    
    func initEvent(){
        updatePassView?.updatePassDelegate = self
    }
    
}
extension UpdatePassViewController: UpdatePassViewDelegate{
    //确认修改密码
    func nextAction(oldpwd: String, password: String) {
        print("确认修改")
        //获取本地持久化信息
        let loginUser = UserServece.readWithNSKeyedUnarchiver() as? LoginUser
        let token = loginUser?.access_token
        
        updatePassword(token: token!, oldpwd: oldpwd, newpwd: password, finished: { (isSuccess) in
            if isSuccess {
                //修改成功
                SVProgressHUD.showSuccess(withStatus: "密码修改成功,请重新登录")
                //跳转到登录页
                let loginVc = LoginViewController()
                loginVc.title = "登录"
                self.navigationController?.push(viewController: loginVc)
            }
        })
    }
}






