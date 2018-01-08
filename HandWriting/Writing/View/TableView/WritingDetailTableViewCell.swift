//
//  WritingDetailTableViewCell.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI

class WritingDetailTableViewCell: UITableViewCell, BothamViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    
    func configure(forItem item: WritingDetail) {
        //填充cell数据
        keyLabel.text = item.name
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
            break;
        case "🌙":
            self.backgroundColor = UIColor.NightCellBackgroundColor
            self.keyLabel.textColor = UIColor.NightCellTextColor
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
    
    func configTextStyle(){
        self.keyLabel.textColor = UIColor.cellTextColorDarkGray
        //        self.keyLabel.font = UIFont.init(name: "zhongqi-Hanmo", size: 25)
        self.keyLabel.font = UIFont.systemFont(ofSize: 16)
    }
}
