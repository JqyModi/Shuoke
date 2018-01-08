//
//  ThemeTableCellTableViewCell.swift
//  HandWriting
//
//  Created by mac on 17/9/20.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class ThemeTableCell: UITableViewCell {
    var name: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
        
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
            break;
        case "🌙":
            self.backgroundColor = UIColor.NightCellBackgroundColor
            self.name?.textColor = UIColor.NightCellTextColor
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
        self.layer.shadowRadius = 0.1;
        self.layer.shadowOpacity = 0.1;
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    //重写frame属性而不是方法
    override var frame:CGRect{
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10/2
            newFrame.size.width -= 10
            newFrame.origin.y += 2
            newFrame.size.height -= 2
            super.frame = newFrame
        }
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
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50)
        
        let margin: CGFloat = 0
        name = UILabel()
        name?.width = self.width
        name?.height = 30
        name?.top = self.top + margin
        name?.left = self.left + margin
        name?.textColor = UIColor.cellTextColorDarkGray
        name?.text = "标题"
        name?.textAlignment = .center
        name?.contentMode = .center
        
        self.addSubview(name!)
    }
    
}
