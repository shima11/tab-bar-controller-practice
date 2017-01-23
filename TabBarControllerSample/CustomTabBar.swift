//
//  CustomTabBar.swift
//  TabBarControllerSample
//
//  Created by shima jinsei on 2017/01/23.
//  Copyright © 2017年 Jinsei Shima. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBar {

    // tabbar height
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 40
        return size
    }
    
}
