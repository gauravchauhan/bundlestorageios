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
        location.setLatLong()
        if UserDefaults.standard.value(forKey:"authToken") != nil {
            print("Singelton authToken")
            authToken = UserDefaults.standard.value(forKey: "authToken") as! String
        }
        if UserDefaults.standard.value(forKey:"userData") != nil {
            print("Singelton userData")
//            self.setUserData(data: UserDefaults.standard.value(forKey: "userData") as! [String : Any])
        }
    }
    
//    func setUserData(data : [String : Any]){
//        self.userDataModel.authToken = authToken
//        self.userDataModel.userID = data["id"]as? String
//        self.userDataModel.emailAddress = data["email"]as? String
//        self.userDataModel.fullName = data["fullName"]as? String
//        self.userDataModel.phoneNumber = data["phoneNumber"]as? String
//        self.userDataModel.gender = data["gender"]as? String
//        self.userDataModel.dateOfBirth = data["dob"]as? String
//    }
    
}
