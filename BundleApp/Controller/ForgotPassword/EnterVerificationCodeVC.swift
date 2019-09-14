//
//  EnterVerificationCodeVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class EnterVerificationCodeVC: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var enterCode: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var notReceivedCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view. 24 11
        self.setBackButtonWithTitle(title: "Verification Code")
        self.notReceivedCodeLabel.attributedText = colorString(location: 23, length: 11, String: self.notReceivedCodeLabel.text!, Color: UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0))
    }
    
    @IBAction func click_ResendCodeButtn(_ sender: Any) {
        self.pushToResetCodeController()
    }
    
    @IBAction func click_NextButton(_ sender: Any) {
    }
    
    
}
