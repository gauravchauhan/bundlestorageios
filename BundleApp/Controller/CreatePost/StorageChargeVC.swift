//
//  StorageChargeVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class StorageChargeVC: UIViewController {
    
    @IBOutlet weak var perDay: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var perWeek: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var perMonth: SkyFloatingLabelTextFieldWithIcon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightBarButtonItems(Step: "07")
        self.setBackButtonWithTitle(title: "Create")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click_NextButton(_ sender: Any) {
        self.pushToDisocuntController()
    }
    

}
