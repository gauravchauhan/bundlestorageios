//
//  Singelton.swift
//  DROR
//
//  Created by Rohit Gupta on 08/10/18.
//  Copyright © 2018 Rohit Gupta. All rights reserved.
//

import Foundation
import CoreLocation


class Singelton {
    
    static let sharedInstance = Singelton()
    var validation = Validation()
    var service = Service()
    var location = Location()
    var authToken = ""
    var userDataModel = UserDataModal()
    var addStorageModal = AddStorageModal()
    var id : String?
    var currentCountryCode : String?
    var currentLatitude : CLLocationDegrees!
    var currentLongitude : CLLocationDegrees!
    
    // METHODS
    private init() {
        print("Singelton run ")
        if UserDefaults.standard.value(forKey:"authToken") != nil {
            print("Singelton authToken")
            authToken = UserDefaults.standard.value(forKey: "authToken") as! String
        }
        if UserDefaults.standard.value(forKey:"userData") != nil {
            print("Singelton userData")
            self.setUserData(data: UserDefaults.standard.value(forKey: "userData") as! [String : Any])
        }
    }
    
    func setUserData(data : [String : Any]){
        self.userDataModel.companyName = data["companyName"]as? String
        self.userDataModel.email = data["email"]as? String
        self.userDataModel.googleID = data["googleId"]as? String
        self.userDataModel.userFirstName = data["firstName"]as? String
        self.userDataModel.uploadIDProofStatus = data["isIdProof"]as? Bool
        self.userDataModel.mobileNumberVerified = data["isMobileVerified"]as? Bool
        self.userDataModel.userLastName = data["lastName"]as? String
        self.userDataModel.userPhoneNumber = data["mobileNumber"]as? String
        self.userDataModel.userProfilePic = data["profileImage"]as? String
        self.userDataModel.userAuthenticationToken = self.authToken
        self.userDataModel.userID = data["id"]as? String
        self.userDataModel.userIDProofURL = data["idProofUrl"]as? String
//        self.userDataModel.userRole =
    }
}

