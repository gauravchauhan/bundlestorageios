//
//  AddStorageModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 28/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class AddStorageModal{
    
    var spaceName : String?
    var spaceType : String?
    var spaceHeight : String?
    var spaceWidth   : String?
    var availability : String?
    var price : String?
    var priceType : String?
    var discount : String?
    var amenities : NSArray?
    var description : String?
    var Image : NSData?
    
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
    
    var storageFaculity : NSArray?{
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
    
    var storageImage : NSData?{
        get{
            return Image!
        }
        set{
            self.Image = newValue
        }
    }
    
    
    
    
}
