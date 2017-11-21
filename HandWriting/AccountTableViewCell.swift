//
//  AccountTableViewCell.swift
//  HandWriting
//
//  Created by mac on 9/5/17.
//  Copyright © 2017 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
import SCLAlertView_Objective_C

class AccountTableViewCell: UITableViewCell, BothamViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    func configure(forItem item: Account) {
        keyLabel.text = item.key
        valueLabel.text = item.value
        
        //处理性别显示:默认0:男 1: 女
        if item.key == "性别" {
            switch item.value {
            case "0":
                valueLabel.text = "男"
            case "1":
                valueLabel.text = "女"
            default:
                break
            }
        }
        
        self.selectionStyle = .none
        
        configTextStyle()
        //设置圆角及阴影效果
        configStyle()
        
//        self.longPressAction()
        configTheme()
        
    }
    
    func configTheme(){
        //判断当前主题
        let name = UserDefaults.standard.object(forKey: THEME) as! String
        switch name {
        case "☀️":
            self.backgroundColor = UIColor.DayCellBackgroundColor
            self.keyLabel.textColor = UIColor.DayCellTextColor
            self.valueLabel.textColor = UIColor.DayCellTextBrownColor
            break;
        case "🌙":
            self.backgroundColor = UIColor.NightCellBackgroundColor
            self.keyLabel.textColor = UIColor.NightCellTextColor
            self.valueLabel.textColor = UIColor.NightCellTextColor
            break;
        default:
            break;
        }
    }
    
    func configStyle(){
        //        self.layer.cornerRadius = 10;
        //        self.contentView.layer.cornerRadius = 10.0;
        //        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOpacity = 0.5;
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    //重写frame属性而不是方法
    override var frame:CGRect{
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10/2
            newFrame.size.width -= 10
            newFrame.origin.y += 3
            newFrame.size.height -= 3
            super.frame = newFrame
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //取消选择效果
    }
    
    private func applyImageGradient(_ thumbnailImage: UIImageView) {
        guard thumbnailImage.layer.sublayers == nil else {
            return
        }
        let gradient: CAGradientLayer = CAGradientLayer(layer: thumbnailImage.layer)
        gradient.frame = thumbnailImage.bounds
        gradient.colors = [UIColor.gradientStartColor.cgColor, UIColor.gradientEndColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.6)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        thumbnailImage.layer.insertSublayer(gradient, at: 0)
    }
    
    func configTextStyle(){
        self.keyLabel.textColor = UIColor.cellTextColorDarkGray
        //        self.nameLabel.font = UIFont.init(name: "zhongqi-Hanmo", size: 25)
        self.valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func longPressAction(){
        //给Item添加长按事件
        let longPress = UILongPressGestureRecognizer(target: self, action: "showDialog")
        self.addGestureRecognizer(longPress)
    }
    
    func showDialog() {
        let account = Account(key: "key", value: "value")
        let alert = SCLAlertView(newWindowWidth: SCREEN_WIDTH-50)
        //处理性别输入
        if account.key == "性别" {
            let sexView = SexChoiceView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
            sexView.backgroundColor = UIColor.brown
//            sexView.sexDelegate = self
            alert?.addCustomView(sexView)
            alert?.addButton("确认", actionBlock: {
                //
                print("确认点击")
            })
            alert?.showEdit(account.key, subTitle: "请输入更改后的\(account.key)", closeButtonTitle: "取消", duration: TimeInterval(Int.max))
        }else{
            let textField = alert?.addTextField(account.value)
            alert?.addButton("确认", actionBlock: {
                //
                print("确认点击")
            })
            alert?.showEdit(account.key, subTitle: "请输入更改后的\(account.key)", closeButtonTitle: "取消", duration: TimeInterval(Int.max))
        }
    }
}

