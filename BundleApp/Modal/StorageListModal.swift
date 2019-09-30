//
//  StorageList.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class StorageListModal{
    private var amenities : NSArray!
    private var availablityStatus : String!
    private var descripton : String!
    private var discount : String!
    private var id : String!
    private var location : String!
    private var length : String!
    private var width : String!
    private var media : String!
    private var dailyPrice : String! = ""
    private var weeklyPrice : String! = ""
    private var monthlyPrice : String! = ""
    private var type : String!
    private var name : String!
    private var priceType : String!
    private var storageAddress : AddressModal!
    private var image : [StorageImageModal]!
    
    
    //MARK:- Gettter setter method
    
    var storageLength : String?{
        get{
            return length!
        }
        set{
            self.length = newValue
        }
    }
    var storageWidth : String?{
        get{
            return width!
        }
        set{
            self.width = newValue
        }
    }
    
    var storageImage : [StorageImageModal]?{
        get{
            return image!
        }
        set{
            self.image = newValue
        }
    }
    
    var storageDailyPrice : String?{
        get{
            return dailyPrice!
        }
        set{
            self.dailyPrice = newValue
        }
    }
    
    var storageWeeklyPrice : String?{
        get{
            return weeklyPrice!
        }
        set{
            self.weeklyPrice = newValue
        }
    }
    
    
    var storageMonthlyPrice : String?{
        get{
            return monthlyPrice!
        }
        set{
            self.monthlyPrice = newValue
        }
    }
    
    
    
    var address : AddressModal?{
        get{
            return storageAddress!
        }
        set{
            self.storageAddress = newValue
        }
    }
    
    
    var allAmenities : NSArray?{
        get{
            return amenities!
        }
        set{
            self.amenities = newValue
        }
    }
    
    var availablity : String?{
        get{
            return availablityStatus!
        }
        set{
            self.availablityStatus = newValue
        }
    }
    
    var aboutStorage : String?{
        get{
            return descripton!
        }
        set{
            self.descripton = newValue
        }
    }
    var offers : String?{
        get{
            return discount!
        }
        set{
            self.discount = newValue
        }
    }
    
    var stoargeID : String?{
        get{
            return id!
        }
        set{
            self.id = newValue
        }
    }
    
//    var storageImage : String?{
//        get{
//            return media!
//        }
//        set{
//            self.media = newValue
//        }
//    }
    
    var storageType : String?{
        get{
            return type!
        }
        set{
            self.type = newValue
        }
    }
    
    var storageName : String?{
        get{
            return name!
        }
        set{
            self.name = newValue
        }
    }
    
    var storagePriceType : String?{
        get{
            return priceType!
        }
        set{
            self.priceType = newValue
        }
    }
    
    
}
