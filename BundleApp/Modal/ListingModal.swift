//
//  ListingModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 21/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class ListingModal{
    private var type : String!
    private var status : Bool! = false
    
    var listingType : String?{
        get{
            return type!
        }
        set{
            self.type = newValue
        }
    }
    
    var selectedStatus : Bool?{
        get{
            return status
        }
        set{
            self.status = newValue!
        }
    }
    
}
