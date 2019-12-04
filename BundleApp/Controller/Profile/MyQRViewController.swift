//
//  MyQRViewController.swift
//  BundleApp
//
//  Created by rohit on 04/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class MyQRViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "QR code scanner")
        self.userImage.setImageWith(URL(string : Singelton.sharedInstance.userDataModel.userProfilePic!), placeholderImage: UIImage(named: "app_Logo"))
        self.userName.text! = "\(Singelton.sharedInstance.userDataModel.userFirstName!) \(Singelton.sharedInstance.userDataModel.userLastName!)"
        self.qrCodeImage.image = generateQRCode(from: "Hacking with Swift is the best iOS coding tutorial I've ever read!")
        // Do any additional setup after loading the view.
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
