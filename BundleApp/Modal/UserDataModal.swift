//
//  UserDataModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation


/*
 "user": {
 companyName = "<null>";
 createdAt = "2019-08-26T09:43:46.000Z";
 email = "rohitjft@gmail.com";
 facebookId = "<null>";
 firstName = rohit;
 forgotPasswordToken = "<null>";
 googleId = "<null>";
 id = "211624b5-5f2f-4c64-b0e8-0159346e07d5";
 idProofUrl = "<null>";
 instagramId = "<null>";
 isBlock = 0;
 isEmailVerified = 0;
 isIdProof = 0;
 isMobileVerified = 0;
 lastName = JFT;
 linkedInId = "<null>";
 location = "<null>";
 mobileNumber = 9450679314;
 otp = 331106;
 role =     (
 {
 authority = "ROLE_USER";
 createdAt = "2019-08-23T07:00:37.000Z";
 id = 1;
 updatedAt = "2019-08-23T07:00:37.000Z";
 }
 );
 twitterId = "<null>";
 updatedAt = "2019-08-26T09:43:46.000Z";*/


class UserDataModal{
    private var organsation_Name : String!
    private var mail : String!
    private var gmail_ID : String!
    private var first_Name : String!
    private var last_Name : String!
    private var id : String!
    private var isIdProof : Bool!
    private var isMobileVerified : Bool!
    private var location : String!
    private var mobile_Number : String!
    private var userImage : String!
    private var token : String!
    private var idProofUrl : String!
    
    
    var userIDProofURL : String?{
        get{
            return idProofUrl!
        }
        set{
            self.idProofUrl = newValue
        }
    }
    
    
    
    var userAuthenticationToken : String?{
        get{
            return token!
        }
        set{
            self.token = newValue
        }
    }
    
    
    var userProfilePic : String?{
        get{
            return userImage!
        }
        set{
            self.userImage = newValue
        }
    }
    
    var companyName : String?{
        get{
            return organsation_Name!
        }
        set{
            self.organsation_Name = newValue
        }
    }
    
    var email : String?{
        get{
            return mail!
        }
        set{
            self.mail = newValue
        }
    }
    var googleID : String?{
        get{
            return gmail_ID!
        }
        set{
            self.gmail_ID = newValue
        }
    }
    
    var userFirstName : String?{
        get{
            return first_Name!
        }
        set{
            self.first_Name = newValue
        }
    }
    
    var userLastName : String?{
        get{
            return last_Name!
        }
        set{
            self.last_Name = newValue
        }
    }
    
    var userID : String?{
        get{
            return id!
        }
        set{
            self.id = newValue
        }
    }

    var uploadIDProofStatus : Bool?{
        get{
            return isIdProof!
        }
        set{
            self.isIdProof = newValue
        }
    }
 
    var mobileNumberVerified : Bool?{
        get{
            return isMobileVerified!
        }
        set{
            self.isMobileVerified = newValue
        }
    }
    
    var userLocation : String?{
        get{
            return location!
        }
        set{
            self.location = newValue
        }
    }
    
    var userPhoneNumber : String?{
        get{
            return mobile_Number!
        }
        set{
            self.mobile_Number = newValue
        }
    }
    
    
    
    
}
