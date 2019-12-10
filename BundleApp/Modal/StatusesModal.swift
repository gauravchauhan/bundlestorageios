//
//  StatusesModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 23/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class StatusesModal{

    private var name : String!
    private var image : String!
    private var status : String!
    private var storage_Name : String!
    private var id : String!
    private var booking_id : String!
    
   
    var storageBookingId : String?{
        get{
            return booking_id
        }
        set{
            self.booking_id = newValue
        }
    }
    
    
    var storageName : String?{
        get{
            return storage_Name
        }
        set{
            self.storage_Name = newValue
        }
    }
    var storageId : String?{
        get{
            return id
        }
        set{
            self.id = newValue
        }
    }
    
    
    var hostName : String?{
        get{
            return name
        }
        set{
            self.name = newValue
        }
    }
    
    var hostProfileImage : String?{
        get{
            return Constants.AppUrls.baseUrl + Constants.AppUrls.showImage + image
        }
        set{
            self.image = newValue
        }
    }
    
    var storageStatus : String?{
        get{
            return status
        }
        set{
            self.status = newValue
        }
    }
    
}
