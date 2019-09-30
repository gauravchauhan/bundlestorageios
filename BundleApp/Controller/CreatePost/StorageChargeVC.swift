//
//  StorageChargeVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class StorageChargeVC: UIViewController {
    
    @IBOutlet weak var perDay: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var perWeek: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var perMonth: SkyFloatingLabelTextFieldWithIcon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightBarButtonItems(Step: "07")
        self.setBackButtonWithTitle(title: "Create")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click_NextButton(_ sender: Any) {
        
        guard let day : String = self.perDay.text , day != "" else {
            return alert(message: Strings_Const.per_Day , Controller: self)
        }
        guard let week : String = self.perWeek.text , week != "" else {
            return alert(message: Strings_Const.per_Week , Controller: self)
        }
        guard let month : String = self.perMonth.text , month != "" else {
            return alert(message: Strings_Const.per_Month , Controller: self)
        }
        
        Singelton.sharedInstance.addStorageModal.storageDailyPrice = self.perDay.text!
        Singelton.sharedInstance.addStorageModal.storageWeeklyPrice = self.perWeek.text!
        Singelton.sharedInstance.addStorageModal.storageMonthlyPrice = self.perMonth.text!
        self.pushToDisocuntController()
    }
    

}
