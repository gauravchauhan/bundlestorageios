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
    private var price : String?
    private var priceType : String?
    private var discount : String?
    private var amenities : NSArray?
    private  var description : String?
    private  var address : String?
    private var Lat : CLLocationDegrees?
    private var Lng : CLLocationDegrees?
    
    
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
    
    var storagePrice : String?{
        get{
            return price!
        }
        set{
            self.price = newValue
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
