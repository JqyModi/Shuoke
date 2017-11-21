//
//  StudyTableViewCell.swift
//  HandWriting
//
//  Created by mac on 17/8/24.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import SDWebImage

class StudyTableViewCell: UITableViewCell, BothamViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func configure(forItem item: Common) {
        nameLabel.text = item.title
        nameLabel.accessibilityLabel = item.title
        let imgUrl = BASEURL + item.img_url_s
        let placeImg: UIImage = UIImage(named: "load_failure")!
        //此操作需要设置info中传输协议配置
        thumbnailImage.sd_setImage(with: URL.init(string: imgUrl), placeholderImage: placeImg)
        
        viewCountLabel.text = String("访问量：\(item.view_count)")
        viewCountLabel.accessibilityLabel = String(item.view_count)
        applyImageGradient(thumbnailImage)
        
        self.selectionStyle = .default
        thumbnailImage.layer.cornerRadius = 10
        thumbnailImage.layer.masksToBounds = true
        
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
            self.viewCountLabel.textColor = UIColor.DayCellTextBrownColor
            break;
        case "🌙":
            self.backgroundColor = UIColor.NightCellBackgroundColor
            self.nameLabel.textColor = UIColor.NightCellTextColor
            self.viewCountLabel.textColor = UIColor.NightCellTextBrownColor
            break;
        default:
            break;
        }
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
