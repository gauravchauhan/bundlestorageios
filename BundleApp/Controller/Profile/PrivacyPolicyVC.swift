
//
//  PrivacyPolicyVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 04/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class PrivacyPolicyVC: UIViewController, PrivacyPolicyDelgateDelegate {

    @IBOutlet weak var urlText: UILabel!
    
    var apiName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: apiName!)
        Singelton.sharedInstance.service.privacyPolicyDelgateDelegate = self
        
        Singelton.sharedInstance.service.getService(apiName: self.apiName!, api_Type: apiType.GET.rawValue)
        // Do any additional setup after loading the view.
    }
    
    func privacyPolicyDelgateResponse(data: [String : Any]) {
        print("privacyPolicyDelgateResponse   \(data)")
    }
}
