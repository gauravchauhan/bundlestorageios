//
//  SignInVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var dontHaveAnAccountLabel: UILabel!
    @IBOutlet weak var emailOrPhone: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var businessImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.emailOrPhone.setTheImageWithText(imageName: "email")
        self.password.setTheImageWithText(imageName: "lock")
        self.setBackButtonWithTitle(title : "Sign In")
        self.dontHaveAnAccountLabel.attributedText = colorString(location: 24, length: 11, String: self.dontHaveAnAccountLabel.text!, Color: UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0))
        // Do any additional setup after loading the view.
    }
    

    //MARK:- Actions
    
    @IBAction func click_SignUpBttn(_ sender: Any) {
    }
    
    @IBAction func click_DontHaveAnAccountBttn(_ sender: Any) {
    }
    
    
    @IBAction func click_ForgotPassword(_ sender: Any) {
        self.pushToEnterCodeController()
    }
    
    
    @IBAction func click_userButtn(_ sender: Any) {
        DispatchQueue.main.async {
            self.userImage.image = UIImage(named: "filled_Circle")
            self.hostImage.image = UIImage(named: "circle")
            self.businessImage.image = UIImage(named: "circle")
        }
    }
    
    @IBAction func click_HostBttn(_ sender: Any) {
        DispatchQueue.main.async {
            self.userImage.image = UIImage(named: "circle")
            self.hostImage.image = UIImage(named: "filled_Circle")
            self.businessImage.image = UIImage(named: "circle")
        }
    }
    
    @IBAction func click_BusinessBttn(_ sender: Any) {
        DispatchQueue.main.async {
            self.userImage.image = UIImage(named: "circle")
            self.hostImage.image = UIImage(named: "circle")
            self.businessImage.image = UIImage(named: "filled_Circle")
        }
    }
    
}
