//
//  WritingStartViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/28.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import jot
import AssetsLibrary

class WritingStartViewController: UIViewController, JotViewControllerDelegate {
    var params: NSMutableDictionary?
    let ArticleKEY = "ArticleKEY"
    let TtfKEY = "TtfKEY"
    let SizeKEY = "SizeKEY"
    
    var jotViewController: JotViewController?
    
    var writingBack: WritingBackCustomView?
    
    var currentCount = 0
    var currentText = ""
    var articleStr: String = ""
    
    let kPencilImageName = "✏️"
    let kTextImageName = "A"
    let kClearImageName = "✖️"
    let kSaveImageName = "✔️"
    
    let kPreImageName = "⬅️"
    let kNextImageName = "➡️"
    let preName = "上一个"
    let nextName = "下一个"
    
    var articleName = "sanzijing"
    var fontFamily = "FontAwesome"
    var fontSize = "适中"
    
    var saveButton: UIButton?
    var clearButton: UIButton?
    var toggleDrawingButton: UIButton?
    var preButton: UIButton?
    var nextButton: UIButton?
    
    init(data: NSMutableDictionary) {
        self.params = data
        super.init(nibName: nil, bundle: nil)
        if (self.params?.count)! > 0 {
            articleName = params?.value(forKey: ArticleKEY) as! String
            fontFamily = params?.value(forKey: TtfKEY) as! String
            fontSize = params?.value(forKey: SizeKEY) as! String
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        jotViewController = JotViewController()
        
        self.jotViewController?.delegate = self;
        jotViewController?.state = .drawing
        self.configFontStyle(jotViewController: jotViewController!)
        
        saveButton = UIButton()
        self.saveButton?.titleLabel?.font = UIFont(name: "FontAwesome", size: 24)
        self.saveButton?.setTitleColor(UIColor.darkGray, for: .normal)
        self.saveButton?.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.saveButton?.setTitle(kSaveImageName, for: .normal)
        self.saveButton?.addTarget(self, action: Selector("saveButtonAction"), for: .touchUpInside)
        
        clearButton = UIButton()
        self.clearButton?.titleLabel?.font = UIFont(name: "FontAwesome", size: 24)
        self.clearButton?.setTitleColor(UIColor.darkGray, for: .normal)
        self.clearButton?.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.clearButton?.setTitle(kClearImageName, for: .normal)
        self.clearButton?.addTarget(self, action: Selector("clearButtonAction"), for: .touchUpInside)
        
        toggleDrawingButton = UIButton()
        self.toggleDrawingButton?.titleLabel?.font = UIFont(name: "FontAwesome", size: 24)
        self.toggleDrawingButton?.setTitleColor(UIColor.darkGray, for: .normal)
        self.toggleDrawingButton?.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.toggleDrawingButton?.setTitle(kTextImageName, for: .normal)
//        self.toggleDrawingButton?.backgroundColor = UIColor.green
        self.toggleDrawingButton?.addTarget(self, action: Selector("toggleDrawingButtonAction"), for: .touchUpInside)
        
        preButton = UIButton()
        self.preButton?.titleLabel?.font = UIFont(name: "FontAwesome", size: 24)
        self.preButton?.setTitleColor(UIColor.darkGray, for: .normal)
        self.preButton?.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.preButton?.setTitle(kPreImageName, for: .normal)
        //        self.toggleDrawingButton?.backgroundColor = UIColor.green
        self.preButton?.addTarget(self, action: "preButtonAction", for: .touchUpInside)
        
        nextButton = UIButton()
        self.nextButton?.titleLabel?.font = UIFont(name: "FontAwesome", size: 24)
        self.nextButton?.setTitleColor(UIColor.darkGray, for: .normal)
        self.nextButton?.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.nextButton?.setTitle(kNextImageName, for: .normal)
        //        self.toggleDrawingButton?.backgroundColor = UIColor.green
        self.nextButton?.addTarget(self, action: "nextButtonAction", for: .touchUpInside)
        
    }
    
    func initData(){
        self.articleStr = self.readArticle(name: articleName)
    }
    
    override func viewDidLoad() {
        
        self.initView()
        self.initData()
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.jotViewController?.delegate = self
        //获取当前文字
        currentText = self.getCurrentText(count: currentCount)
        //绘制文字
        self.drawingImageWithText(text: currentText)
        
        self.addChildViewController(jotViewController!)
        self.view.addSubview((jotViewController?.view)!)
        jotViewController?.didMove(toParentViewController: self)
        jotViewController?.view.frame = self.view.frame
        self.jotViewController?.view.frame = CGRect(x: 0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT - 60)
        
        self.view.addSubview(self.saveButton!)
        self.saveButton?.frame = CGRect(x: SCREEN_WIDTH-48,y: 4,width: 44,height: 44)
        
        self.view.addSubview(self.clearButton!)
        self.clearButton?.frame = CGRect(x: 4,y: 4,width: 44,height: 44)
        
//        self.view.addSubview(self.toggleDrawingButton!)
//        self.toggleDrawingButton?.frame = CGRect(x: SCREEN_WIDTH-44,y: SCREEN_HEIGHT - (49 + 44 + 4 + 70),width: 44,height: 44)
        
        self.view.addSubview(self.preButton!)
        self.preButton?.frame = CGRect(x: 0,y: SCREEN_HEIGHT - (49 + 44 + 4 + 70),width: 44,height: 44)
        
        self.view.addSubview(self.nextButton!)
        self.nextButton?.frame = CGRect(x: SCREEN_WIDTH-44,y: SCREEN_HEIGHT - (49 + 44 + 4 + 70),width: 44,height: 44)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.jotViewController?.state == JotViewState.text) {
            self.jotViewController?.state = JotViewState.editingText
        }
    }
    
    func jotViewController(_ jotViewController: JotViewController!, isEditingText isEditing: Bool) {
        print("isEditing = \(isEditing)")
        self.clearButton?.isHidden = isEditing
        self.saveButton?.isHidden = isEditing
        self.toggleDrawingButton?.isHidden = isEditing
    }
    func getCurrentText(count: Int) -> String{
        let range = NSRange.init(location: count, length: 1)
        let text = NSString(string: articleStr).substring(with: range)
        print("text = \(text)")
        return text
    }
    func drawingImageWithText(text: String){
        writingBack = WritingBackCustomView()
        print("fontName = \(self.fontFamily)")
        let font = self.getFontByTitle(title: self.fontFamily)
        writingBack?.setFontFamliy(fontFamily: font.familyName)
        writingBack?.frame = CGRect(x: (SCREEN_WIDTH-300)/2, y: (SCREEN_HEIGHT-450)/2, width: 300, height: 300)
        //设置字体样式
        self.jotViewController?.view.insertSubview(writingBack!, at: 0)
    }
    
    func configFontStyle(jotViewController: JotViewController){
        
        jotViewController.textColor = UIColor.black
        jotViewController.textEditingInsets = UIEdgeInsetsMake(12, 6, 0, 6);
        jotViewController.initialTextInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        jotViewController.fitOriginalFontSizeToViewWidth = true
        jotViewController.textAlignment = .left
        jotViewController.drawingColor = UIColor.cyan
        
        var size: CGFloat = 20
        
        if self.fontSize == "较细" {
            size = 16
        }else if self.fontSize == "适中" {
            size = 20
        }else if self.fontSize == "较粗" {
            size = 30
        }
        //设置画笔大小
        jotViewController.drawingStrokeWidth = size
    }
    
    func getFontByTitle(title: String) -> UIFont{
        var font: UIFont?
        switch title {
        case "楷书":
            font = UIFont.KaishuFont
            break
        case "行书":
            font = UIFont.XingshuFont
            break
        case "草书":
            font = UIFont.CaoshuFont
            break
        case "隶书":
            font = UIFont.LishuFont
            break
        case "篆书":
            font = UIFont.ZhuanshuFont
            break
        case "颜体":
            font = UIFont.YantiFont
            break
        case "欧体":
            font = UIFont.OutiFont
            break
        case "钟齐翰墨体":
            font = UIFont.Zhongqi_HanmoFont
            break
            
        default:
            font = UIFont.Zhongqi_HanmoFont
            break
        }
        return font!
    }
    
    func clearButtonAction(){
        jotViewController?.clearAll()
    }
    
    func saveButtonAction(){
        /*
        let drawnImage = self.jotViewController?.renderImage(withScale: 2, on: self.view.backgroundColor)
        self.jotViewController?.clearAll()
        let library = ALAssetsLibrary()
        library.writeImage(toSavedPhotosAlbum: drawnImage as! CGImage!, orientation: drawnImage?.imageOrientation as! ALAssetOrientation, completionBlock: { [weak self](assetURL, error) in
            if ((error) != nil) {
                NSLog("Error saving photo: \(error.unsafelyUnwrapped)")
            } else {
                NSLog("Saved photo to saved photos album.")
            }
        })
         */
    }
    
    func preButtonAction(){
        self.clearButtonAction()
        if currentCount > 0 {
            currentCount = currentCount - 1
            let text = self.getCurrentText(count: currentCount)
            writingBack?.setDrawText(text: text)
        }
        
    }
    
    func nextButtonAction(){
        self.clearButtonAction()
        if currentCount < self.articleStr.characters.count {
            currentCount = currentCount + 1
            let text = self.getCurrentText(count: currentCount)
            writingBack?.setDrawText(text: text)
        }
        
    }
    
    func toggleDrawingButtonAction(){
        if self.jotViewController?.state == JotViewState.drawing {
            self.toggleDrawingButton?.setTitle(kPencilImageName, for: .normal)
            if self.jotViewController?.textString.characters.count == 0 {
                self.jotViewController?.state = JotViewState.editingText
            }else{
                self.jotViewController?.state = JotViewState.text
            }
        }else if self.jotViewController?.state == JotViewState.text {
            self.jotViewController?.state = JotViewState.drawing
            self.jotViewController?.drawingColor = UIColor(red: (CGFloat)(arc4random_uniform(255))/(CGFloat)(255), green: (CGFloat)(arc4random_uniform(255))/(CGFloat)(255), blue: (CGFloat)(arc4random_uniform(255))/(CGFloat)(255), alpha: 1)
//            self.jotViewController?.drawingColor = UIColor.red
            self.toggleDrawingButton?.setTitle(kTextImageName, for: .normal)
        }
    }

    func readArticle(name: String) -> String {
        let fileUrl = Bundle.main.url(forResource: name, withExtension: ".txt", subdirectory: nil, localization: nil)
        var article = ""
        do{
            //获取文件句柄:sanzijing.txt
            let fileHandle = try FileHandle(forReadingFrom: fileUrl!)
            //
            let data = fileHandle.readDataToEndOfFile()
            article = String(data: data, encoding: String.Encoding.utf8)!
            print(article)
//            self.writingBack?.setDrawText(text: firstStr!)
        }catch{
            print("文件读取失败")
            article = ""
        }
       return article
    }
}





















