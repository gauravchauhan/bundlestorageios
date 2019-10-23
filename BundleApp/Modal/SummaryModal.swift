//
//  SummaryModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 23/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class SummaryModal{
    
    private var address : String!
    private var bundleCharge : String!
    private var desc : String!
    private var discount : String!
    private var discountPrice : String!
    private var duration : String!
    private var all_Price : String!
    private var hostImage : String!
    private var storageDate : String!
    private var name : String!
    
    
    var storage_hostName : String?{
        get{
            return name
        }
        set{
            self.name = newValue
        }
    }
    
    var storage_HostImage : String?{
        get{
            return Constants.AppUrls.baseUrl + Constants.AppUrls.showImage + hostImage
        }
        set{
            self.hostImage = newValue
        }
    }
    
    var storage_storageDate : String?{
        get{
            return storageDate
        }
        set{
            self.storageDate = newValue
        }
    }
    
    var storage_Address : String?{
        get{
            return address
        }
        set{
            self.address = newValue
        }
    }
    
    var storage_Charge : String?{
        get{
            return bundleCharge
        }
        set{
            self.bundleCharge = newValue
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
    var storage_DiscountValue : String?{
        get{
            return discount
        }
        set{
            self.discount = newValue
        }
    }
    
    var storage_DiscountPrice : String?{
        get{
            return discountPrice
        }
        set{
            self.discountPrice = newValue
        }
    }
    
    var storage_Duration : String?{
        get{
            return duration
        }
        set{
            self.duration = newValue
        }
    }
    
    var storage_TotalPrice : String?{
        get{
            return all_Price
        }
        set{
            self.all_Price = newValue
        }
    }
    
    
    
}
