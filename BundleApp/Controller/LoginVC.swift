//
//  LoginVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 12/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController , GIDSignInDelegate, GIDSignInUIDelegate, getFBData,  codeDelegate, LinkdinAccessTokenDelegate, GetNameFromLindinDelegate, GetEmailFromLindinDelegate{
    
    
    
    //MARK:- Outlets
    
    @IBOutlet weak var emailText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordText: SkyFloatingLabelTextFieldWithIcon!
    
    var lindinToken : String?
    var lindinUserName : String?
    var lindinUserID : String?
    
    
    //MARK:- Class lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UINavigationBar.
        self.navigationController?.isNavigationBarHidden = true
        self.emailText.setTheImageWithText(imageName: "email")
        self.passwordText.setTheImageWithText(imageName: "lock")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    //MARK:- Delegate
    
    func linkdinAccessTokenResponse(data: [String : Any]) {
        print("Linkdin Acess token response to get the acess token \(data)")
        data["access_token"] != nil ? (self.lindinToken = data["access_token"]as? String) : nil
        Singelton.sharedInstance.service.getNameFromLindinDelegate = self
        
        //Call the get name from linkden account
        data["access_token"] != nil ? Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.getNameFromLinkdin + self.lindinToken! , api_Type: apiType.GET.rawValue) : nil
    }
    
    func getCode(code: String) {
        print("getCode \(code)")
        Indicator.shared.showProgressView(self.view)
        
        let param = "grant_type=\(String(describing: "authorization_code"))&client_secret=\(String(describing: Constants.AppUrls.linkdenClient_secret))&client_id=\(String(describing: Constants.AppUrls.linkdenClient_id))&redirect_uri=\(String(describing: "http://testthem.com/redirect"))&code=\(String(describing: code))"
        Singelton.sharedInstance.service.linkdinAccessTokenDelegate = self
        
        //Call the linkden access token api to retrieve the token from the user account
        
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.lindindAccess, api_Type: apiType.POST.rawValue)
    }
    
    func getNameFromLindinResponse(data: [String : Any]) {
        print("getNameFromLindinResponse    \(data)")
        self.lindinUserName = (((data as NSDictionary).value(forKey: "firstName")as! NSDictionary).value(forKey: "localized")as! NSDictionary).value(forKey: "en_US")as? String
        
        print("name Address \(String(describing: self.lindinUserName))")
        
        self.lindinUserID = (data as NSDictionary).value(forKey: "id")as? String
        print("  linkdinId    \(String(describing: self.lindinUserID))")
        
        Singelton.sharedInstance.service.getEmailFromLindinDelegate = self
        
        //Call the get email from linkden account
        
        self.lindinToken != nil ? Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.getEmailFromLinkdin + self.lindinToken! , api_Type: apiType.GET.rawValue) : nil
    }
    
    func getEmailFromLindinResponse(data: [String : Any]) {
        print("getEmailFromLindinResponse     \(data)")
        let emailAddress = ((((data as NSDictionary).value(forKey: "elements")as! NSArray).object(at: 0)as! NSDictionary).value(forKey: "handle~")as! NSDictionary).value(forKey: "emailAddress")as! String
        print("Email address \(emailAddress)")
    }
    
    
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
    
    
    
    @IBAction func click_onLindenButtn(_ sender: Any) {
        self.pushToWebController()
    }
    
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
