//
//  UserServece.swift
//  HandWriting
//
//  Created by mac on 17/9/8.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

class UserServece {
    static func checkLogin() -> Bool {
        let token = UserDefaults.standard.object(forKey: accessToken) as! String
        if token != "" && token.characters.count > 0 {
            return true
        }
        return false
    }
    
    static func checkUserName(name: String) -> Bool {
        if !name.isEmpty {
            return true
        }
        return false
    }
    
    static func checkPassword(password: String) -> Bool {
        if !password.isEmpty {
            return true
        }
        return false
    }
    
    static func saveWithFile() {
        // 1、获得沙盒的根路径
        let home = NSHomeDirectory() as NSString;
        // 2、获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
        let docPath = home.appendingPathComponent("Documents") as NSString;
        // 3、获取文本文件路径
        let filePath = docPath.appendingPathComponent("data.plist");
        let dataSource = NSMutableArray();
        dataSource.add("衣带渐宽终不悔")
        // 4、将数据写入文件中
        dataSource.write(toFile: filePath, atomically: true);
    }
    static func readWithFile() {
        var loginUser: LoginUser?
        /// 1、获得沙盒的根路径
        let home = NSHomeDirectory() as NSString;
        /// 2、获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
        let docPath = home.appendingPathComponent("Documents") as NSString;
        /// 3、获取文本文件路径
        let filePath = docPath.appendingPathComponent("data.plist");
        let dataSource = NSArray(contentsOfFile: filePath);
        print(dataSource)
    }
    
    /**
     归档数据
     需要实现NSCoding协议
     */
    static func saveWithNSKeyedArchiver(obj1: Any?) {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuser.data");
        let obj = obj1
        /**
         *  数据归档处理
         */
        NSKeyedArchiver.archiveRootObject(obj!, toFile: filePath);
    }

    /**
     反归档数据
     */
    static func readWithNSKeyedUnarchiver() -> Any? {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuser.data");
        //判断文件是否存在
        var obj: NSObject?
        let isFileExist = checkFileExist(fileName: filePath)
        if isFileExist {
            obj = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSObject;
            print(obj?.description)
        }
        return obj
    }
    
    /**
     归档数据
     需要实现NSCoding协议
     */
    static func saveImgWithNSKeyedArchiver(img: UIImage) {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuserImg.data");
        /**
         *  数据归档处理
         */
        NSKeyedArchiver.archiveRootObject(img, toFile: filePath);
    }
    
    /**
     反归档数据
     */
    static func readImgWithNSKeyedUnarchiver() -> UIImage {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuserImg.data");
        //判断文件是否存在
        var obj: UIImage?
        let isFileExist = checkFileExist(fileName: filePath)
        if isFileExist {
            obj = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UIImage;
        }
        return obj!
    }
    
    static func checkFileExist(fileName: String) -> Bool{
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: fileName)
    }
    
    
//    static func dataURL2Image(imgSrc: String) -> UIImage{
//        NSURL *url = [NSURL URLWithString: imgSrc];
//        NSData *data = [NSData dataWithContentsOfURL: url];
//        UIImage *image = [UIImage imageWithData: data];
//        
//        return image;
//    }
    
    static func imageHasAlpha(image: UIImage) -> Bool{
        var alpha = image.cgImage!.alphaInfo
        return (alpha == CGImageAlphaInfo.first ||
            alpha == CGImageAlphaInfo.last ||
            alpha == CGImageAlphaInfo.premultipliedFirst ||
            alpha == CGImageAlphaInfo.premultipliedLast)
    }
    static func image2DataURL(image: UIImage) -> String {
        var imageData: NSData? = nil;
        var mimeType: NSString? = nil;
        
        if (self.imageHasAlpha(image: image)) {
            imageData = UIImagePNGRepresentation(image) as NSData?;
            mimeType = "image/png";
        } else {
            imageData = UIImageJPEGRepresentation(image, 1.0) as NSData?;
            mimeType = "image/jpeg";
        }
        //前缀：data:image/jpeg;base64,...
        //imgstr = image/jpeg
        return "data:\(mimeType!);base64,"+(imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
    
    }
    
    /*
    static func fileSizeOfCache()-> Int {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            // 把文件名拼接到路径中
            let path = (cachePath! as NSString).appending("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        let mm = size / 1024 / 1024
        return mm
    }
    static func clearCache() -> Bool {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                    return true
                } catch {
                    return false
                }
            }
        }
        return false
    }
    */
    //计算缓存大小
    
    static func caculateCache() ->String {
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first
        let fileManager = FileManager.default
        print("cache＝ \(basePath)")
        
        
        var total:Float = 0
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            if childrenPath != nil{
                for path in childrenPath!{
                    let childPath = basePath?.appending("/").appending(path)
                    do{
                        let attr = try fileManager.attributesOfItem(atPath: childPath!)
                        let key = FileAttributeKey.init("NSFileSize")
                        let fileSize = attr[key]as! Float
                        total += fileSize
                        
                    }catch{
                        
                    }
                }
            }
        }
        
//        let cacheSize = NSString(format: "%.1f MB缓存", total / 1024.0 / 1024.0 )as String
        let cacheSize = NSString(format: "%.1f", total / 1024.0 / 1024.0 )as String
        return cacheSize
    }
    
    //清除缓存
    static func clearCache() ->Bool{
        var result = false
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first
        print("cache＝ \(basePath)")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            for childPathin in childrenPath!{
                //过滤登录信息缓存路径
                if childPathin != "loginuser.data"{
                    let cachePath = basePath?.appending("/").appending(childPathin)
                    do{
                        try fileManager.removeItem(atPath: cachePath!)
                    }catch{
                        //                    result = false
                    }
                }
            }
        }
        if NumberFormatter().number(from: caculateCache())?.floatValue == 0 {
            result = true
        }
        
        return result
    }
    
}

/*
 //（1）获取变量
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 
 //（2）在viewDidLoad中修改blockRotation变量值
 override func viewDidLoad() {
 super.viewDidLoad()
 appDelegate.blockRotation = true
 }
 
 //（3）viewWillAppear 设置页面横屏
 override func viewWillAppear(animated: Bool) {
 let value = UIInterfaceOrientation.LandscapeLeft.rawValue
 UIDevice.currentDevice().setValue(value, forKey: "orientation")
 }
 
 //（4）viewWillDisappear设置页面转回竖屏
 override func viewWillDisappear(animated: Bool) {
 appDelegate.blockRotation = false
 let value = UIInterfaceOrientation.Portrait.rawValue
 UIDevice.currentDevice().setValue(value, forKey: "orientation")
 }
 
 //（5）横屏页面是否支持旋转
 // 是否支持自动横屏。看项目可调，可以设置为true
 override func shouldAutorotate() -> Bool {
 return false
 }
 */



