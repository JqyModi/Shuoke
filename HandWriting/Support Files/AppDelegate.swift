//
//  AppDelegate.swift
//  HandWriting
//
//  Created by mac on 17/8/18.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var blockRotation = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //1.取出已存的账号,判断是否过期，是否仍然正确之类
       let account = UserServece.checkLogin()
        if (account) {
            installRootViewControllerIntoWindow(window!)
        }else{//2.如果不存在，登陆
            let loginVC = LoginViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            loginVC.title = "用户登录"
            self.window?.rootViewController = nav
        }
        
//        installRootViewControllerIntoWindow(window!)
        configureWindow()
        configureNavigationBarStyle()
        
        //初始化用户信息
        configUserProfile()
        
        configMobSDK()
        
        configBugly()
        
        return true
    }

    func configMobSDK() {
        SMSSDK.init()
    }
    
    func configBugly() {
        Bugly.start(withAppId: AppID)
    }
    
    //不私有化 供登录界面跳转调用
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        RootWireframe().presentInitialViewController(inWindow: window)
    }
    
    private func configureWindow() {
        window?.backgroundColor = UIColor.windowBackgroundColor
    }
    
    private func configureNavigationBarStyle() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor.navigationBarColor
        navigationBarAppearance.tintColor = UIColor.navigationBarTitleColor
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.navigationBarTitleColor,
            NSFontAttributeName : UIFont.navigationBarTitleFont
        ]
    }
    
    private func configUserProfile(){
        //先设置一个空的token来初始化
        UserDefaults.standard.set("", forKey: accessToken)
        //设置默认主题
        UserDefaults.standard.set("☀️", forKey: THEME)
    }
    var allowRotation = 0
    //支持横竖屏切换
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        if self.blockRotation{
//            return UIInterfaceOrientationMask.all
//        } else {
//            return UIInterfaceOrientationMask.portrait
//        }
        if allowRotation == 1 {
            
            if !UIApplication.shared.statusBarOrientation.isPortrait {
                
                return UIInterfaceOrientationMask.portrait
            }else{
                return UIInterfaceOrientationMask.landscapeLeft
            }
            
        }else{
            
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HandWriting")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

