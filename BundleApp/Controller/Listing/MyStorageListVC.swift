//
//  MyStorageListVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 22/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class MyStorageListVC: UIViewController , GetHostStorageListDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        Singelton.sharedInstance.service.getHostStorageListDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.hostStorageList, api_Type: apiType.GET.rawValue)
        // Do any additional setup after loading the view.
    }
    
    
    func getHostStorageListResponse(data: [String : Any]) {
        print("MyStorageListVC   \(data)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
