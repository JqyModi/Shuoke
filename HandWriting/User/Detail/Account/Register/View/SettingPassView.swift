//
//  SettingPassView.swift
//  HandWriting
//
//  Created by mac on 17/9/15.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

protocol SettingPassViewDelegate {
    
    func nextAction(pwd: String, confirmpwd: String, forgetOrRegister: String)
    
    //    func closeAction()
}
class SettingPassView: UIView {
    
    var settingPassViewDelegate: SettingPassViewDelegate?
    
    let SettingPassText = "设置密码"
    let NextText = "确定"
    
    var leftView: UIView?
    var bgView: UIView?
    
    var nextBtn: UIButton?
    var close: UIButton?
    
    var titleLabel: UILabel?
    
    var forgetOrRegister: String = "reg"
    
    //导入一个第三方库来实现安卓中的点击输入框提示文字上浮效果
    var userName: JVFloatLabeledTextField?
    var password: JVFloatLabeledTextField?
    var confirmPassword: JVFloatLabeledTextField?
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
        titleLabel?.top = (leftView?.top)! + (leftView?.height)!
        titleLabel?.text = SettingPassText
        titleLabel?.textColor = UIColor.cellTextColorDarkGray
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        userName = JVFloatLabeledTextField()
        userName?.width = 200
        userName?.height = 35
        userName?.left = (titleLabel?.left)!
        userName?.top = (titleLabel?.bottom)! + 20
        userName?.placeholder = "密码"
        userName?.font = UIFont.boldSystemFont(ofSize: 14)
        userName?.textColor = UIColor.cellTextColorDarkGray
        userName?.isSecureTextEntry = true
        
        password = JVFloatLabeledTextField()
        password?.width = 200
        password?.height = 35
        password?.left = (titleLabel?.left)!
        password?.top = (userName?.bottom)! + 20
        password?.placeholder = "确认密码"
        password?.font = UIFont.boldSystemFont(ofSize: 14)
        password?.textColor = UIColor.cellTextColorDarkGray
        password?.isSecureTextEntry = true
        
//        confirmPassword = JVFloatLabeledTextField()
//        confirmPassword?.width = 200
//        confirmPassword?.height = 35
//        confirmPassword?.left = (titleLabel?.left)!
//        confirmPassword?.top = (password?.bottom)! + 20
//        confirmPassword?.placeholder = "确认密码"
//        confirmPassword?.font = UIFont.boldSystemFont(ofSize: 14)
//        confirmPassword?.textColor = UIColor.cellTextColorDarkGray
//        confirmPassword?.isSecureTextEntry = true
        
        nextBtn = UIButton()
        nextBtn?.width = 150
        nextBtn?.height = 35
        nextBtn?.left = (titleLabel?.left)! + 15
        nextBtn?.top = (password?.bottom)! + 30
        nextBtn?.setTitle(NextText, for: .normal)
        nextBtn?.setTitleColor(UIColor.white, for: .normal)
        nextBtn?.setTitleColor(UIColor.cellTextColorDarkGray, for: .highlighted)
        nextBtn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextBtn?.backgroundColor = UIColor.loginViewThemeColor
        //圆角背景
        nextBtn?.layer.cornerRadius = 5
        //点击事件
        nextBtn?.addTarget(self, action: #selector(SettingPassView.nextAction), for: .touchUpInside)
        
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
        close?.addTarget(self, action: #selector(SettingPassView.closeAction), for: .touchUpInside)
        
        
        bgView?.addSubview(leftView!)
        bgView?.addSubview(titleLabel!)
        bgView?.addSubview(userName!)
        bgView?.addSubview(password!)
//        bgView?.addSubview(confirmPassword!)
        bgView?.addSubview(nextBtn!)
        //        bgView?.addSubview(close!)
        
        self.addSubview(bgView!)
    }
    
    func nextAction(){
        settingPassViewDelegate?.nextAction(pwd: (userName?.text)!, confirmpwd: (password?.text)!, forgetOrRegister: self.forgetOrRegister)
    }
    
    func closeAction(){
        //        updatePassDelegate?.closeAction()
    }
}
