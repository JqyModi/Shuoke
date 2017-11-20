//
//  String.swift
//  HandWriting
//
//  Created by mac on 17/8/30.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
extension String{
    func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
}
