//
//  UserWireframe.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import SVProgressHUD
import SCLAlertView_Objective_C

protocol UserWireframeDelegate {
    func getPhoto(img: UIImage)
}
class UserWireframe: HandWritingWireframe, UIActionSheetDelegate {
    
    var viewController: UIViewController?
    var delegate: UserWireframeDelegate?
    
    //跳转到详情页
    func presentUserDetailViewController(item: User, tag: Int){
//        self.recieveNotify()
        
        //获取用户登录信息
        let isLogin = UserServece.checkLogin()
        
        switch item.name {
        case "账号管理":
            viewController = serviceLocator.provideAccountViewController(item: item)
            print("跳转详情页")
            serviceLocator.provideUserNavigator()?.push(viewController: viewController!)
            break
        case "修改密码":
            if isLogin {
                viewController = UpdatePassViewController()
                print("跳转详情页")
                viewController?.title = item.name
                serviceLocator.provideUserNavigator()?.push(viewController: viewController!)
            }else{
                toLoginController()
            }
            break
        case "修改资料":
            break
        case "浏览记录":
            if isLogin {
//                viewController = RecordViewController()
                viewController = serviceLocator.provideRecordViewController()
                
                print("跳转详情页")
                viewController?.title = "浏览记录"
                serviceLocator.provideUserNavigator()?.push(viewController: viewController!)
            }else{
                toLoginController()
            }
            break
        case "主题切换":
            viewController = ThemeViewController()
            print("跳转详情页")
            viewController?.title = "选择主题"
            serviceLocator.provideUserNavigator()?.push(viewController: viewController!)
            break
        case "下载列表":
            viewController = serviceLocator.provideDownloadViewController()
            print("跳转详情页")
            viewController?.title = "下载列表"
            serviceLocator.provideUserNavigator()?.push(viewController: viewController!)
            break
        case "清空缓存":
            viewController = serviceLocator.provideUserNavigator()!
            clearCacheAlertController(viewController: viewController!)
            break
        case "意见反馈":
            break
        case "分享好友":
            break
        case "关于":
            break
        case "切换账号":
            toLoginController()
            break
        case "退出":
            viewController = serviceLocator.provideUserNavigator()!
            let alert = SCLAlertView(newWindowWidth: SCREEN_WIDTH-50)
            alert?.addButton("退出", actionBlock: {
                self.exitApplication(viewController: self.viewController!)
            })
            alert?.showNotice("退出应用", subTitle: "您确定要退出吗？", closeButtonTitle: "取消", duration: TimeInterval(Int.max))
            break
        default:
            break
        }
        
        //判断用户是否登录
        
        switch tag {
        case 101:
            if isLogin {
                viewController = serviceLocator.provideAccountViewController(item: item)
                print("跳转详情页")
                let temp = viewController as! AccountViewController
                temp.isItemEnabled = true
                configNavigationBar(viewController: temp)
                serviceLocator.provideUserNavigator()?.push(viewController: temp)
            }else{
                toLoginController()
            }
            break
        case 102:
            print("点击头像回调")
            if isLogin {
                //跳转到photoPickerViewController
                let pv = photoPickerViewController()
                pv.delegate = self
                serviceLocator.provideUserNavigator()?.showDetailViewController(pv, sender: nil)
            }else{
                toLoginController()
            }
            break
        case 103:
            
            if isLogin {
                viewController = serviceLocator.provideAccountViewController(item: item)
                print("跳转详情页")
                let temp = viewController as! AccountViewController
                temp.isItemEnabled = false
                serviceLocator.provideUserNavigator()?.push(viewController: temp)
            }else{
                toLoginController()
            }
            
            break
        case 104:
            break
        case 105:
            break
        default:
            break
        }
        
        
    }
    /*
     跳转到登录页
     */
    func toLoginController(){
        viewController = LoginViewController()
        print("跳转登录页")
        viewController?.title = "登录"
        serviceLocator.provideUserNavigator()?.push(viewController: viewController!)
    }
    
    func configNavigationBar(viewController: AccountViewController) {
//        viewController.detailDelegate = self
        let rightButton = UIBarButtonItem(title: "确定", style: .plain, target: viewController.self, action: Selector(("rightAction")))
        viewController.navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    func recieveNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(UserWireframe.toAccount(_:)), name: NSNotification.Name(rawValue: NotifyToAccount), object: nil)
    }

    func toAccount(_ notification: NSNotification){
        viewController = serviceLocator.provideAccountViewController(item: User(icon: "", name: "用户信息"))
        print("跳转用户信息详情页")
        serviceLocator.provideUserNavigator()?.push(viewController: viewController!)
    }
    
    fileprivate func clearCacheAlertController(viewController: UIViewController) {
        let action = UIActionSheet(title: "确定清除所有缓存？", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "清除")
        action.show(in: viewController.view)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 0 {
            print("bottonIndex = \(buttonIndex)")
            if UserServece.clearCache() {
                SVProgressHUD.showSuccess(withStatus: "清除成功~")
                let sizeString = "0.00M"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSizeM"), object: nil, userInfo: ["cacheSize": sizeString])
            }else{
                SVProgressHUD.showError(withStatus: "清除失败")
            }
        }
    }
    
    
    func exitApplication(viewController: UIViewController) {
        //直接退，看起来好像是 crash 所以做个动画
        UIView.beginAnimations("exitApplication", context: nil)
        UIView.setAnimationDelay(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: (self.viewController?.view.window!)!, cache: false)
        UIView.setAnimationDidStop(#selector(animationFinished(animationID:finished:)))
        viewController.view.window?.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIView.commitAnimations()
    }
    
    func animationFinished(animationID: NSString,finished: NSNumber){
        if (animationID.compare("exitApplication") == ComparisonResult.orderedSame) {
            //退出代码
            exit(0);
        }
    }
    
    deinit {
        //移除self上所有通知
        NotificationCenter.default.removeObserver(self)
    }
}

extension UserWireframe: pickerPhotoDelegate, VPImageCropperDelegate{
    //实现委托方法获取图片
    func getPhoto(_ img: UIImage) {
        print("获取图片成功")
        //设置图片之前先将图片裁剪到合适的大小:利用第三方库实现图片的裁剪：VPImageCropperViewController
        //1.273通过封面的长款比例计算出来的:limitScaleRatio：缩放比例控制
        let cropper = VPImageCropperViewController(image: img, cropFrame: CGRect(x: 0,y: 100,width: SCREEN_WIDTH,height: SCREEN_WIDTH*1.273), limitScaleRatio: 3)
        //监听委托事件
        cropper?.delegate = self
        //跳转
        serviceLocator.provideUserNavigator()?.showDetailViewController(cropper!, sender: nil)
//        self.present(cropper!, animated: true) {
//            print("跳转到图片裁剪界面")
//        }
        
    }
    //图片裁剪事件回调
    func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        print("图片裁剪完成回调")
        cropperViewController.dismiss(animated: true) {
            //设置封面图片
            self.delegate?.getPhoto(img: editedImage)
        }
    }
    func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
        print("图片裁剪取消回调")
        cropperViewController.dismiss(animated: true) {
            print("取消裁剪")
        }
    }
}
