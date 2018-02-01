//
//  UserViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import CBMDTabbarController
import SVProgressHUD

protocol UserViewControllerDelegate {
    func showDetaiView(tag: Int)
}

class UserViewController: HandWritingViewController, BothamTableViewController, UserUI {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: BothamTableViewDataSource<User, UserTableViewCell>!
    var delegate: UITableViewDelegate!
    var showDetailDelegate: UserViewControllerDelegate?
    
    var imgView: UIImageView?
    
    var nick = "—"
    var school = "—"
    var loginOrInfoText = "点击登录?"
    
    var leftBtn: UIButton?
    var rightBtn: UIButton?
    var loginBtn: UIButton?
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        //去掉多余的表格线
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "UserTableView"
//        pullToRefreshHandler.addTo(scrollView: tableView)
        self.tableView.separatorStyle = .none
        //table底部被tabbar遮挡
//        tableView.bottom = SCREEN_HEIGHT - CGFloat(TabbarHeight)
        super.viewDidLoad()
        configTabbarStyle()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadCacheSize(_:)), name: NSNotification.Name(rawValue: "cacheSizeM"), object: nil)
    }
    
    func loadCacheSize(_ notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
//        rightBtn.setTitle("\(userInfo["cacheSize"] as? String)M", for: .normal)
//        rightBtn.backgroundColor = UIColor.loginViewBGColor
        debugPrint("缓存大笑：",userInfo["cacheSize"] as? String)
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        configHeaderView()
        //显示用户信息
        showUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configTheme()
        
        //显示用户信息
        showUserInfo()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        debugPrint("viewDidDisappear")
    }
    
    func configTheme(){
        //判断当前主题
        let name = UserDefaults.standard.object(forKey: THEME) as! String
        switch name {
        case "☀️":
            tableView?.backgroundColor = UIColor.TableBackgroundColor
            break;
        case "🌙":
            tableView?.backgroundColor = UIColor.tabBackgroundColor
            break;
        default:
            break;
        }
        //刷新界面
        self.tableView.reloadData()
    }
    
    func showUserInfo(){
        if UserServece.checkLogin() {
            //获取本地持久化信息
            if let loginUser = UserServece.readWithNSKeyedUnarchiver() as? LoginUser {
                self.showLoginTextWithUserInfo(loginUser: loginUser)
                debugPrint("userInfo = \(loginUser.addr)")
                //SVProgressHUD.show(withStatus: loginUser?.addr)
            }
        }else if (UserServece.readWithNSKeyedUnarchiver() as? LoginUser) != nil {
            var loginUser = UserServece.readWithNSKeyedUnarchiver() as? LoginUser
            //SVProgressHUD.show(withStatus: loginUser?.addr)
            
            var token = loginUser?.access_token
            if !(token?.isEmpty)! {
                //重新请求数据刷新: 自动登录
                autoLogin(token: token!, finished: { (user) in
                    token = user.access_token
                    loginUser = user
                    //设置token
                    if !(token?.isEmpty)! {
                        UserDefaults.standard.set(token, forKey: accessToken)
                        UserDefaults.standard.synchronize()
                        //将数据保存到沙盒中
                        UserServece.saveWithNSKeyedArchiver(obj1: loginUser)
                        //显示用户信息
                        self.showLoginTextWithUserInfo(loginUser: loginUser!)
                        
                    }
                })
            }
        }
    }
    
    func showLoginTextWithUserInfo(loginUser: LoginUser){
        if loginUser.nick != nil {
            self.nick = (loginUser.nick)!
        }
        if loginUser.school != nil {
            self.school = (loginUser.school)!
        }
        if loginUser.name != nil {
            self.loginOrInfoText = (loginUser.name)!
        }
        self.refreshData()
    }
    
    func refreshData(){
        self.leftBtn?.setTitle(self.nick, for: .normal)
        self.rightBtn?.setTitle(self.school, for: .normal)
        self.loginBtn?.setTitle(self.loginOrInfoText, for: .normal)
        //设置用户头像
        var avatar = UIImage()
        var avatarPath = ""
        do {
            if let path = UserDefaults.standard.object(forKey: Avatar) {
//                avatar = try UIImage(data: NSData(contentsOf: URL(string: BASEURL + (path as! String))!) as Data)!
                avatarPath = path as! String
            }else if let loginUser = UserServece.readWithNSKeyedUnarchiver() as? LoginUser {
                let path = loginUser.avatar
                avatarPath = path!
//                avatar = try UIImage(data: NSData(contentsOf: URL(string: BASEURL + path!)!) as Data)!
            }else{
                avatar = UIImage(named: "user_icon")!
            }
        } catch {
            debugPrint("异常")
        }
        
        avatarPath = BASEURL + avatarPath.dropFirst().description
        debugPrint("avatarPath = \(avatarPath)")
        self.imgView?.sd_setImage(with: URL(string: avatarPath), placeholderImage: UIImage(named: "user_icon"))
//        self.imgView?.image = avatar
    }
    
    func configHeaderView(){
        let bgView = UIView()
        bgView.top = 0
        bgView.width = UIScreen.main.bounds.width
        bgView.height = UIScreen.main.bounds.height/3
//        bgView.bottom = SCREEN_HEIGHT/3
        bgView.left = 0
//        bgView.right = SCREEN_WIDTH
//        bgView.backgroundColor = UIColor.init(red: 0.5, green: 0.8, blue: 0.6, alpha: 1)
        
        // CBMaterialTabbarItem / CBMDTabbarController

        let tabBarItem1 = self.tabBarItem as! CBMaterialTabbarItem
        let color = tabBarItem1.rippleLayerColor
        bgView.backgroundColor = color
        
        let updateProfile = UIButton()
        updateProfile.left = bgView.left + 10
        updateProfile.top = bgView.top + 10
        updateProfile.width = 32
        updateProfile.height = 32
        updateProfile.setImage(UIImage(named: "updateProfile"), for: .normal)
        updateProfile.tag = 101
        
        imgView = UIImageView()
        imgView!.centerX = bgView.centerX - 80/2
        imgView!.centerY = bgView.centerY - 80/2 - 30
        imgView!.width = 80
        imgView!.height = 80
        //设置遮罩
        imgView!.layer.masksToBounds = true
        //先遮罩再圆角
        imgView!.layer.cornerRadius = 80/2
        imgView!.layer.borderWidth = 2
        imgView!.layer.borderColor = UIColor.white.cgColor
        imgView!.contentMode = .scaleAspectFill
        
        imgView!.image = UIImage(named: "user_icon")
        imgView!.tag = 102
        
        
        loginBtn = UIButton()
        loginBtn?.centerX = 20
        loginBtn?.centerY = imgView!.centerY + imgView!.height/2  - 21/2 + 15
        loginBtn?.width = bgView.width - 40
        loginBtn?.height = 21
        loginBtn?.setTitle(loginOrInfoText, for: .normal)
        loginBtn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        loginBtn?.contentMode = .center
        loginBtn?.setTitleColor(UIColor.white, for: .normal)
        loginBtn?.setImage(UIImage(named: "cupcake"), for: .normal)
        loginBtn?.imageView?.frame = CGRect(x: (loginBtn?.frame.width)! - 20, y: ((loginBtn?.height)!-20)/2, width: 20, height: 20)
        loginBtn?.tag = 103
        
        bgView.addSubview(updateProfile)
        bgView.addSubview(imgView!)
        bgView.addSubview((loginBtn)!)
        
        let bgBottomView = UIView()
        bgBottomView.left = bgView.left
        bgBottomView.top = bgView.bottom - 50
        bgBottomView.width = bgView.right
        bgBottomView.height = 50
        bgBottomView.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
        
        leftBtn = UIButton()
        leftBtn?.left = bgBottomView.left
        leftBtn?.top = bgBottomView.top
        leftBtn?.width = bgBottomView.width/2 - 1
        leftBtn?.height = bgBottomView.height
        leftBtn?.setTitle(nick, for: .normal)
        leftBtn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        leftBtn?.contentMode = .center
        leftBtn?.setTitleColor(UIColor.white, for: .normal)
        leftBtn?.backgroundColor = UIColor.clear
        leftBtn?.tag = 104
        
        let middleView = UIView()
        middleView.width = 2
        middleView.height = (leftBtn?.height)!
        middleView.left = (leftBtn?.right)!
        middleView.top = (leftBtn?.top)!
        middleView.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        rightBtn = UIButton()
        rightBtn?.left = bgBottomView.width/2 + 1
        rightBtn?.top = bgBottomView.top
        rightBtn?.width = bgBottomView.right/2
        rightBtn?.height = bgBottomView.height
        rightBtn?.setTitle(school, for: .normal)
        rightBtn?.contentMode = .center
        rightBtn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        rightBtn?.setTitleColor(UIColor.white, for: .normal)
        rightBtn?.backgroundColor = UIColor.clear
        rightBtn?.tag = 105

        bgView.addSubview(leftBtn!)
        bgView.addSubview(middleView)
        bgView.addSubview(rightBtn!)
        //子布局以一级父布局作为参照（0,0）
        bgView.insertSubview(bgBottomView, belowSubview: leftBtn!)
        self.tableView.tableHeaderView = bgView
        
        updateProfile.addTarget(self, action: #selector(UserViewController.updateProfileAction), for: .touchUpInside)
        loginBtn?.addTarget(self, action: #selector(UserViewController.loginBtnAction), for: .touchUpInside)
        leftBtn?.addTarget(self, action: #selector(UserViewController.leftBtnAction), for: .touchUpInside)
        rightBtn?.addTarget(self, action: #selector(UserViewController.rightBtnAction), for: .touchUpInside)
        //设置图片点击事件:先设置可以用户交互
        imgView!.isUserInteractionEnabled = true
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(UserViewController.imgViewAction))
        imgView!.addGestureRecognizer(tap)
        
    }
    
    func updateProfileAction(){
        debugPrint("修改资料")
        self.showDetailDelegate?.showDetaiView(tag: 101)
    }
    func loginBtnAction(){
        self.showDetailDelegate?.showDetaiView(tag: 103)
//        self.showDetailViewController(LoginViewController(), sender: nil)
    }
    func leftBtnAction(){
        self.showDetailDelegate?.showDetaiView(tag: 104)
    }
    func rightBtnAction(){
        self.showDetailDelegate?.showDetaiView(tag: 105)
    }
    func imgViewAction(){
        self.showDetailDelegate?.showDetaiView(tag: 102)
    }
    
    private func configTabbarStyle(){
        let tabbarItem1 = tabBarItem as! CBMaterialTabbarItem
        tabbarItem1.rippleLayerColor = UIColor.Tabbar4Color
    }
}

extension UserViewController: UserWireframeDelegate{
    func getPhoto(img: UIImage) {
        //压缩图片
        self.imgView?.image = img
        //压缩头像
        let size = CGSize(width: 300, height: 300)
        let newImg = img.resizeImage(image: img, newSize: size)
        
        //持久化到本地：方便自动登录时获取头像
        UserServece.saveImgWithNSKeyedArchiver(img: newImg)
        
        //将图片转换成base64位上传服务器
        // 先获取图片的 data
        let data = UIImagePNGRepresentation(newImg)
        // 把 data 转成 Base64 的 string
        let imgStr = UserServece.image2DataURL(image: newImg)
//        debugPrint("imgstr = \(imgStr)")
        let token = UserDefaults.standard.object(forKey: accessToken) as! String
        //上传头像返回路径
        getUserAvatar(token: token, data: imgStr, finished: { (path) in
            //将头像路径持久化到本地
            debugPrint("path = \(path)")
            UserDefaults.standard.setValue(path, forKey: Avatar)
        })
        
    }
}
