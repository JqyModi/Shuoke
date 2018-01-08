//
//  IndicatorPagerControllerViewController.swift
//  HandWriting
//
//  Created by mac on 17/9/4.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class IndicatorPagerController: UIViewController {
//    @IBOutlet weak var viewPager: ViewPager!
    var viewPager: ViewPager?
    override func viewDidLoad() {
        self.view.frame = CGRect(x: 5, y: 5, width: SCREEN_WIDTH-10, height:  180)
        super.viewDidLoad()
        self.viewPager = ViewPager(frame: CGRect(x: 5, y: 5, width: self.view.frame.width, height:  self.view.frame.height))
        viewPager?.dataSource = self;
        // Do any additional setup after loading the view, typically from a nib.
        viewPager?.animationNext()
        
        self.view.addSubview(viewPager!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewPager?.scrollToPage(index: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension IndicatorPagerController:ViewPagerDataSource{
    func numberOfItems(viewPager:ViewPager) -> Int {
        return 5;
    }
    
    func viewAtIndex(viewPager:ViewPager, index:Int, view:UIView?) -> UIView {
        var newView = view;
        var label:UILabel?
        if(newView == nil){
            newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  self.view.frame.height))
            newView!.backgroundColor = .randomColor()
            
            label = UILabel(frame: newView!.bounds)
            label!.tag = 1
            label!.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
            label!.textAlignment = .center
            label!.font =  label!.font.withSize(28)
            newView?.addSubview(label!)
        }else{
            label = newView?.viewWithTag(1) as? UILabel
        }
        
        label?.text = "Page View Pager  \(index+1)"
        
        return newView!
    }
    
    func didSelectedItem(index: Int) {
        debugPrint("select index \(index)")
    }
    
}

//extension CGFloat {
//    static func random() -> CGFloat {
//        return CGFloat(arc4random()) / CGFloat(UInt32.max)
//    }
//}
//
//
//extension UIColor {
//    static func randomColor() -> UIColor {
//        // If you wanted a random alpha, just create another
//        // random number for that too.
//        return UIColor(red:   .random(),
//                       green: .random(),
//                       blue:  .random(),
//                       alpha: 1.0)
//    }
//}
