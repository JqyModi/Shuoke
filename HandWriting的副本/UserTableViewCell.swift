//
//  UserTableViewCell.swift
//  HandWriting
//
//  Created by mac on 17/8/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI
class UserTableViewCell: UITableViewCell, BothamViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var rightBtn: UIButton!
    
    func configure(forItem item: User) {
        nameLabel.text = item.name
        nameLabel.accessibilityLabel = item.name
        let icon = UIImage(named: item.icon)
        thumbnailImage.image = icon
//        applyImageGradient(thumbnailImage)
        
        //计算并填充缓存
        if item.name == "清空缓存" {
            rightBtn.isUserInteractionEnabled = true
            let cache = UserServece.caculateCache()
            rightBtn.setTitle("\(cache)M",for: .normal)
            rightBtn.setTitleColor(UIColor.BrownTextColor, for: .normal)
            rightBtn.setImage(nil, for: .normal)
        }else{
            rightBtn.isUserInteractionEnabled = false
        }
        
        self.selectionStyle = .none
        
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
            self.nameLabel.textColor = UIColor.DayCellTextColor
            self.thumbnailImage.tintColor = UIColor.DayCellTextColor
            break;
        case "🌙":
            self.backgroundColor = UIColor.NightCellBackgroundColor
            self.nameLabel.textColor = UIColor.NightCellTextColor
            self.thumbnailImage.tintColor = UIColor.NightCellTextColor
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
             newFrame.origin.y += 1
             newFrame.size.height -= 1
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
        self.nameLabel.textColor = UIColor.cellTextColorDarkGray
//        self.nameLabel.font = UIFont.init(name: "zhongqi-Hanmo", size: 25)
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
