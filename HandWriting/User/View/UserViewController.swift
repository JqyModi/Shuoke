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
        //设置用户头像
        var avatar = UIImage()
        var avatarPath = ""
        do {
            if let path = UserDefaults.standard.object(forKey: Avatar) as? String {
                avatarPath = path
            }else if let loginUser = UserServece.readWithNSKeyedUnarchiver() as? LoginUser {
                let path = loginUser.avatar
                avatarPath = path!
            }else{
                avatar = UIImage(named: "user_icon")!
            }
        } catch {
            debugPrint("异常")
        }
        avatarPath = BASEURL + avatarPath.dropFirst().description
        debugPrint("avatarPath = \(avatarPath)")
        //封装用户数据
        let headerModel = HeaderModel(nick: self.nick, school: self.school, loginOrInfoText: self.loginOrInfoText, iconView: avatarPath)
        if let headerView = self.tableView.tableHeaderView as? UserHeaderView {
            debugPrint("headerModel.iconView = \(headerModel.iconView)")
            headerView.loginUser = headerModel
        }
    }
    
    func configHeaderView() {
        let tabBarItem1 = self.tabBarItem as! CBMaterialTabbarItem
        let color = tabBarItem1.rippleLayerColor
        
        let headerView = UserHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/3))
        headerView.backgroundColor = color
        headerView.loginUser = HeaderModel(nick: self.nick, school: self.school, loginOrInfoText: self.loginOrInfoText, iconView: "")
        headerView.updateHeaderdelegate = self
        self.tableView.tableHeaderView = headerView
    }
    
    func updateProfileAction(){
        debugPrint("修改资料")
        self.showDetailDelegate?.showDetaiView(tag: 101)
    }
    func loginBtnAction(){
        self.showDetailDelegate?.showDetaiView(tag: 103)
    }
    func imgViewAction(){
        self.showDetailDelegate?.showDetaiView(tag: 102)
    }
    
    private func configTabbarStyle(){
        let tabbarItem1 = tabBarItem as! CBMaterialTabbarItem
        tabbarItem1.rippleLayerColor = UIColor.Tabbar4Color
    }
}

extension UserViewController: UserWireframeDelegate, UserHeaderViewDelegate {
    
    //MARK: - 相册获取头像并处理
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
            //保存数据
            UserDefaults.standard.synchronize()
            //刷新HeaderView数据
            self.refreshData()
        })
    }
    
    //MARK: - HeaderViewDelegate
    func loginOrInfoTextDidClick() {
        self.loginBtnAction()
    }
    
    func updateProfileDidClick() {
        self.updateProfileAction()
    }
    
    func imgViewDidClick() {
        self.imgViewAction()
    }
    
}
