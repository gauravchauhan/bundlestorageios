//
//  SignInVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SignInVC: UIViewController , SignInDelegate, ForgotPasswordDelegate{
    
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
    
    func forgotPasswordResponse(data: [String : Any]) {
        print("Forgot resposne \(data)")
        data["status"]as! Bool ?  self.pushToEnterCodeController() : alert(message: data["message"]as! String, Controller: self)
    }
    
    func signInResponse(data: [String : Any]) {
        Indicator.shared.hideProgressView()
        print("signInResponse   \(data.nullKeyRemoval())")
        
        guard let status : Bool = data["status"]as? Bool , status != false else{
            return alert(message: data["message"]as! String , Controller: self)
        }
        
        var signInResponse = (data["user"]as! [String : Any]).nullKeyRemoval()
        let location = (signInResponse["location"]as! [String : Any]).nullKeyRemoval()
        signInResponse.updateValue( location , forKey: "location")
        UserDefaults.standard.set(signInResponse , forKey: "userData")
        UserDefaults.standard.set(data["token"]as! String , forKey: "authToken")
        Singelton.sharedInstance.authToken = data["token"]as! String
        Singelton.sharedInstance.setUserData(data: signInResponse)
        self.pushToTabBarController()
    }
    
    //MARK:- Actions
    
    @IBAction func click_SignUpBttn(_ sender: Any) {
        self.validation_Fields()
    }
    
    @IBAction func click_DontHaveAnAccountBttn(_ sender: Any) {
        self.pushToSignUpController()
    }
    
    
    @IBAction func click_ForgotPassword(_ sender: Any) {
        guard let firstName : String = self.emailOrPhone.text , firstName != "" else {
            return alert(message: NSLocalizedString("Enter email or phone number", comment: ""), Controller: self)
        }
        let param = "email=\(String(describing: self.emailOrPhone.text!))"
        Singelton.sharedInstance.service.forgotPasswordDelegate =  self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.forgotPassword, api_Type: apiType.POST.rawValue)
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
    
    func validation_Fields(){
        var mess = "invalid Email"
        if !(self.emailOrPhone.text!.isEmpty){
            if Singelton.sharedInstance.validation.isValidEmail(self.emailOrPhone.text!){
                print("Valid email")
                mess = ""
            }else if Singelton.sharedInstance.validation.isValidPhoneNumber(self.emailOrPhone.text!){
                print("Valid phone number")
                mess = ""
            }else{
                alert(message: Strings_Const.enter_Email_Or_Phone, Controller: self)
            }
            
            if mess.isEmpty {
                guard let password : String = self.password.text , password != "" else {
                    return alert(message: Strings_Const.enter_Password, Controller: self)
                }
                
                let param = "username=\(String(describing: self.emailOrPhone.text!))&password=\(String(describing: self.password.text!))&firebasetoken=\(String(describing: Singelton.sharedInstance.FCM_Token!))"
                print("Param \(param)")
                Indicator.shared.showProgressView(self.view)
                Singelton.sharedInstance.service.signInDelegate = self
                Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.login, api_Type: apiType.POST.rawValue)
            }
            
        }else{
            alert(message: Strings_Const.enter_Email_Or_Phone, Controller: self)
        }
        
        
//        guard let firstName : String = self.emailOrPhone.text , firstName != "" else {
//            return alert(message: Strings_Const.enter_Email_Or_Phone, Controller: self)
//        }
        //        guard let firstNameValue : String = self.emailOrPhone.text, (Singelton.sharedInstance.validation.isValidCharacters(firstNameValue))else {
        //            return alert(message: NSLocalizedString("Name doesn't contain special characters , numbers and symbols", comment: ""), Controller: self)
        //        }
        
    }
    
}
