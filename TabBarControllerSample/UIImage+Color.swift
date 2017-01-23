//
//  UIImage+Color.swift
//  TabBarControllerSample
//
//  Created by shima jinsei on 2017/01/23.
//  Copyright © 2017年 Jinsei Shima. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    public func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
