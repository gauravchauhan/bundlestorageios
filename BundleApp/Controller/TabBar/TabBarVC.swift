//
//  TabBarVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController , LogoutDelegate, NotificationCountDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.click_MenuItems), name: NSNotification.Name(rawValue:"Click_MenuItems"), object: nil)
        Singelton.sharedInstance.service.notificationCountDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.notificationCount, api_Type: apiType.GET.rawValue)
        self.addDrawerButton()
        self.setNotification_FilterButton(notificationCount: "0")
    }
    
    func NotificationCountResponse(data: [String : Any]) {
        print("NotificationCountResponse   \(data)    \(data["notificationCount"]as! Int)")
        (data["status"]as! Bool) ? DispatchQueue.main.async {
            self.setNotification_FilterButton(notificationCount: "\(data["notificationCount"]as! Int)")
            } : self.setNotification_FilterButton(notificationCount: "0")
    }
    
    func logouttResponse(data: [String : Any]) {
        print("logouttResponse   \(data)")
    }
    
    
    @objc  func click_MenuItems(notification: Notification){
        print("Click menu items  \((notification.userInfo! as NSDictionary))")
        switch (notification.userInfo! as! [String : Any])["click_Items"]as! Int {
        case 0:
            self.selectedIndex = 2
        case 1:
            self.pushToReferalController()
            print("refer")
        case 2:
            self.pushToSupportControllerController()
            print("support")
        case 3:
            Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? print("switch to User") : print("switch to host")
        case 4:
            Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ?  print("Earnings") : print("savings")
        case 5:
            Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? self.pushToMyStorageListController() : self.logout_Click()
        case 6:
            Singelton.sharedInstance.service.logoutDelegate =  self
            self.logout_Click()
            print("Logout")
        default:
            print("default")
        }
    }
    
}
