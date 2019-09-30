//
//  AddStorageModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 28/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation
import CoreLocation

class AddStorageModal{
    
    private var spaceName : String?
    private var spaceType : String?
    private var spaceHeight : String?
    private var spaceWidth   : String?
    private var availability : String?
    private var dailyprice : String?
    private var weeklyprice : String?
    private var monthlyprice : String?
    private var priceType : String?
    private var discount : String?
    private var amenities : NSArray?
    private  var description : String?
    private  var address : String?
    private var Lat : CLLocationDegrees?
    private var Lng : CLLocationDegrees?
    private var imageID : NSArray?
    
    
    var storageImages : NSArray?{
        get{
            return imageID!
        }
        set{
            self.imageID = newValue
        }
    }
    
    var storageAddress : String?{
        get{
            return address!
        }
        set{
            self.address = newValue
        }
    }
    var storageLatitude : CLLocationDegrees?{
        get{
            return Lat!
        }
        set{
            self.Lat = newValue
        }
    }
    
    var storageLongitude : CLLocationDegrees?{
        get{
            return Lng!
        }
        set{
            self.Lng = newValue
        }
    }
    
    var storageName : String?{
        get{
            return spaceName!
        }
        set{
            self.spaceName = newValue
        }
    }
    
    var storageType : String?{
        get{
            return spaceType!
        }
        set{
            self.spaceType = newValue
        }
    }
    
    var storageHeight : String?{
        get{
            return spaceHeight!
        }
        set{
            self.spaceHeight = newValue
        }
    }
    
    var storagewidth : String?{
        get{
            return spaceWidth!
        }
        set{
            self.spaceWidth = newValue
        }
    }
    
    var storageAvailablity : String?{
        get{
            return availability!
        }
        set{
            self.availability = newValue
        }
    }
    
    var storageDailyPrice : String?{
        get{
            return dailyprice!
        }
        set{
            self.dailyprice = newValue
        }
    }
    
    var storageWeeklyPrice : String?{
        get{
            return weeklyprice!
        }
        set{
            self.weeklyprice = newValue
        }
    }
    
    var storageMonthlyPrice : String?{
        get{
            return monthlyprice!
        }
        set{
            self.monthlyprice = newValue
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
    
    var storageDiscount : String?{
        get{
            return discount!
        }
        set{
            self.discount = newValue
        }
    }
    
    var storageFacility : NSArray?{
        get{
            return amenities!
        }
        set{
            self.amenities = newValue
        }
    }
    
    var storageDescription : String?{
        get{
            return description!
        }
        set{
            self.description = newValue
        }
    }
    
}
