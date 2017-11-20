//
//  SearchTableViewCell.swift
//  HandWriting
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    //View
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //Model
    var searchModel: SearchModel? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = searchModel?.title
        subtitleLabel.text = getZHForModel(model: (searchModel?.model)!)
        timeLabel.text = String().getFormatTimeForDateStr(dateStr: (searchModel?.dateline)!)
        //配置颜色样式
        configStyle()
    }
    
    func getZHForModel(model: String) -> String {
        var modelZH = ""
        switch model {
        case "beitie":
            modelZH = "碑帖"
        case "yeudu":
            modelZH = "阅读"
        case "note":
            modelZH = "讲义"
        case "peixun":
            modelZH = "培训"
        case "video_play":
            modelZH = "视频"
        default:
            break
        }
        return modelZH
    }
    
    func configStyle() {
        titleLabel.textColor = UIColor.cellTextColorDarkGray
        subtitleLabel.textColor = UIColor.cellTextColorDarkGray
        timeLabel.textColor = UIColor.BrownTextColor
    }
}
extension String {
    func getFormatTimeForDateStr(dateStr: String) -> String {
        var timeStr = ""
        //格式化时间
        let date = NSDate(timeIntervalSince1970: TimeInterval.init(dateStr)!)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        timeStr = formatter.string(from: date as Date)
        return timeStr
    }
}
