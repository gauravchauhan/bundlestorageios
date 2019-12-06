//
//  ProfileViewController.swift
//  BundleApp
//
//  Created by rohit on 03/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ClickRateDelegate, GetUserBookingStatusesListDelegate, GetHostBookingStatusesListDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var companyTitle: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var acceptSingleItemSwitch: UISwitch!
    @IBOutlet weak var singleItemAccept: UILabel!
    @IBOutlet weak var noDataFoundView: UIView!
    
    var userStatusesModal = [StatusesModal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.SwitchUserObserverActions), name: NSNotification.Name(rawValue:"Switch_User"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? DispatchQueue.main.async {
            self.acceptSingleItemSwitch.isHidden = false; self.singleItemAccept.isHidden = false;self.getHostBookingStatusList()
            } : DispatchQueue.main.async {
                self.acceptSingleItemSwitch.isHidden = true; self.singleItemAccept.isHidden = true;self.getUserBookingStatusList()
        }
        print("Singelton.sharedInstance.userDataModel.userProfilePic   \(Singelton.sharedInstance.userDataModel.userProfilePic!)")
        self.profileImage.setImageWith(URL(string : Singelton.sharedInstance.userDataModel.userProfilePic!), placeholderImage: UIImage(named: "app_Logo"))
        self.companyTitle.text! = Singelton.sharedInstance.userDataModel.userFirstName! + " " + Singelton.sharedInstance.userDataModel.userLastName!
        tableView.register(UINib(nibName: "StatusViewCell", bundle: nil), forCellReuseIdentifier: "StatusViewCell")
    }
    
    
    //MARK:- Delagate
    
    func getHostBookingStatusesResponse(data: [String : Any]) {
        print("getHostStorageListResponse   \(data)")
        data["status"]as! Bool ? self.setHostStatusData(data: data["bookingList"] as! [[String :  Any]]): DispatchQueue.main.async {
            
            self.noDataFoundView.isHidden = false
        }
    }
    
    func getUserBookingStatusesResponse(data: [String : Any]) {
        print("getUserBookingStatusesResponse   \(data)")
        data["status"]as! Bool ? self.setUserStatusData(data: data["bookingList"] as! [[String :  Any]]): DispatchQueue.main.async {
            
            self.noDataFoundView.isHidden = false
        }
    }
    
    
    func click_Rate(_ cell: UITableViewCell, didPressButton: UIButton) {
        print("Click rate ")
        if self.userStatusesModal[cell.tag].storageStatus!.contains("Coordinate drop off with user") || self.userStatusesModal[cell.tag].storageStatus!.contains("Coordinate drop of time with host"){
            self.pushToRatingController(storageId: self.userStatusesModal[cell.tag].storageId!, userName: self.userStatusesModal[cell.tag].hostName!)
        }else if self.userStatusesModal[cell.tag].storageStatus!.contains("on the way to drop off items") || self.userStatusesModal[cell.tag].storageStatus!.contains("Please drop of your items"){
            Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? self.pushToScanQRCodeontroller(storageId: self.userStatusesModal[cell.tag].storageId!, bookingID: "") : self.pushToQRCodeViewController(storageId: self.userStatusesModal[cell.tag].storageId!)
        }else if self.userStatusesModal[cell.tag].storageStatus!.contains("on the way to pick up items") || self.userStatusesModal[cell.tag].storageStatus!.contains("Please pick up your items"){
            Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? self.pushToQRCodeViewController(storageId: self.userStatusesModal[cell.tag].storageId!) : self.pushToScanQRCodeontroller(storageId: self.userStatusesModal[cell.tag].storageId!, bookingID: "")
        }
    }
    
    @objc  func SwitchUserObserverActions(notification: Notification){
        print("User Change")
        self.viewWillAppear(true)
    }
    
    func getUserBookingStatusList(){
        Singelton.sharedInstance.service.getUserBookingStatusesListDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.userBookingStatuses, api_Type: apiType.GET.rawValue)
    }
    
    func getHostBookingStatusList(){
        Singelton.sharedInstance.service.getHostBookingStatusesListDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.hostStorageStatus, api_Type: apiType.GET.rawValue)
    }
    
    func setUserStatusData(data : [[String : Any]]){
        self.userStatusesModal.removeAll()
        for index in 0...data.count - 1 {
            let object = StatusesModal()
            object.hostName = data[index]["hostName"]as? String
            object.hostProfileImage = data[index]["hostProfileImage"]as? String
            object.storageStatus = data[index]["status"]as? String
            object.storageName = data[index]["storageName"]as? String
            object.storageId = data[index]["storageId"]as? String
            self.userStatusesModal.append(object)
        }
        self.reloadTheStatusTable()
    }
    
    func setHostStatusData(data : [[String : Any]]){
        self.userStatusesModal.removeAll()
        for index in 0...data.count - 1 {
            let object = StatusesModal()
            object.hostName = data[index]["userName"]as? String
            object.hostProfileImage = (data[index]["userProfileImage"]is NSNull) ? "" : data[index]["userProfileImage"]as? String
            object.storageStatus = data[index]["status"]as? String
            object.storageName = data[index]["storageName"]as? String
            object.storageId = data[index]["storageId"]as? String
            self.userStatusesModal.append(object)
        }
        self.reloadTheStatusTable()
    }
    
    func reloadTheStatusTable(){
        DispatchQueue.main.async {
            self.noDataFoundView.isHidden = true
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    

    @IBAction func switchValueChanged(_ sender: UISwitch) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userStatusesModal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusViewCell", for: indexPath) as! StatusViewCell
        cell.rateClickDelgate = self
        cell.userName.text! = self.userStatusesModal[indexPath.row].storageName!
        cell.curretnStatus.text! = self.userStatusesModal[indexPath.row].storageStatus!
        if self.userStatusesModal[indexPath.row].storageStatus!.contains("Coordinate drop off with user") || self.userStatusesModal[indexPath.row].storageStatus!.contains("Coordinate drop of time with host"){
            cell.statusButton.setTitle("RATE", for: .normal)
        }else if self.userStatusesModal[indexPath.row].storageStatus!.contains("on the way to drop off items") || self.userStatusesModal[indexPath.row].storageStatus!.contains("Please drop of your items"){
            Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? cell.statusButton.setTitle("SCAN", for: .normal) : cell.statusButton.setTitle("QR", for: .normal)
        }else if self.userStatusesModal[indexPath.row].storageStatus!.contains("on the way to pick up items") || self.userStatusesModal[indexPath.row].storageStatus!.contains("Please pick up your items"){
            Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? cell.statusButton.setTitle("QR", for: .normal) : cell.statusButton.setTitle("SCAN", for: .normal)
        }
        cell.userImage.setImageWith(URL(string : self.userStatusesModal[indexPath.row].hostProfileImage!), placeholderImage: UIImage(named: "app_Logo"))
        cell.tag = indexPath.row
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @IBAction func click_EditProfileButton(_ sender: Any) {
        self.pushToEditProfileController()
    }
    
    @IBAction func click_Settings(_ sender: Any) {
        pushToSettingsController()
    }
    
}
