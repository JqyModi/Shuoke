//
//  WritingTableViewCell.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI

class WritingTableViewCell: UITableViewCell, BothamViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    func configure(forItem item: Writing) {
        keyLabel.text = item.key
        keyLabel.accessibilityLabel = item.key
        valueLabel.text = item.value
        valueLabel.accessibilityLabel = item.value
        
        self.selectionStyle = .gray
        if item.value == "开始练习" {
            //设置字体居中显示
            valueLabel.frame.size.width = self.frame.size.width/2
            //隐藏右侧箭头
            rightButton.isHidden = true
        }
        
        configTextStyle()
        //设置圆角及阴影效果
        configStyle()
        
        configTheme()
        
    }
    
    func configTheme(){
        //判断当前主题
        let name = UserDefaults.standard.object(forKey: THEME) as! String
        switch name {
        case "☀️":
            self.backgroundColor = UIColor.DayCellBackgroundColor
            self.keyLabel.textColor = UIColor.DayCellTextColor
            self.valueLabel.textColor = UIColor.DayCellTextColor
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
    
    func configTextStyle(){
        self.keyLabel.textColor = UIColor.cellTextColorDarkGray
        self.valueLabel.textColor = UIColor.cellTextColorDarkGray
//        self.keyLabel.font = UIFont.init(name: "zhongqi-Hanmo", size: 25)
//        self.valueLabel.font = UIFont.init(name: "zhongqi-Hanmo", size: 25)
        self.keyLabel.font = UIFont.systemFont(ofSize: 16)
        self.valueLabel.font = UIFont.systemFont(ofSize: 16)
    }
}
