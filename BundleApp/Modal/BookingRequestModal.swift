//
//  BookingRequestModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 09/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class BookingRequestModal{
    /* bookingStatus = Pending;
     bookingType = single;
     description = sitsitsits;
     id = "36e8ecd6-036d-4730-8b8b-20d864623684";
     profileImage = "<null>";
     storageId = "4586a75a-3583-479b-8f35-2b01776ba880";
     userId = "8a761ef1-8341-46a2-94d1-ca9e86d28320";
     userName = "rohit jft";*/
    
    private var bookingStatus : String!
    private var bookingType : String!
    private var description : String!
    private var id : String!
    private var profileImage : String! = ""
    private var storageId : String!
    private var userId : String!
    private var userName : String!
    private var storageName : String!
    
    
    var booking_StorageName : String?{
        get{
            return storageName
        }
        set{
            self.storageName = newValue
        }
    }
    
    var booking_Status : String?{
        get{
            return bookingStatus
        }
        set{
            self.bookingStatus = newValue
        }
    }
    
    var booking_Type : String?{
        get{
            return bookingType
        }
        set{
            self.bookingType = newValue
        }
    }
    
    var booking_Description : String?{
        get{
            return description
        }
        set{
            self.description = newValue
        }
    }
    
    var booking_Id : String?{
        get{
            return id
        }
        set{
            self.id = newValue
        }
    }
    
    var booking_StorageId : String?{
        get{
            return storageId
        }
        set{
            self.storageId = newValue
        }
    }
    
    var booked_UserProfileImage : String?{
        get{
            return Constants.AppUrls.baseUrl + Constants.AppUrls.showImage +  profileImage
        }
        set{
            self.profileImage = newValue
        }
    }
    
    var user_id : String?{
        get{
            return userId
        }
        set{
            self.userId = newValue
        }
    }
    var booking_UserName : String?{
        get{
            return userName
        }
        set{
            self.userName = newValue
        }
    }
    
    
    
}
