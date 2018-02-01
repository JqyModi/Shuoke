//
//  UserHeaderView.swift
//  HandWriting
//
//  Created by mac on 2018/2/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

protocol UserHeaderViewDelegate {
    func loginOrInfoTextDidClick()
    func updateProfileDidClick()
    func imgViewDidClick()
}

class UserHeaderView: UIView {
    
    var updateHeaderdelegate: UserHeaderViewDelegate?
    
    var loginUser: HeaderModel? {
        didSet {
            setupData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData() {
        loginBtn.setTitle(loginUser?.loginOrInfoText ?? "点击登录", for: .normal)
        leftBtn.setTitle(loginUser?.nick ?? "—", for: .normal)
        rightBtn.setTitle(loginUser?.school ?? "—", for: .normal)
        imgView.sd_setImage(with: URL(string: loginUser?.iconView ?? ""), placeholderImage: UIImage(named: "user_icon"))
    }
    
    private func setupUI() {
        addSubview(bgView)
        bgView.addSubview(updateProfile)
        bgView.addSubview(imgView)
        bgView.addSubview(loginBtn)
        bgView.addSubview(leftBtn)
        bgView.addSubview(middleView)
        bgView.addSubview(rightBtn)
        //子布局以一级父布局作为参照（0,0）
        bgView.insertSubview(bgBottomView, belowSubview: leftBtn)
        
        //MARK: - 布局控件
        
        bgView.left = 0
        bgView.top = 0
        bgView.width = self.width
        bgView.height = self.height
        
        //        bgView.bottom = SCREEN_HEIGHT/3
        //        bgView.right = SCREEN_WIDTH
        //        bgView.backgroundColor = UIColor.init(red: 0.5, green: 0.8, blue: 0.6, alpha: 1)
        
        updateProfile.left = bgView.left + 10
        updateProfile.top = bgView.top + 10
        updateProfile.width = 32
        updateProfile.height = 32
        
        imgView.centerX = bgView.centerX - 80/2
        imgView.centerY = bgView.centerY - 80/2 - 30
        imgView.width = 80
        imgView.height = 80
        
        loginBtn.centerX = 20
//        loginBtn.centerY = imgView.centerY + imgView.height/2  - 21/2 + 15
        loginBtn.top = imgView.bottom + 10
        loginBtn.width = bgView.width - 40
        loginBtn.height = 21
        
        loginBtn.imageView?.frame = CGRect(x: (loginBtn.frame.width) - 20, y: ((loginBtn.height)-20)/2, width: 20, height: 20)
        
        bgBottomView.left = bgView.left
        bgBottomView.top = bgView.bottom - 50
        bgBottomView.width = bgView.right
        bgBottomView.height = 50
        
        leftBtn.left = bgBottomView.left
        leftBtn.top = bgBottomView.top
        leftBtn.width = bgBottomView.width/2 - 1
        leftBtn.height = bgBottomView.height
        
        middleView.width = 2
        middleView.height = (leftBtn.height)
        middleView.left = (leftBtn.right)
        middleView.top = (leftBtn.top)
        
        rightBtn.left = bgBottomView.width/2 + 1
        rightBtn.top = bgBottomView.top
        rightBtn.width = bgBottomView.right/2
        rightBtn.height = bgBottomView.height
        
//        self.setNeedsDisplay()
        self.layoutIfNeeded()
        layoutSubviews()

        updateProfile.addTarget(self, action: #selector(UserHeaderView.updateProfileAction), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(UserHeaderView.loginBtnAction), for: .touchUpInside)
        //设置图片点击事件:先设置可以用户交互
        imgView.isUserInteractionEnabled = true
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(UserHeaderView.imgViewAction))
        imgView.addGestureRecognizer(tap)
    }



    //MARK: - 懒加载
    lazy private var updateProfile: UIButton = {
        let updateProfile = UIButton()
        updateProfile.setImage(UIImage(named: "updateProfile"), for: .normal)
        updateProfile.tag = 101
        updateProfile.sizeToFit()
        return updateProfile
    }()

    lazy private var imgView: UIImageView = {
        let imgView = UIImageView()
        //设置遮罩
        imgView.layer.masksToBounds = true
        //先遮罩再圆角
        imgView.layer.cornerRadius = 80/2
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.contentMode = .scaleAspectFill
        imgView.sizeToFit()
        imgView.image = UIImage(named: "user_icon")
        imgView.tag = 102
        return imgView
    }()

    lazy private var loginBtn: UIButton = {
        let loginBtn = UIButton()
        loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        loginBtn.contentMode = .center
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.setImage(UIImage(named: "cupcake"), for: .normal)
        loginBtn.tag = 103
        loginBtn.sizeToFit()
        return loginBtn
    }()

    lazy private var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.randomColor()
        bgView.sizeToFit()
        return bgView
    }()

    lazy private var bgBottomView: UIView = {
        let bgBottomView = UIView()
        bgBottomView.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
        bgBottomView.sizeToFit()
        return bgBottomView
    }()

    lazy private var leftBtn: UIButton = {
        let leftBtn = UIButton()
        leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        leftBtn.contentMode = .center
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.tag = 104
        leftBtn.sizeToFit()
        return leftBtn
    }()

    lazy private var middleView: UIView = {
        let middleView = UIView()
        middleView.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        middleView.sizeToFit()
        return middleView
    }()

    lazy private var rightBtn: UIButton = {
        let rightBtn = UIButton()
        rightBtn.contentMode = .center
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.backgroundColor = UIColor.clear
        rightBtn.tag = 105
        rightBtn.sizeToFit()
        return rightBtn
    }()

    
    @objc private func updateProfileAction(){
        debugPrint("修改资料")
        updateHeaderdelegate?.updateProfileDidClick()
    }
    @objc private func loginBtnAction(){
        updateHeaderdelegate?.loginOrInfoTextDidClick()
    }
    @objc private func imgViewAction(){
        updateHeaderdelegate?.imgViewDidClick()
    }
}

