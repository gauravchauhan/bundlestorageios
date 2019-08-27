//
//  AddressModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation
import GoogleMaps


/*
 location =     {
 address = "H-134,sector 63 ";
 city = Noida;
 createdAt = "2019-08-26T12:19:57.000Z";
 id = "876a8477-cbb0-4088-8588-812f66274e37";
 latitude = "28.244";
 longitude = "77.43300000000001";
 state = UttarPradesh;
 updatedAt = "2019-08-26T12:19:57.000Z";
 zipCode = 201301;
 };*/

class AddressModal {
    private var add : String!
    private var city : String!
    private var lat : CGFloat!
    private var lng : CGFloat!
    private var state : String!
    private var postalCode : String!
    private var position : CLLocationCoordinate2D!
    
    var storagePosition : CLLocationCoordinate2D?{
        get{
            return position!
        }
        set{
            self.position = newValue
        }
    }
    
    var storageAddress : String?{
        get{
            return add!
        }
        set{
            self.add = newValue
        }
    }
    
    var storageCity : String?{
        get{
            return city!
        }
        set{
            self.city = newValue
        }
    }
    
    var storageLat : CGFloat?{
        get{
            return lat!
        }
        set{
            self.lat = newValue
        }
    }
    
    var storageLng : CGFloat?{
        get{
            return lng!
        }
        set{
            self.lng = newValue
        }
    }
    var storageState : String?{
        get{
            return state!
        }
        set{
            self.state = newValue
        }
    }
    
    var zipCode : String?{
        get{
            return postalCode!
        }
        set{
            self.postalCode = newValue
        }
    }
    
    
}
