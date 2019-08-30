//
//  SelectSpaceDimensionVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 21/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SelectSpaceDimensionVC: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var length: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var width: SkyFloatingLabelTextFieldWithIcon!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightBarButtonItems(Step: "04")
        self.setBackButtonWithTitle(title: "Create")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click_NextButton(_ sender: Any) {
        
        guard let length : String = self.length.text , length != "" else {
            return alert(message: NSLocalizedString("Enter length", comment: ""), Controller: self)
        }
        guard let width : String = self.width.text , width != "" else {
            return alert(message: NSLocalizedString("Enter width", comment: ""), Controller: self)
        }
        
        Singelton.sharedInstance.addStorageModal.storageHeight = length
        Singelton.sharedInstance.addStorageModal.storagewidth = width
        self.pushToDescribeListingController(fromWhichScreen: "selectSpace")
    }
    

}
