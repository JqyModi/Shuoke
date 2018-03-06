//
//  LoginView.swift
//  HandWriting
//
//  Created by mac on 17/9/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    func registerAction()
    
    func loginAction(name: String, password: String)
    
    func forgetAction()
}

class LoginView: UIView {
    
    var loginDelegate: LoginViewDelegate?
    
    let LoginText = "登录"
    
    var leftView: UIView?
    var bgView: UIView?
    
    var login: UIButton?
    var register: UIButton?
    
    var titleLabel: UILabel?
    var forgetPassLabel: UILabel?
    
    //导入一个第三方库来实现安卓中的点击输入框提示文字上浮效果
    var userName: JVFloatLabeledTextField?
    var password: JVFloatLabeledTextField?
    //重写父类构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //
        self.intiView()
        
        //处理键盘弹出事件
//        handleEvent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func intiView(){
//        bookName?.placeholder = "书名"
//        bookEditor?.placeholder = "作者"
        backgroundColor = UIColor.white
        
        bgView = UIView()
        bgView?.width = 300
        bgView?.height = 300
        bgView?.left = (self.frame.size.width-300)/2
        bgView?.top = (self.frame.size.height-300)/2
        bgView?.backgroundColor = UIColor.white
        
        leftView = UIView()
        leftView?.width = 8
        leftView?.height = 35
        leftView?.left = 0
        leftView?.top = 5
        leftView?.backgroundColor = UIColor.loginViewThemeColor
        
        titleLabel = UILabel()
        titleLabel?.width = 300 - (leftView?.right)! + 50
        titleLabel?.height = 25
        titleLabel?.left = (leftView?.right)! + 50
        titleLabel?.top = (leftView?.top)! + (leftView?.height)!/2
        titleLabel?.text = LoginText
        titleLabel?.textColor = UIColor.cellTextColorDarkGray
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        userName = JVFloatLabeledTextField()
        userName?.width = 200
        userName?.height = 35
        userName?.left = (titleLabel?.left)!
        userName?.top = (titleLabel?.bottom)! + 25
        userName?.placeholder = "用户名"
        userName?.font = UIFont.boldSystemFont(ofSize: 14)
        userName?.textColor = UIColor.cellTextColorDarkGray
        userName?.delegate = self
        
        password = JVFloatLabeledTextField()
        password?.width = 200
        password?.height = 35
        password?.left = (titleLabel?.left)!
        password?.top = (userName?.bottom)! + 25
        password?.placeholder = "密码"
        password?.font = UIFont.boldSystemFont(ofSize: 14)
        userName?.textColor = UIColor.cellTextColorDarkGray
        password?.isSecureTextEntry = true
        //处理键盘弹出事件
        password?.delegate = self
        
        login = UIButton()
        login?.width = 150
        login?.height = 35
        login?.left = (titleLabel?.left)! + 15
        login?.top = (password?.bottom)! + 35
        login?.setTitle(LoginText, for: .normal)
        login?.setTitleColor(UIColor.white, for: .normal)
        login?.setTitleColor(UIColor.cellTextColorDarkGray, for: .highlighted)
        login?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        login?.backgroundColor = UIColor.loginViewThemeColor
        //圆角背景
        login?.layer.cornerRadius = 5
        //点击事件
        login?.addTarget(self, action: #selector(LoginView.loginAction), for: .touchUpInside)
        
        forgetPassLabel = UILabel()
        forgetPassLabel?.width = 75
        forgetPassLabel?.height = 21
        forgetPassLabel?.left = (login?.left)! + 50
        forgetPassLabel?.top = (login?.bottom)! + 15
        forgetPassLabel?.text = "忘记密码?"
        forgetPassLabel?.textColor = UIColor.cellTextColorDarkGray
        forgetPassLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //点击事件
        forgetPassLabel?.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginView.forgetAction))
        forgetPassLabel?.addGestureRecognizer(tap)
        
        register = UIButton()
        register?.width = 60
        register?.height = 60
        register?.left = (userName?.right)! + 5
        register?.top = (titleLabel?.top)!
        register?.setImage(UIImage.init(named: "jiahao_white"), for: .normal)
        register?.backgroundColor = UIColor.gray
        //圆形背景
        register?.layer.masksToBounds = true
        register?.layer.cornerRadius = (register?.width)!/2
        //阴影效果
        
        //点击事件
        register?.addTarget(self, action: #selector(LoginView.registerAction), for: .touchUpInside)
        
        bgView?.addSubview(leftView!)
        bgView?.addSubview(titleLabel!)
        bgView?.addSubview(userName!)
        bgView?.addSubview(password!)
        bgView?.addSubview(login!)
        bgView?.addSubview(forgetPassLabel!)
        bgView?.addSubview(register!)
        
        self.addSubview(bgView!)
    }
    
    func loginAction(){
        loginDelegate?.loginAction(name: (userName?.text)!, password: (password?.text)!)
    }
    
    func forgetAction(){
        loginDelegate?.forgetAction()
    }
    
    func registerAction(){
        loginDelegate?.registerAction()
    }
}
extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        return true
    }
}
