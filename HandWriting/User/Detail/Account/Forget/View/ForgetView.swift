//
//  ForgetView.swift
//  HandWriting
//
//  Created by mac on 17/9/15.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

protocol ForgetViewDelegate {
    
    func loginAction(name: String, code: String)
    
    func codeAction(name: String)
    
    func closeAction()
}

class ForgetView: UIView {
    
    var loginDelegate: ForgetViewDelegate?
    
    let LoginText = "找回密码"
    let NextText = "下一步"
    let CodeText = "获取验证码"
    
    var leftView: UIView?
    var bgView: UIView?
    
    var login: UIButton?
    var close: UIButton?
    var code: UIButton?
    
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
        userName?.placeholder = "手机号码"
        userName?.font = UIFont.boldSystemFont(ofSize: 14)
        userName?.textColor = UIColor.cellTextColorDarkGray
        userName?.delegate = self
        
        password = JVFloatLabeledTextField()
        password?.width = (userName?.width)!/2
        password?.height = 35
        password?.left = (titleLabel?.left)!
        password?.top = (userName?.bottom)! + 25
        password?.placeholder = "验证码"
        password?.font = UIFont.boldSystemFont(ofSize: 14)
        password?.textColor = UIColor.cellTextColorDarkGray
        //        password?.isSecureTextEntry = true
        password?.delegate = self
        
        code = UIButton()
        code?.width = (userName?.width)!/2
        code?.height = 35
        code?.left = (password?.right)!-6
        code?.top = (userName?.bottom)! + 25
        code?.setTitle(CodeText, for: .normal)
        code?.setTitleColor(UIColor.white, for: .normal)
        code?.setTitleColor(UIColor.cellTextColorDarkGray, for: .highlighted)
        code?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        code?.backgroundColor = UIColor.loginViewThemeColor
        //点击事件
        code?.addTarget(self, action: #selector(ForgetView.codeAction), for: .touchUpInside)
        
        login = UIButton()
        login?.width = 150
        login?.height = 35
        login?.left = (titleLabel?.left)! + 15
        login?.top = (password?.bottom)! + 35
        login?.setTitle(NextText, for: .normal)
        login?.setTitleColor(UIColor.white, for: .normal)
        login?.setTitleColor(UIColor.cellTextColorDarkGray, for: .highlighted)
        login?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        login?.backgroundColor = UIColor.loginViewThemeColor
        //圆角背景
        login?.layer.cornerRadius = 5
        //点击事件
        login?.addTarget(self, action: #selector(ForgetView.loginAction), for: .touchUpInside)
        
        close = UIButton()
        close?.width = 60
        close?.height = 60
        close?.left = ((bgView?.width)! - (close?.width)!)/2
        close?.top = (bgView?.top)! - 20
        close?.setImage(UIImage.init(named: "chahao"), for: .normal)
        close?.backgroundColor = UIColor.gray
        //圆形背景
        close?.layer.masksToBounds = true
        close?.layer.cornerRadius = (close?.width)!/2
        //阴影效果
        
        //点击事件
        close?.addTarget(self, action: #selector(ForgetView.closeAction), for: .touchUpInside)
        
        bgView?.addSubview(leftView!)
        bgView?.addSubview(titleLabel!)
        bgView?.addSubview(userName!)
        bgView?.addSubview(password!)
        bgView?.addSubview(code!)
        bgView?.addSubview(login!)
        //        bgView?.addSubview(close!)
        
        self.addSubview(bgView!)
    }
    
    func codeAction(){
        loginDelegate?.codeAction(name: (userName?.text)!)
    }
    
    func loginAction(){
        loginDelegate?.loginAction(name: (userName?.text)!, code: (password?.text)!)
    }
    
    func closeAction(){
        loginDelegate?.closeAction()
    }
}
extension ForgetView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        return true
    }
}
