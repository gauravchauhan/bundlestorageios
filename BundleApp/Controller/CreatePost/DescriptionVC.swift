//
//  DescribtionVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 21/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController, AddStorageDelegate {

    @IBOutlet weak var storageDesc: SkyFloatingLabelTextFieldWithIcon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Delegate
    
    func addStorageResponse(data: [String : Any]) {
        print("Add storage resposne \(data)")
    }
    
    @IBAction func click_submitBttn(_ sender: Any) {
        guard let description : String = self.storageDesc.text , description != "" else {
            return alert(message: Strings_Const.enter_Description , Controller: self)
        }
        Singelton.sharedInstance.addStorageModal.storageDescription =  description
        Singelton.sharedInstance.service.addStorageDelegate = self
        let param : [NSString : NSObject] = ["storageName" : Singelton.sharedInstance.addStorageModal.storageName! as NSObject , "storageType" : Singelton.sharedInstance.addStorageModal.storageType! as NSObject, "spaceHeight" : Singelton.sharedInstance.addStorageModal.storageHeight! as NSObject, "spaceWidth" : Singelton.sharedInstance.addStorageModal.storagewidth! as NSObject, "availability" : Singelton.sharedInstance.addStorageModal.storageAvailablity! as NSObject , "price" : "200" as NSObject, "priceType" : "Monthly" as NSObject, "discount" : Singelton.sharedInstance.addStorageModal.storageDiscount! as NSObject, "amenities" : Singelton.sharedInstance.addStorageModal.storageFacility! as NSObject , "description" : Singelton.sharedInstance.addStorageModal.storageDescription! as NSObject, "latitude" : Singelton.sharedInstance.addStorageModal.storageLatitude! as NSObject, "longitude" : Singelton.sharedInstance.addStorageModal.storageLongitude! as NSObject, "zipCode" : "2222" as NSObject , "address" : Singelton.sharedInstance.addStorageModal.storageAddress! as NSObject]
        print("Parameter \(param)")
        Singelton.sharedInstance.service.postWithAFNetworking(parameter: param, apiName: Constants.AppUrls.addStorage)
    }
    
}
