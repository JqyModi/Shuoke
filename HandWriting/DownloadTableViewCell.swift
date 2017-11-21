//
//  DownloadTableViewCell.swift
//  HandWriting
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import Foundation
import BothamUI
import SDWebImage

class DownloadTableViewCell: UITableViewCell, BothamViewCell {
    
    @IBOutlet var name: UILabel?
//    @IBOutlet var time: UILabel?
    
    func configure(forItem item: Download) {
        
        configItemText(item: item)
        
        //        self.selectionStyle = .default
        
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
            self.name?.textColor = UIColor.DayCellTextColor
//            self.time?.textColor = UIColor.DayCellTextBrownColor
            break;
        case "🌙":
            self.backgroundColor = UIColor.NightCellBackgroundColor
            self.name?.textColor = UIColor.NightCellTextColor
//            self.time?.textColor = UIColor.NightCellTextBrownColor
            break;
        default:
            break;
        }
    }
    
    func configStyle(){
        self.layer.cornerRadius = 5;
        self.contentView.layer.cornerRadius = 5.0;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 1.0;
        self.layer.shadowOpacity = 0.5;
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func configItemText(item: Download){
        self.name?.text = item.path
        name?.textColor = UIColor.cellTextColorDarkGray
        name?.width = self.width
        name?.left = 8
        
        /*
        time?.width = self.width/2
        time?.left = self.width/2 - 8
        
        //        time?.contentMode = .right
        time?.textAlignment = .right
        
        //格式化时间
        let date2 = NSDate(timeIntervalSince1970: TimeInterval.init(item.dateline!)!)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        let dateString2 = formatter2.string(from: date2 as Date)
        self.time?.text = dateString2
        //字体大小
        time?.font = UIFont.systemFont(ofSize: 14)
        //字体颜色
        time?.textColor = UIColor.BrownTextColor
        */
    }
    
    //重写frame属性而不是方法
    override var frame:CGRect{
        didSet {
            
            var newFrame = frame
            newFrame.origin.x += 6/2
            newFrame.size.width -= 6
            newFrame.origin.y += 3
            newFrame.size.height -= 3
            super.frame = newFrame
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //取消选择效果
    }
}
