//
//  AddBankDetailVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 02/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class AddBankDetailVC: UIViewController , AddBAnkDetailDelegate{
    
    //MARk:- Outlet
    @IBOutlet weak var bankName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var routingNumber: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var accountNumber: SkyFloatingLabelTextFieldWithIcon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.setBackButtonWithTitle(title: "Bank Detail")
        // Do any additional setup after loading the view.4023898493988028  071101307  071000013
        self.routingNumber.text! = "071101307"
        self.accountNumber.text! = "4023898493988028"
        
    }
    
    //MARK:- Delagate
    
    func addBAnkDetailResponse(data: [String : Any]) {
        Indicator.shared.hideProgressView()
        print("Add bank detail response \(data)")
    }
    
    
    @IBAction func click_AddButton(_ sender: Any) {
        /*  descriptor: "Blue Ladders",
         destination: braintree.MerchantAccount.FundingDestination.Bank,
         email: "funding@blueladders.com",
         mobilePhone: "5555555555",
         accountNumber: "1123581321",
         routingNumber: "071101307*/
        Indicator.shared.showProgressView(self.view)
        let param = "descriptor= &destination=\(String(describing: self.bankName.text!))&email=\(String(describing: Singelton.sharedInstance.userDataModel.email!))&mobilePhone=\(String(describing: Singelton.sharedInstance.userDataModel.userPhoneNumber!))&accountNumber=\(String(describing: self.accountNumber.text!))&routingNumber=\(String(describing: self.routingNumber.text!))"
        print("Add bank detail \(param)")
        Singelton.sharedInstance.service.addBAnkDetailDelegate =  self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.addBankDetail, api_Type: apiType.POST.rawValue)
        
    }
    

}
