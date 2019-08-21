//
//  SignInVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SignInVC: UIViewController , SignInDelegate{
    
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
    
    //MAARK:- Delegate
    func signInResponse(data: [String : Any]) {
        print("signInResponse   \(data)")
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
    
    //MARK:- User Defined functions
    
    func validatio_Fields(){
        guard let firstName : String = self.emailOrPhone.text , firstName != "" else {
            return alert(message: NSLocalizedString("Enter email or phonr number", comment: ""), Controller: self)
        }
        guard let firstNameValue : String = self.emailOrPhone.text, (Singelton.sharedInstance.validation.isValidCharacters(firstNameValue))else {
            return alert(message: NSLocalizedString("Name doesn't contain special characters , numbers and symbols", comment: ""), Controller: self)
        }
        guard let password : String = self.password.text , password != "" else {
            return alert(message: NSLocalizedString("Enter password", comment: ""), Controller: self)
        }
        let param = "username=\(String(describing: self.emailOrPhone.text!))&password=\(String(describing: self.password.text!))"
        print("Param \(param)")
        Singelton.sharedInstance.service.signInDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.socialLogin, api_Type: apiType.POST.rawValue)
    }
    
}
