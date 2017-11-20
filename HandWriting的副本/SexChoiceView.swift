//
//  SexChoiceView.swift
//  HandWriting
//
//  Created by mac on 2017/10/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

protocol SexChoiceDelegate {
    func itemSelect(index: Int)
}
class SexChoiceView: UIView {
    var sexDelegate: SexChoiceDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        bgView.backgroundColor = UIColor.cyan
        let sex = UISegmentedControl()
        let margin: CGFloat = 8
        sex.width = 80
        sex.height = 25
        sex.top = bgView.top + 2.5
        sex.left = (bgView.width-sex.width)/2
        
        sex.insertSegment(withTitle: "男", at: 0, animated: true)
        sex.insertSegment(withTitle: "女", at: 1, animated: true)
//        sex.setTitle("男", forSegmentAt: 0)
//        sex.setTitle("女", forSegmentAt: 1)
        sex.addTarget(self, action: #selector(SexChoiceView.choiceSex(sender:)), for: UIControlEvents.valueChanged)
        
        bgView.addSubview(sex)
        addSubview(bgView)
    }
    func choiceSex(sender: UISegmentedControl){
        let index = sender.selectedSegmentIndex
        sexDelegate?.itemSelect(index: index)
    }
}

