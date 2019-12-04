//
//  NotificatioModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class NotificatioModal{
    /*createdAt = "2019-12-03T13:08:51.000Z";
     data =     {
     message = "rohithas request for the storage";
     title = "Booking Request";
     type = bookingType;
     };
     id = "c6ce97cb-adcb-4917-b6e7-fd15bc93c55f";
     status = UNREAD;
     updatedAt = "2019-12-03T13:08:51.000Z";*/
    
    private var createdAt : String!
    private var message : String!
    private var title : String!
    private var id : String!
    
    var notification_Time : String?{
        get{
            return createdAt
        }
        set{
            self.createdAt = newValue
        }
    }
    
    var notification_Description : String?{
        get{
            return message
        }
        set{
            self.message = newValue
        }
    }
    
    var notification_Title : String?{
        get{
            return title
        }
        set{
            self.title = newValue
        }
    }
    
    var notification_ID : String?{
        get{
            return id
        }
        set{
            self.id = newValue
        }
    }
}
