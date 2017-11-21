//
//  CopyBookDetailCollectionHeaderView.swift
//  HandWriting
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 modi. All rights reserved.
//

import BothamUI
import UIKit

class CopyBookDetailCollectionHeaderView: UICollectionReusableView, BothamViewCell {
    
    @IBOutlet weak var seriesCoverImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(forItem copyBook: Common) {
//        seriesCoverImageView.sd_setImage(with: copyBook.coverURL as URL!)
//        ratingLabel.text = series.rating
//        descriptionLabel.text = series.description
    }
}
