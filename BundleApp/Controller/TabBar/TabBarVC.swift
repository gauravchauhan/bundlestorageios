//
//  TabBarVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDrawerButton()
        self.setNotification_FilterButton()
    }
}
