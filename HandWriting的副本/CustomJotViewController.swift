//
//  CustomJotViewController.swift
//  HandWriting
//
//  Created by mac on 17/8/29.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import jot

class CustomJotViewController: JotViewController {
    override func draw(on image: UIImage!) -> UIImage! {
        return UIImage(named: "tianzi.jpg")
    }
}
