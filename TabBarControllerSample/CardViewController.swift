//
//  CardViewController.swift
//  TabBarControllerSample
//
//  Created by shima jinsei on 2017/01/23.
//  Copyright © 2017年 Jinsei Shima. All rights reserved.
//

import UIKit

protocol CardViewControllerDelegate: class {
    func dismiss()
}

class CardViewController: UIViewController {

    weak var delegate: CardViewControllerDelegate!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate.dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
    
}
