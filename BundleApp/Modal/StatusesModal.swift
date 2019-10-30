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
