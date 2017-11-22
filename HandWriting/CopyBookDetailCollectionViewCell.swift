//
//  CopyBookDetailCollectionViewCell.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import BothamUI
import SDWebImage

class CopyBookDetailCollectionViewCell: UICollectionViewCell, BothamViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    var imageURL: String?
    
    func configure(forItem item: CopyBookDetail) {
        let url = BASEURL + item.img_url
        
        imageURL = url
        
        let placeImg: UIImage = UIImage(named: "load_failure")!
        coverImageView.sd_setImage(with: URL(string: url), placeholderImage: placeImg)
    }
    
}
