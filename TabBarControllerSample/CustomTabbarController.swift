//
//  CustomTabbarController.swift
//  TabBarControllerSample
//
//  Created by shima jinsei on 2017/01/22.
//  Copyright © 2017年 Jinsei Shima. All rights reserved.
//

import Foundation
import UIKit

class CustomTabbarController: UITabBarController {
    
    let addButton: UIButton = {
        let button = UIButton(type: .custom)
        let screen = UIScreen.main.bounds.size
        let buttonSize: CGFloat = 58
        let buttomMargin: CGFloat = 8
        button.frame = CGRect(x: screen.width/2 - buttonSize/2, y: screen.height - buttonSize - buttomMargin, width: buttonSize, height: buttonSize)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        return button
    }()
    
    let cardStackController: CardStackController = {
        let cardStackController = CardStackController()
        cardStackController.cardScaleFactor = 0.95
        cardStackController.firstCardTopOffset = 20
        cardStackController.topOffsetBetweenCards = 20
        cardStackController.verticalTranslation = -20
        return cardStackController
    }()
    
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
        
        setTabBar()
        setButton()
    }
    
    private func setTabBar() {
        UITabBar.appearance().tintColor = .darkText
        UITabBar.appearance().backgroundColor = .groupTableViewBackground
        UITabBar.appearance().selectionIndicatorImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    private func setButton() {
        let image = UIImage(named: "add_circle")?.imageWithColor(tintColor: .darkGray).withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: "add_circle_selected")?.imageWithColor(tintColor: .darkGray).withRenderingMode(.alwaysOriginal)
        addButton.setImage(image, for: UIControlState())
        addButton.setImage(selectedImage, for: UIControlState.highlighted)
        addButton.addTarget(self, action: #selector(self.addButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    @objc private func addButtonTapped(_ sender: UITapGestureRecognizer) {

        cardStackController.delegate = self
        present(cardStackController, animated: false, completion: nil)

        let cardViewController = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
        cardViewController.delegate = self
        cardStackController.stack(viewController: cardViewController)
    }
}

extension CustomTabbarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 { // first tab selected
            // bounce animation
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
            firstItemImageView.layer.add(animation, forKey: nil)
        } else if item.tag == 1 { // second tab selected
            // rotate animation
            secondItemImageView.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
                let rotation = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                self.secondItemImageView.transform = rotation
            }, completion: nil)
        }
    }
}

extension CustomTabbarController: CardStackControllerDelegate {
}

extension CustomTabbarController: CardViewControllerDelegate {
    
    func dismiss() {
        cardStackController.unstackLastViewController()
    }
}
