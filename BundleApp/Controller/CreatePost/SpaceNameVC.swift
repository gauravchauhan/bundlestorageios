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
    
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var desc: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var submittButton: UIButton!
    
    let uncheckImage = UIImage(named: "check_box_blank")
    let checkImage = UIImage(named: "check_box_fill_black")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightBarButtonItems(Step: "10")
        self.setBackButtonWithTitle(title: "Create")
        submittButton.isEnabled = false
        submittButton.alpha = 0.5
    }
    
    //MARK:- Delegate
    
    func addStorageResponse(data: [String : Any]) {
        print("add storage response \(data)")
        Indicator.shared.hideProgressView()
        data["status"]as! Bool ? self.pushToTabBarController() : alert(message: data["message"]as! String, Controller: self)
    }
    
    
    //MARK:- Actions
    
    
    @IBAction func click_NextButton(_ sender: Any) {
        guard let storageName : String = self.storageName.text , storageName != "" else {
            return alert(message: Strings_Const.enter_Storage_Name , Controller: self)
        }
        guard let aboutStorage : String = self.desc.text , aboutStorage != "" else {
            return alert(message: Strings_Const.enter_Description , Controller: self)
        }
        Singelton.sharedInstance.addStorageModal.storageName = storageName
        Singelton.sharedInstance.addStorageModal.storageDescription = self.desc.text!
        self.saveStorage()
        
    }
    
    @IBAction func click_TermsButton(_ sender: Any) {
        if agreeButton.image(for: .normal) == uncheckImage{
            agreeButton.setImage(checkImage, for: .normal)
            submittButton.isEnabled = true
            submittButton.alpha = 1.0
        }else{
            agreeButton.setImage(uncheckImage, for: .normal)
            submittButton.isEnabled = false
            submittButton.alpha = 0.5
        }
    }
    
    
    //MARK:- User defined fucntion
    
    
    func saveStorage(){
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.addStorageModal.storageDescription =  self.desc.text!
        Singelton.sharedInstance.service.addStorageDelegate = self
        let param : [NSString : NSObject] = ["storageName" : Singelton.sharedInstance.addStorageModal.storageName! as NSObject , "storageType" : Singelton.sharedInstance.addStorageModal.storageType! as NSObject, "spaceHeight" : Singelton.sharedInstance.addStorageModal.storageHeight! as NSObject, "spaceWidth" : Singelton.sharedInstance.addStorageModal.storagewidth! as NSObject, "availability" : Singelton.sharedInstance.addStorageModal.storageAvailablity! as NSObject , "dailyPrice" : Singelton.sharedInstance.addStorageModal.storageDailyPrice! as NSObject, "weeklyPrice" : Singelton.sharedInstance.addStorageModal.storageWeeklyPrice! as NSObject, "monthelyPrice" : Singelton.sharedInstance.addStorageModal.storageMonthlyPrice! as NSObject , "discount" : Singelton.sharedInstance.addStorageModal.storageDiscount! as NSObject, "amenities" : Singelton.sharedInstance.addStorageModal.storageFacility! as NSObject , "descripton" : Singelton.sharedInstance.addStorageModal.storageDescription!.capitalized as NSObject, "latitude" : Singelton.sharedInstance.addStorageModal.storageLatitude! as NSObject, "longitude" : Singelton.sharedInstance.addStorageModal.storageLongitude! as NSObject, "zipCode" : "2222" as NSObject , "address" : Singelton.sharedInstance.addStorageModal.storageAddress! as NSObject, "media" : Singelton.sharedInstance.addStorageModal.storageImages! as NSObject]
        print("Parameter \(param)")
        Singelton.sharedInstance.service.postWithAFNetworking(parameter: param, apiName: Constants.AppUrls.addStorage)
    }
    
}
