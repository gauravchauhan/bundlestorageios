//
//  UploadImageModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation


class UploadImageModal{
     private var image : UIImage?
     private var imageData : Any?
     private var imageID : String?
    
    var uploadImage : UIImage?{
        get{
            return image!
        }
        set{
            self.image = newValue
        }
    }
    
    var uploadImageData : Any?{
        get{
            return imageData!
        }
        set{
            self.imageData = newValue
        }
    }
    
    var uploadImageID : String?{
        get{
            return imageID!
        }
        set{
            self.imageID = newValue
        }
    }
    
    
    
    
    
    
    
}
