//
//  CustomTabbarController.swift
//  TabBarControllerSample
//
//  Created by shima jinsei on 2017/01/22.
//  Copyright © 2017年 Jinsei Shima. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
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

class CustomTabbarController: UITabBarController {
    
    let addButton: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        for item in tabBar.items! {
            if let image = item.image {
                item.image = image.imageWithColor(tintColor: .white).withRenderingMode(.alwaysOriginal)
                item.selectedImage = image.imageWithColor(tintColor: .lightGray).withRenderingMode(.alwaysOriginal)
            }
        }
        
        UITabBar.appearance().tintColor = .darkText
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().selectionIndicatorImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        
        setButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var tabFrame = tabBar.frame
        tabFrame.size.height = 40
        tabFrame.origin.y = view.frame.height - 40
        tabBar.frame = tabFrame
        
    }
    
    private func setButton() {
        addButton.frame = CGRect(x:view.frame.size.width/2 - 29, y: view.frame.size.height - 67, width: 58, height: 58)
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.layer.borderWidth = 4
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.clipsToBounds = true
        addButton.setImage(UIImage(named: "add_circle"), for: UIControlState())
        addButton.setImage(UIImage(named:"add_circle_selected"), for: UIControlState.highlighted)
        addButton.addTarget(self, action: #selector(self.addButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    @objc private func addButtonTapped(_ sender: UITapGestureRecognizer) {
        print("addbutton tapped")
    }
}

extension CustomTabbarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
