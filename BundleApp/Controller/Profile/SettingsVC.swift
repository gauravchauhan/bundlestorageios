//
//  SettingsVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 11/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource , GetIdProofStatusDelegate{
    
    
    @IBOutlet weak var settingsList: UITableView!
    var idProofStatus : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getIDProofStatus()
        setBackButtonWithTitle(title: "Settings")
        self.settingsList.register(UINib(nibName:"SettingsCell" , bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        settingsList.refreshControl = refreshControl
    }
    
    
    //MARK:- Delegate
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done
        getIDProofStatus()
        refreshControl.endRefreshing()
    }
    
    func getIdProofStatusResponse(data: [String : Any]) {
        print("getIdProofStatusResponse  \(data)")
        !((data["user"]as! [String : Any])["isIdProofVerified"] is NSNull) ? ((data["user"]as! [String : Any])["isIdProofVerified"]as! Bool) ? (self.idProofStatus = "Verified") : (self.idProofStatus = "Deneid/Pending") : (self.idProofStatus = "Not Uploaded")
        reloadSettingsList()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Strings_Const.Settings_Items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingsList.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath)as! SettingsTableViewCell
        cell.settingTitle.text! = Strings_Const.Settings_Items[indexPath.row]
        
        if indexPath.row == 0{
            cell.status.isHidden = false
            cell.statusImage.isHidden = false
            self.idProofStatus == "Not Uploaded" ? DispatchQueue.main.async {
                (cell.statusImage.image = UIImage(named: "upload"));(cell.status.text! = self.idProofStatus!)
                } : self.idProofStatus == "Verified" ? DispatchQueue.main.async {
                (cell.statusImage.image = UIImage(named: "Approved"));(cell.status.text! = self.idProofStatus!)
                    } : DispatchQueue.main.async {
                        (cell.statusImage.image = UIImage(named: "Pending"));(cell.status.text! = self.idProofStatus!)
            }
        }else{
            cell.status.isHidden = true
            cell.statusImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        indexPath.row == 0 ? self.pushToStep_FirstController(comingFromSettings: true) : self.pushToBookingHistory()
        
        switch indexPath.row {
        case 0:
            //GovermentID
            self.pushToStep_FirstController(comingFromSettings: true)
        case 1:
             //Booking history
            self.pushToBookingHistory()
        case 2:
             //support
            self.pushToSupportControllerController()
        case 3:
             //Community guidlines
            self.pushToPrivacyController(apiName: Constants.AppUrls.communityGuidelines, screenName: Strings_Const.Settings_Items[indexPath.row])
        case 4:
            //Terms & Conditions
            self.pushToPrivacyController(apiName: Constants.AppUrls.termsAndCondition, screenName: Strings_Const.Settings_Items[indexPath.row])
        case 5:
            
            self.pushToPrivacyController(apiName: Constants.AppUrls.privayPolicy, screenName: Strings_Const.Settings_Items[indexPath.row])
        case 6:
            self.pushToPrivacyController(apiName: Constants.AppUrls.privayPolicy, screenName: Strings_Const.Settings_Items[indexPath.row])
        case 7:
            self.pushToPrivacyController(apiName: Constants.AppUrls.privayPolicy, screenName: Strings_Const.Settings_Items[indexPath.row])
        case 8:
            self.pushToPrivacyController(apiName: Constants.AppUrls.FAQs, screenName: Strings_Const.Settings_Items[indexPath.row])
        default:
            print("default")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    //MARK:- User Defined fucntion
    
    func getIDProofStatus(){
        Singelton.sharedInstance.service.getIdProofStatusDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.idProof_Status, api_Type: apiType.GET.rawValue)
    }
    
    func reloadSettingsList(){
        DispatchQueue.main.async {
            self.settingsList.delegate = self
            self.settingsList.dataSource = self
            self.settingsList.reloadData()
        }
    }
    
    
}
