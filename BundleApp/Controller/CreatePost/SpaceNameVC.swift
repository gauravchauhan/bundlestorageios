//
//  SpaceNameVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 21/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SpaceNameVC: UIViewController , AddStorageDelegate{
    @IBOutlet weak var storageName: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var desc: SkyFloatingLabelTextFieldWithIcon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightBarButtonItems(Step: "09")
        self.setBackButtonWithTitle(title: "Create")
    }
    
    //MARK:- Delegate
    
    func addStorageResponse(data: [String : Any]) {
        print("add storage response \(data)")
        data["status"]as! Bool ? self.pushToTabBarController() : alert(message: data["message"]as! String, Controller: self)
    }
    
    
    @IBAction func click_NextButton(_ sender: Any) {
        guard let storageName : String = self.storageName.text , storageName != "" else {
            return alert(message: NSLocalizedString("Enter Storage Name", comment: ""), Controller: self)
        }
        Singelton.sharedInstance.addStorageModal.storageName = storageName
        Singelton.sharedInstance.addStorageModal.storageDescription = self.desc.text!
        self.saveStorage()
        
    }
    
    
    func saveStorage(){
        Singelton.sharedInstance.addStorageModal.storageDescription =  description
        Singelton.sharedInstance.service.addStorageDelegate = self
        let param : [NSString : NSObject] = ["storageName" : Singelton.sharedInstance.addStorageModal.storageName! as NSObject , "storageType" : Singelton.sharedInstance.addStorageModal.storageType! as NSObject, "spaceHeight" : Singelton.sharedInstance.addStorageModal.storageHeight! as NSObject, "spaceWidth" : Singelton.sharedInstance.addStorageModal.storagewidth! as NSObject, "availability" : Singelton.sharedInstance.addStorageModal.storageAvailablity! as NSObject , "price" : "200" as NSObject, "priceType" : "Monthly" as NSObject, "discount" : Singelton.sharedInstance.addStorageModal.storageDiscount! as NSObject, "amenities" : Singelton.sharedInstance.addStorageModal.storageFacility! as NSObject , "description" : Singelton.sharedInstance.addStorageModal.storageDescription! as NSObject, "latitude" : Singelton.sharedInstance.addStorageModal.storageLatitude! as NSObject, "longitude" : Singelton.sharedInstance.addStorageModal.storageLongitude! as NSObject, "zipCode" : "2222" as NSObject , "address" : Singelton.sharedInstance.addStorageModal.storageAddress! as NSObject]
        print("Parameter \(param)")
        Singelton.sharedInstance.service.postWithAFNetworking(parameter: param, apiName: Constants.AppUrls.addStorage)
    }
    
}
