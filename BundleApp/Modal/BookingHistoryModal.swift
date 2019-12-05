//
//  BookingHistoryModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 05/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class BookingHistoryModal{
    
    private var status : String!
    private var book_Type : String!
    private var desc : String!
    private var ownerName : String!
    private var storage : StorageListModal!
    
    var storage_Status : String?{
        get{
            return status
        }
        set{
            self.status = newValue
        }
    }
    
    var storage_Type : String?{
        get{
            return book_Type
        }
        set{
            self.book_Type = newValue
        }
    }
    
    var storage_Description : String?{
        get{
            return desc
        }
        set{
            self.desc = newValue
        }
    }
    
    var storage_HostName : String?{
        get{
            return ownerName
        }
        set{
            self.ownerName = newValue
        }
    }
    
    var storage_List : StorageListModal{
        get{
            return storage
        }
        set{
            self.storage = newValue
        }
    }
    
    
    
    /* bookingStatus = Pending;
     bookingType = regular;
     createdAt = "2019-12-03T13:08:51.000Z";
     description = "Ifhurgfurebywuinywu jetfoil fiowgfwiufweiufnuiwenfiuwenfyuwnefyeiwfwetfywtefwtnefinwi";
     endDate = "2020-01-02T18:30:00.000Z";
     host =     {
     companyName = "<null>";
     createdAt = "2019-10-10T09:22:53.000Z";
     email = "roh_jft@gmail.com";
     firebasetoken = "<null>";
     firstName = rohit;
     forgotPasswordToken = "<null>";
     googleId = "<null>";
     id = "784027f4-4961-4e98-a888-4be557bc1828";
     idProofUrl = "/opt/Bundle/images/1571745301756.134.jpeg";
     isBlock = 0;
     isEmailVerified = 0;
     isIdProof = 1;
     isIdProofVerified = 0;
     isMobileVerified = 1;
     lastName = jft;
     location = "e61ef2b5-c972-42f4-ba86-0223fe37edf1";
     mobileNumber = 1234567890;
     otp = 531729;
     profileImage = "/opt/Bundle/images/1570703623453.681.jpeg";
     updatedAt = "2019-10-22T11:55:15.000Z";
     };
     id = "3c3dd6ba-46d6-406a-a077-e7ea632e4bc9";
     itemType = "<null>";
     startDate = "2019-12-02T18:30:00.000Z";*/
}
