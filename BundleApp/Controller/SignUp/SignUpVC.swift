//
//  SignUpVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, SignUpDelegate {
    
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
    
    //MARK:- Varriables
    var role : String = "ROLE_USER"
    
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
    
    //MARK:- Delegate
    
    func signUpResponse(data: [String : Any]) {
        print("signUpResponse  \(data)")
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
            self.role = "ROLE_HOST"
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
            self.role = "ROLE_BUSINESS"
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
    
    //MARK:- IUser Defined function
    
    func validation_ForFields(){
        if (self.role == "ROLE_USER" || self.role == "ROLE_HOST") {
            guard let firstName : String = self.firstName.text , firstName != "" else {
                return alert(message: NSLocalizedString("Enter first name", comment: ""), Controller: self)
            }
            guard let firstNameValue : String = self.firstName.text, (Singelton.sharedInstance.validation.isValidCharacters(firstNameValue))else {
                return alert(message: NSLocalizedString("Name doesn't contain special characters , numbers and symbols", comment: ""), Controller: self)
            }
            guard let lastName : String = self.lastName.text , lastName != "" else {
                return alert(message: NSLocalizedString("Enter last name", comment: ""), Controller: self)
            }
            guard let lastNameValue : String = self.firstName.text, (Singelton.sharedInstance.validation.isValidCharacters(lastNameValue))else {
                return alert(message: NSLocalizedString("Name doesn't contain special characters , numbers and symbols", comment: ""), Controller: self)
            }
        }else{
            guard let companyName : String = self.companyName.text , companyName != "" else {
                return alert(message: NSLocalizedString("Enter company name", comment: ""), Controller: self)
            }
        }
        guard let emailvalue : String = self.email.text , emailvalue != "" else {
            return alert(message: NSLocalizedString("Enter email", comment: ""), Controller: self)
        }
        guard let email : String = self.email.text ,(Singelton.sharedInstance.validation.isValidEmail(email))else {
            return alert(message: NSLocalizedString("Enter valid email", comment: ""), Controller: self)
        }
        guard let number : String = self.phoneNmber.text , number != ""else {
            return alert(message: NSLocalizedString("Enter mobile number", comment: ""), Controller: self)
        }
        guard let password : String = self.password.text , password != "" else {
            return alert(message: NSLocalizedString("Enter password", comment: ""), Controller: self)
        }
        guard let confirmPassword : String = self.confirmPassword.text , confirmPassword != "" else {
            return alert(message: NSLocalizedString("Enter confirm password", comment: ""), Controller: self)
        }
        guard let cnfrmPassword : String = self.confirmPassword.text , cnfrmPassword == password else {
            return alert(message: NSLocalizedString("Password and confirm password should be same", comment: ""), Controller: self)
        }
        
        var param = ""
        
        if (self.role == "ROLE_USER" || self.role == "ROLE_HOST") {
            param = "firstName=\(String(describing: self.firstName.text!))&role=\(self.role)&lastName=\(String(describing: self.lastName.text!))&email=\(String(describing: self.email.text!))&mobileNumber=\(String(describing: self.phoneNmber.text!))&password=\(String(describing: self.password.text!))"
        }else{
            param = "companyName=\(String(describing: self.firstName.text!))&role=\(self.role)&email=\(String(describing: self.email.text!))&mobileNumber=\(String(describing: self.phoneNmber.text!))&password=\(String(describing: self.password.text!))"
        }
        Singelton.sharedInstance.service.signUpDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.signup, api_Type: apiType.POST.rawValue)
        
    }
    
}
