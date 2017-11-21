//
//  VideoTableViewCell.swift
//  HandWriting
//
//  Created by mac on 17/8/21.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import SDWebImage

class VideoTableViewCell: UITableViewCell, BothamViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func configure(forItem item: Video) {
        nameLabel.text = item.name
        nameLabel.accessibilityLabel = item.name
        let url = BASEURL + item.img_url_s
        thumbnailImage.sd_setImage(with: URL(string: url))
        applyImageGradient(thumbnailImage)
        
//        configImg()
        
        configStyle()
        
        configTheme()
        
    }
    
    func configImg(){
        //        self.selectionStyle = .blue
        //        thumbnailImage.layer.cornerRadius = 10
        //        thumbnailImage.layer.masksToBounds = true
        thumbnailImage.contentMode = .center
        let h_margin: CGFloat = 8
        let v_margin: CGFloat = 4
        thumbnailImage.width = self.width - 16
        thumbnailImage.height = self.height - 8
        thumbnailImage.left = self.left + h_margin
        thumbnailImage.top = self.top + v_margin
        
    }
    
    func configTheme(){
        //判断当前主题
        let name = UserDefaults.standard.object(forKey: THEME) as! String
        switch name {
        case "☀️":
            self.backgroundColor = UIColor.DayCellBackgroundColor
            self.nameLabel.textColor = UIColor.white
            break;
        case "🌙":
            self.backgroundColor = UIColor.NightCellBackgroundColor
            self.nameLabel.textColor = UIColor.white
            break;
        default:
            break;
        }
    }
    
    private func applyImageGradient(_ thumbnailImage: UIImageView) {
        guard thumbnailImage.layer.sublayers == nil else {
            return
        }
        let gradient: CAGradientLayer = CAGradientLayer(layer: thumbnailImage.layer)
        gradient.frame = CGRect(x: thumbnailImage.left - 10, y: thumbnailImage.top - 10, width: self.width - 16, height: thumbnailImage.height)
        gradient.colors = [UIColor.gradientStartColor.cgColor, UIColor.gradientEndColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.6)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        thumbnailImage.layer.insertSublayer(gradient, at: 0)
    }
    
    func configStyle(){
        self.layer.cornerRadius = 10;
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
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
            newFrame.origin.y += 5
            newFrame.size.height -= 5
            super.frame = newFrame
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //取消选择效果
    }
}
