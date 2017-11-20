//
//  UIFont.swift
//  Example
//
//  Created by Pedro Vicente Gomez on 22/12/15.
//  Copyright © 2015 GoKarumi S.L. All rights reserved.
//

import UIKit

extension UIFont {

    static var navigationBarTitleFont: UIFont {
        let fonts = UIFont.familyNames
        return UIFont(name: "Bauhaus ITC", size: 16)!
    }

    static var KaishuFont: UIFont {
        let fonts = UIFont.familyNames
        return UIFont(name: "KaiTi", size: 16)!
    }
    
    static var LishuFont: UIFont {
        let fonts = UIFont.familyNames
        return UIFont(name: "LiSu", size: 16)!
    }
    
    static var XingshuFont: UIFont {
        let fonts = UIFont.familyNames
        return UIFont(name: "FZXingKai-S04S", size: 16)!
    }
    
    static var CaoshuFont: UIFont {
        let fonts = UIFont.familyNames
//        return UIFont(name: "叶根友疾风草书", size: 16)!
        return UIFont(name: "?|?????????", size: 16)!
    }
    
    static var ZhuanshuFont: UIFont {
        let fonts = UIFont.familyNames
//        return UIFont(name: "迷你繁篆书", size: 16)!
        return UIFont(name: "篆书", size: 16)!
    }
    
    static var YantiFont: UIFont {
        let fonts = UIFont.familyNames
        return UIFont(name: "Nokia Font YanTi", size: 16)!
    }
    
    static var OutiFont: UIFont {
        let fonts = UIFont.familyNames
        return UIFont(name: "HAKUYOOTi3500", size: 16)!
    }
    
    static var Zhongqi_HanmoFont: UIFont {
        let fonts = UIFont.familyNames
        return UIFont(name: "zhongqi-Hanmo", size: 16)!
    }
}
