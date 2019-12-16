//
//  UserFeedbackController.swift
//  BundleApp
//
//  Created by rohit on 04/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import Cosmos

class UserFeedbackController: UIViewController , SubmitReviewDelegate{
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var feedBack: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var storageID : String?
    var user_Name : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("storage Id \(String(describing: storageID!))")
        self.userName.text! = self.user_Name!
        setBackButtonWithTitle(title: "My QR Code")
        self.profileImage.setImageWith(URL(string : Singelton.sharedInstance.userDataModel.userProfilePic!), placeholderImage: UIImage(named: "app_Logo"))
        // Do any additional setup after loading the view.
    }
    
    func submitReviewResponse(data: [String : Any]) {
        print("submitReviewResponse   \(data)")
        data["sttaus"]as! Bool ? DispatchQueue.main.async {
            let alertController = UIAlertController(title: Strings_Const.app_Name, message: "Rated Succesfully." , preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                _ = self.navigationController?.popViewController(animated: true)
            }
            // Add the actions
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            } : alert(message: data["message"]as! String, Controller: self)
    }
    
    
    @IBAction func click_Sendbutton(_ sender: Any) {
        let param = "storage=\(String(describing: self.storageID!))&ratingPoint=\(self.ratingView.rating)&comments=\(String(describing: self.feedBack.text!))&feedbackFrom=\(String(describing: Singelton.sharedInstance.userDataModel.userID!))"
        print("Parameter \(param)")
        Singelton.sharedInstance.service.submitReviewDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.submitReview, api_Type: apiType.POST.rawValue)
    }
    
}
