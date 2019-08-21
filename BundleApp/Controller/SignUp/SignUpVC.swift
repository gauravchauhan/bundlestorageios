//
//  SignUpVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    
    
    @IBOutlet weak var firstName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lastName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var companyName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var email: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var phoneNmber: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextFieldWithIcon!
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.setTheImageWithText(imageName: "email")
        self.lastName.setTheImageWithText(imageName: "lock")
        self.email.setTheImageWithText(imageName: "email")
        self.phoneNmber.setTheImageWithText(imageName: "email")
        self.password.setTheImageWithText(imageName: "lock")
        self.confirmPassword.setTheImageWithText(imageName: "lock")
        self.navigationController?.isNavigationBarHidden = false
        self.setBackButtonWithTitle(title : "Create an account")
        self.alreadyHaveAccountLabel.attributedText = colorString(location: 25, length: 7, String: self.alreadyHaveAccountLabel.text!, Color: UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0))
        self.companyName.isHidden =  true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    

    //MARK:- Actions
    
    @IBAction func click_User(_ sender: Any) {
        DispatchQueue.main.async {
            self.firstName.isHidden =  false
            self.lastName.isHidden =  false
            self.companyName.isHidden =  true
            self.userImage.image = UIImage(named: "filled_Circle")
            self.hostImage.image = UIImage(named: "circle")
            self.businessImage.image = UIImage(named: "circle")
        }
    }
    
    @IBAction func click_host(_ sender: Any) {
        DispatchQueue.main.async {
            self.firstName.isHidden =  false
            self.lastName.isHidden =  false
            self.companyName.isHidden =  true
            self.userImage.image = UIImage(named: "circle")
            self.hostImage.image = UIImage(named: "filled_Circle")
            self.businessImage.image = UIImage(named: "circle")
        }
    }
    
    @IBAction func click_Business(_ sender: Any) {
        DispatchQueue.main.async {
            self.firstName.isHidden =  true
            self.lastName.isHidden =  true
            self.companyName.isHidden =  false
            self.userImage.image = UIImage(named: "circle")
            self.hostImage.image = UIImage(named: "circle")
            self.businessImage.image = UIImage(named: "filled_Circle")
        }
    }
    
    @IBAction func click_SignUp_Button(_ sender: Any) {
    }
    
    @IBAction func click_AlreadyHaveAnAccnt(_ sender: Any) {
        self.pushToLoginController()
    }
    
}
