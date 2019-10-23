//
//  ProfileViewController.swift
//  BundleApp
//
//  Created by rohit on 03/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ClickRateDelegate, GetUserBookingStatusesListDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var companyTitle: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var acceptSingleItemSwitch: UISwitch!
    @IBOutlet weak var singleItemAccept: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.SwitchUserObserverActions), name: NSNotification.Name(rawValue:"Switch_User"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? DispatchQueue.main.async {
            self.acceptSingleItemSwitch.isHidden = false; self.singleItemAccept.isHidden = false;
            } : DispatchQueue.main.async {
                self.acceptSingleItemSwitch.isHidden = true; self.singleItemAccept.isHidden = true;
        }
        print("Singelton.sharedInstance.userDataModel.userProfilePic   \(Singelton.sharedInstance.userDataModel.userProfilePic!)")
        self.profileImage.setImageWith(URL(string : Singelton.sharedInstance.userDataModel.userProfilePic!), placeholderImage: UIImage(named: "app_Logo"))
        self.companyTitle.text! = Singelton.sharedInstance.userDataModel.userFirstName! + " " + Singelton.sharedInstance.userDataModel.userLastName!
        tableView.register(UINib(nibName: "StatusViewCell", bundle: nil), forCellReuseIdentifier: "StatusViewCell")
        getUserBookingStatusList()
    }
    
    
    //MARK:- Delagate
    
    func getUserBookingStatusesResponse(data: [String : Any]) {
        print("getUserBookingStatusesResponse   \(data)")
    }
    
    
    func click_Rate(_ cell: UITableViewCell, didPressButton: UIButton) {
        print("Click rate ")
        self.pushToRatingController()
    }
    
    @objc  func SwitchUserObserverActions(notification: Notification){
        print("User Change")
        self.viewWillAppear(true)
    }
    
    func getUserBookingStatusList(){
        Singelton.sharedInstance.service.getUserBookingStatusesListDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.userBookingStatuses, api_Type: apiType.GET.rawValue)
    }
    

    @IBAction func switchValueChanged(_ sender: UISwitch) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusViewCell", for: indexPath) as! StatusViewCell
        cell.rateClickDelgate = self
        cell.tag = indexPath.row
        return cell
    }
    
    
    @IBAction func click_EditProfileButton(_ sender: Any) {
        self.pushToEditProfileController()
    }
    
    @IBAction func click_Settings(_ sender: Any) {
        pushToSettingsController()
    }
    
}
