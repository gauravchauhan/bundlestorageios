//
//  LoginVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 12/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController , GIDSignInDelegate, GIDSignInUIDelegate, getFBData{
    
    
    //MARK:- Outlets
    
    @IBOutlet weak var emailText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordText: SkyFloatingLabelTextFieldWithIcon!
    
    
    //MARK:- Class lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailText.setTheImageWithText(imageName: "email")
        self.passwordText.setTheImageWithText(imageName: "lock")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    //MARK:- Delegate
    
    func  getFaceBookData(data: [String : Any]) {
        print("Facebook data \(data)")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            print(user.profile.name!)
            print(user.profile.givenName!)
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
    
    @IBAction func click_FBButton(_ sender: Any) {
        let loginWithFb = FbLogin()
        loginWithFb.fbDataDelegate = self
        loginWithFb.openFB(controller: self)
    }
    
    
    @IBAction func click_GoogleSignInButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    

}
