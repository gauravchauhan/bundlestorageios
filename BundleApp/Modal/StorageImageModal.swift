//
//  StorageImageModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 30/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation
class StorageImageModal{
    
    /*booking = "<null>";
     createdAt = "2019-09-26T11:22:42.000Z";
     id = "41a1d726-5671-461e-8898-bf2743083642";
     storage = "7cd815f6-a569-4c14-a39e-2bba38184423";
     storageRequest = "<null>";
     updatedAt = "2019-09-26T11:22:52.000Z";
     url = "/opt/Bundle/images/1569496953726.927.jpeg";
     user = "<null>";*/
    private var url : String!
    
    var imageURL : String?{
        get{
            return Constants.AppUrls.baseUrl + Constants.AppUrls.showImage + url!
        }
        set{
            self.url = newValue
        }
    }
    
    
}
