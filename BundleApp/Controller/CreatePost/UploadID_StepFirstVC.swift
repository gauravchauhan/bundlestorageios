//
//  UploadID_StepFirstVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class UploadID_StepFirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.setRightBarButtonItems(Step: "01")
        self.setBackButtonWithTitle(title: "Create")
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Actions

    @IBAction func click_NextBttn(_ sender: Any) {
        self.pushToSpaceSelectController()
    }
    
}
