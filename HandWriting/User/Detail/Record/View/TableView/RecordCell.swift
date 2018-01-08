//
//  RecordCell.swift
//  HandWriting
//
//  Created by mac on 17/9/18.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    var name: UILabel?
    var type: UILabel?
    var time: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(){
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100)
        
        let bgView = UIView(frame: self.frame)
        bgView.backgroundColor = UIColor.cellBackgroundColorGray
        
        let margin: CGFloat = 10
        name = UILabel()
        name?.width = bgView.width
        name?.height = 25
        name?.top = bgView.top + margin
        name?.left = bgView.left + margin
        name?.textColor = UIColor.cellTextColorDarkGray
        name?.text = "标题"
        
        type = UILabel()
        type?.width = bgView.width/3
        type?.height = 20
        type?.left = bgView.left + margin
        type?.top = (name?.bottom)! + margin
        //字体大小
        type?.font = UIFont.systemFont(ofSize: 14)
        //字体颜色
        type?.textColor = UIColor.cellTextColorDarkGray
        type?.text = "类型"
        
        time = UILabel()
        time?.width = bgView.width/2
        time?.height = 20
        time?.right = bgView.right
        time?.top = (name?.bottom)! + margin
        //字体大小
        time?.font = UIFont.systemFont(ofSize: 14)
        //字体颜色
        time?.textColor = UIColor.orange
        time?.text = "2017-09-18"
        
        bgView.addSubview(name!)
        bgView.addSubview(type!)
        bgView.addSubview(time!)
        
        self.addSubview(bgView)
    }

}
