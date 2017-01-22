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

class TabBar: UITabBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 40
        return size
    }
}

class CustomTabbarController: UITabBarController {
    
    let addButton: UIButton = UIButton(type: .custom)
    
    var firstItemImageView: UIImageView!
    var secondItemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
//        for item in tabBar.items! {
//            if let image = item.image {
//                item.image = image.imageWithColor(tintColor: .lightText).withRenderingMode(.alwaysOriginal)
//                item.selectedImage = image.imageWithColor(tintColor: .darkGray).withRenderingMode(.alwaysOriginal)
//            }
//        }
        
        tabBar.items?[0].tag = 0
        tabBar.items?[1].tag = 1
        
        let firstItemView = tabBar.subviews[0]
        firstItemImageView = firstItemView.subviews.first as! UIImageView
        firstItemImageView.contentMode = .center
        
        let secondItemView = tabBar.subviews[1]
        secondItemImageView = secondItemView.subviews.first as! UIImageView
        secondItemImageView.contentMode = .center
        
        UITabBar.appearance().tintColor = .darkText
        UITabBar.appearance().backgroundColor = .groupTableViewBackground
        UITabBar.appearance().selectionIndicatorImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        setButton()
    }
    
    private func setButton() {
        addButton.frame = CGRect(x:view.frame.size.width/2 - 29, y: view.frame.size.height - 67, width: 58, height: 58)
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.layer.borderWidth = 4
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.clipsToBounds = true
        
        let image = UIImage(named: "add_circle")?.imageWithColor(tintColor: .darkGray).withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: "add_circle_selected")?.imageWithColor(tintColor: .darkGray).withRenderingMode(.alwaysOriginal)
        addButton.setImage(image, for: UIControlState())
        addButton.setImage(selectedImage, for: UIControlState.highlighted)
        addButton.addTarget(self, action: #selector(self.addButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    @objc private func addButtonTapped(_ sender: UITapGestureRecognizer) {
        print("addbutton tapped")
    }
}

extension CustomTabbarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            let animation = CAKeyframeAnimation()
            animation.keyPath = "transform.scale"
            animation.duration = 0.3
            animation.values = [NSNumber(value:0.8),
                                NSNumber(value:1.2)
            ]
            animation.timingFunctions = [ CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut),
                                         CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            ]
            animation.isRemovedOnCompletion = true
            
            firstItemImageView.layer.add(animation, forKey: "bounce")
            
//            firstItemImageView.transform = CGAffineTransform.identity
//            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
//                let rotation = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//                self.firstItemImageView.transform = rotation
//            }, completion: nil)
        } else if item.tag == 1 {
            secondItemImageView.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
                let rotation = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                self.secondItemImageView.transform = rotation
            }, completion: nil)
        }
    }
}
