//
//  LoginVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 12/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController , GIDSignInDelegate, SocialLoginDelegate{
    
    //MARK:- Outlets
    
    @IBOutlet weak var dontHaveAccountButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    
    //MARK:- Class lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "userData") != nil{
            self.pushToTabBarController()
        }else{
            
        }
        GIDSignIn.sharedInstance().delegate = self
        self.dontHaveAccountLabel.attributedText = colorString(location: 24, length: 10, String: self.dontHaveAccountLabel.text!, Color: UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:- Delegate
    
    func socialLoginResponse(data: [String : Any]) {
        print("Social login response \(data)")
        let result = (data["user"]as! [String : Any]).nullKeyRemoval()
        UserDefaults.standard.set(result , forKey: "userData")
        UserDefaults.standard.set(data["token"]as! String , forKey: "authToken")
        Singelton.sharedInstance.authToken = data["token"]as! String
        Singelton.sharedInstance.setUserData(data: result)
        self.pushToTabBarController()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            print(user.userID!)
            print(user.profile.name!)
            print(user.profile.givenName!)
            print(user.profile.email!)
            let param = "googleId=\(String(describing: user.userID!))&role=ROLE_USER&firstName=\(String(describing: user.profile.givenName!))&lastName=\(String(describing: user.profile.name.components(separatedBy: " ")[1]))&email=\(String(describing: user.profile.email!))"
            print("Param \(param)")
            Singelton.sharedInstance.service.socialLoginDelegate = self
            Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.socialLogin, api_Type: apiType.POST.rawValue)
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Actions
    
    @IBAction func click_Signup_Button(_ sender: Any) {
        print("Click sighup")
        self.pushToSignUpController()
    }
    
    @IBAction func click_Login_Button(_ sender: Any) {
        print("Click login")
        self.pushToSignINController()
    }
    
    @IBAction func click_GoogleSignInButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func click_DontHaveAccountBttn(_ sender: Any) {
        self.pushToSignUpController()
    }
    

}
