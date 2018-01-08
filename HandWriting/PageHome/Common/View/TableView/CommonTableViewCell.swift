//
//  HomeTableViewCell.swift
//  HandWriting
//
//  Created by mac on 17/8/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import BothamUI
import SDWebImage

class CommonTableViewCell: UITableViewCell, BothamViewCell {
    
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
    
}
