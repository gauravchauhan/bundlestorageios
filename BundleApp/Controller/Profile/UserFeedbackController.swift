//
//  UserFeedbackController.swift
//  BundleApp
//
//  Created by rohit on 04/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class UserFeedbackController: UIViewController {
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var feedBack: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "My QR Code")
        self.profileImage.setImageWith(URL(string : Singelton.sharedInstance.userDataModel.userProfilePic!), placeholderImage: UIImage(named: "app_Logo"))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click_Sendbutton(_ sender: Any) {
    }
    
}
