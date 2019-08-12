//
//  FbLogin.swift
//  BundleApp
//
//  Created by Vijay Mishra on 12/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation
import FBSDKLoginKit

protocol getFBData {
    func getFaceBookData(data : [String : Any])
}

class FbLogin{
    
    var fbDataDelegate : getFBData! = nil
    
    func openFB(controller : UIViewController){
        print("Click FB button")
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: controller) { (result, error) in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        //                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
//                    print("Fb result \((result as! NSDictionary))")
                    self.fbDataDelegate.getFaceBookData(data: result as! [String : Any])
                }
            })
        }
    }
    
    
    
}

