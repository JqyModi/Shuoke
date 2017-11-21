//
//  DailyWireframe.swift
//  HandWriting
//
//  Created by mac on 17/8/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
class DailyWireframe: HandWritingWireframe {
    func presentDailyDetailViewController(_ detailData: NSMutableDictionary) {
        let viewController = serviceLocator.provideDailyDetailViewController(detailData: detailData)
        //值传递
//        serviceLocator.provideHomeNavigator()?.push(viewController: viewController)
    }
}
