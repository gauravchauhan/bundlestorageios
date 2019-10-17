//
//  Request_MessageVC.swift
//  BundleApp
//
//  Created by rohit on 02/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class Request_MessageVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate , GetUpcomingBookinRequestDelegate, UserBookinRequestDelegate, UpdateBookingRequestDelegate, UpdateBookingRequest, GetChatListDelegate, CreateChatDelegate , UISearchBarDelegate, UIScrollViewDelegate{
    
    
    //MARK:- Outlets
    @IBOutlet weak var bookingRequestList: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var noDataFound_View: UIView!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var searchField: UISearchBar!
    
    //MARK:- Properties
    var currentSegment = Strings_Const.request
    var bookingRequestmodal = [BookingRequestModal]()
    var chatListModal = [ChatListModal]()
    var searchBookingModel = [BookingRequestModal]()
    var searchChatListModel = [ChatListModal]()
    var searchClick : Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.SwitchUserObserverActions), name: NSNotification.Name(rawValue:"Switch_User"), object: nil)
        bookingRequestList.register(UINib(nibName: "RequestViewCell", bundle: nil), forCellReuseIdentifier: "RequestViewCell")
        bookingRequestList.register(UINib(nibName: "MessageViewCell", bundle: nil), forCellReuseIdentifier: "MessageViewCell")
        
        // Do any additional setup after loading the view.
        segment.selectedSegmentIndex = 0
        let font = UIFont.init(name: Constants.fonts.ProximaNova_Semibold, size: 14.0)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font!],
                                       for: .normal)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        bookingRequestList.refreshControl = refreshControl
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchField.delegate = self
        segment.selectedSegmentIndex == 0 ? self.getRequests() : self.messageList()
    }
    
    
    //MARK:- Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search text \(searchBar.text!)")
        if !searchBar.text!.isEmpty{
            print("text is not wmpty")
            if segment.selectedSegmentIndex == 0{
                self.searchBookingModel.removeAll()
                print(self.bookingRequestmodal.filter({($0.booking_UserName?.contains(searchBar.text!))!}).map({$0}))
                self.bookingRequestmodal.filter({($0.booking_UserName?.contains(searchBar.text!))!}).map({$0}).count != 0 ?  (self.searchBookingModel = self.bookingRequestmodal.filter({($0.booking_UserName?.contains(searchBar.text!))!}).map({$0})): nil
                
                print("search modal count \(self.searchBookingModel.count)")
                
                if self.searchBookingModel.count != 0 {
                    print(" empty modal")
                    self.searchClick = true
                    self.reload_RequestList()
                }else{
                    print("Not empty modal")
                    self.searchClick = false
                    self.reload_RequestList()
                }
            }else{
                self.searchChatListModel.removeAll()
                print(self.searchChatListModel.filter({($0.message_RecieverName?.contains(searchBar.text!))!}).map({$0}))
                self.chatListModal.filter({($0.message_RecieverName?.contains(searchBar.text!))!}).map({$0}).count != 0 ?  (self.searchChatListModel = self.chatListModal.filter({($0.message_RecieverName?.contains(searchBar.text!))!}).map({$0})): nil
                
                print("searchChatListModel count \(self.searchChatListModel.count)")
                
                if self.searchChatListModel.count != 0 {
                    print(" empty modal")
                    self.searchClick = true
                    self.reload_RequestList()
                }else{
                    print("Not empty modal")
                    self.searchClick = false
                    self.reload_RequestList()
                }
            }
        }else{
            self.searchClick = false
            self.reload_RequestList()
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done
        segment.selectedSegmentIndex == 0 ? self.getRequests() : self.messageList()
        refreshControl.endRefreshing()
    }
    
    func createChatResponse(data: [String : Any]) {
        print("createChatResponse   \(data)")
    }
    
    func getRequests(){
        Indicator.shared.showProgressView(self.view)
        if Singelton.sharedInstance.userDataModel.userRole != "ROLE_USER"{
            Singelton.sharedInstance.service.getUpcomingBookinRequestDelegate = self
            Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.getUpcomingBookingRequest, api_Type: apiType.GET.rawValue)
        }else{
            Singelton.sharedInstance.service.userBookinRequestDelegate = self
            Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.userBookingRequest, api_Type: apiType.GET.rawValue)
        }
    }
    
    func messageList(){
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.getChatListDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.chatList, api_Type: apiType.GET.rawValue)
    }
    
    func getChatListResponse(data: [String : Any]) {
        print("chat list reponse \(data)")
        Indicator.shared.hideProgressView()
        data["status"]as! Bool ? self.setTheChatListData(data: data["filterFoundChats"]as! [[String :  Any]]) : DispatchQueue.main.async {
            self.noDataFound.text! = data["message"]as! String ; self.noDataFound_View.isHidden = false
        }
    }
    
    
    @objc  func SwitchUserObserverActions(notification: Notification){
        print("User Change")
        self.viewWillAppear(true)
    }
    
    func click_PayNow(_ cell: UITableViewCell, didPressButton: UIButton) {
        print("click Paynow")
        self.pushToPaymentController()
    }
    
    func click_Approved(_ cell: UITableViewCell, didPressButton: UIButton) {
        print("Click cancel Denied")
        self.bookingRequestmodal[cell.tag].booking_Status = "Approved"
        self.updateBookingRequest(status: "Approved", bookingID: self.bookingRequestmodal[cell.tag].booking_Id!)
        self.reload_RequestList()
    }
    
    func click_Cancel(_ cell: UITableViewCell, didPressButton: UIButton) {
        print("click approved")
        self.bookingRequestmodal[cell.tag].booking_Status = "Denied"
        self.updateBookingRequest(status: "Denied", bookingID: self.bookingRequestmodal[cell.tag].booking_Id!)
        self.reload_RequestList()
    }
    
    func updateBookingRequestResponse(data: [String : Any]) {
        print("Update Booking request reposnse \(data)")
    }
    
    func userBookinRequestResponse(data: [String : Any]) {
        print("userBookinRequestResponsev   \(data)")
        Indicator.shared.hideProgressView()
        data["status"]as! Bool ? self.setTheUserRequestData(data: data["filterUserRequest"]as! [[String :  Any]]) : DispatchQueue.main.async {
            self.noDataFound_View.isHidden = false; self.noDataFound.text! = data["message"]as! String}
    }
    
    
    func getUpcomingBookinRequestResponse(data: [String : Any]) {
        print("getUpcomingBookinRequestResponse   \(data)")
        Indicator.shared.hideProgressView()
        data["status"]as! Bool ? self.setTheBookingRquestData(data: data["bookingRequest"]as! [[String :  Any]]) : DispatchQueue.main.async {
            self.noDataFound.text! = data["message"]as! String;
            self.noDataFound_View.isHidden = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segment.selectedSegmentIndex == 0 ? self.searchClick ? self.searchBookingModel.count : self.bookingRequestmodal.count : self.searchClick ? self.searchChatListModel.count :self.chatListModal.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentSegment == Strings_Const.message{
            let cell = bookingRequestList.dequeueReusableCell(withIdentifier: "MessageViewCell", for: indexPath) as! MessageViewCell
            cell.nameLabel.text! = self.searchClick ? self.searchChatListModel[indexPath.row].message_RecieverName! : self.chatListModal[indexPath.row].message_RecieverName!
            cell.descriptionLabel.text! = self.searchClick ? self.searchChatListModel[indexPath.row].message_lastMessage! : self.chatListModal[indexPath.row].message_lastMessage!
            cell.timeLabel.text! = self.searchClick ? self.searchChatListModel[indexPath.row].message_Time! : self.chatListModal[indexPath.row].message_Time!
            cell.userImage!.setImageWith(URL(string : self.searchClick ? self.searchChatListModel[indexPath.row].message_RecieverImage! : self.chatListModal[indexPath.row].message_RecieverImage!), placeholderImage: UIImage(named: "app_Logo"))
            cell.userImage.layer.masksToBounds = true
            return cell
        }else{
            let cell = bookingRequestList.dequeueReusableCell(withIdentifier: "RequestViewCell", for: indexPath) as! RequestViewCell
            cell.tag =  indexPath.row
            cell.requestDelagate = self
            cell.namelabel.text! = self.searchClick ? self.searchBookingModel[indexPath.row].booking_UserName! : self.bookingRequestmodal[indexPath.row].booking_UserName!
            cell.storageName.text! = self.searchClick ? self.searchBookingModel[indexPath.row].booking_StorageName! : self.bookingRequestmodal[indexPath.row].booking_StorageName!
            cell.statusLabel.text! =  self.searchClick ? self.searchBookingModel[indexPath.row].booking_Status! :  self.bookingRequestmodal[indexPath.row].booking_Status!
            cell.imgView.setImageWith(URL(string : self.searchClick ? self.searchBookingModel[indexPath.row].booked_UserProfileImage! :  self.bookingRequestmodal[indexPath.row].booked_UserProfileImage!), placeholderImage: UIImage(named: "app_Logo"))
            cell.imageView?.layer.masksToBounds = true
            cell.statusImgView.image =  setTheBookingStatus(status: self.searchClick ? self.searchBookingModel[indexPath.row].booking_Status! :  self.bookingRequestmodal[indexPath.row].booking_Status!)
            
            
            if searchClick{
                Singelton.sharedInstance.userDataModel.userRole != "ROLE_USER" ? DispatchQueue.main.async {
                    self.searchBookingModel[indexPath.row].booking_Status == "Pending" ? DispatchQueue.main.async {
                        cell.accept_Deneid.isHidden = false;cell.statusLabel.isHidden = true; cell.statusImgView.isHidden = true;cell.payNow.isHidden = true;
                        } : DispatchQueue.main.async {
                            cell.statusLabel.isHidden = false; cell.statusImgView.isHidden = false;cell.payNow.isHidden = true; cell.accept_Deneid.isHidden = true;
                    }
                    } : self.searchBookingModel[indexPath.row].booking_Status == "Approved" ? DispatchQueue.main.async {
                        cell.statusLabel.isHidden = false; cell.statusImgView.isHidden = false;cell.payNow.isHidden = false; cell.accept_Deneid.isHidden = true;
                        } : DispatchQueue.main.async {
                            cell.statusLabel.isHidden = false; cell.statusImgView.isHidden = false;cell.payNow.isHidden = true; cell.accept_Deneid.isHidden = true;
                }
            }else{
                Singelton.sharedInstance.userDataModel.userRole != "ROLE_USER" ? DispatchQueue.main.async {
                    self.bookingRequestmodal[indexPath.row].booking_Status == "Pending" ? DispatchQueue.main.async {
                        cell.accept_Deneid.isHidden = false;cell.statusLabel.isHidden = true; cell.statusImgView.isHidden = true;cell.payNow.isHidden = true;
                        } : DispatchQueue.main.async {
                            cell.statusLabel.isHidden = false; cell.statusImgView.isHidden = false;cell.payNow.isHidden = true; cell.accept_Deneid.isHidden = true;
                    }
                    } : self.bookingRequestmodal[indexPath.row].booking_Status == "Approved" ? DispatchQueue.main.async {
                        cell.statusLabel.isHidden = false; cell.statusImgView.isHidden = false;cell.payNow.isHidden = false; cell.accept_Deneid.isHidden = true;
                        } : DispatchQueue.main.async {
                            cell.statusLabel.isHidden = false; cell.statusImgView.isHidden = false;cell.payNow.isHidden = true; cell.accept_Deneid.isHidden = true;
                }
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segment.selectedSegmentIndex == 1{
//            let param = "user=\(String(describing: self.chatListModal[indexPath.row].message_reciver_Id!))"
//            print("Parameter \(param)")
//            Singelton.sharedInstance.service.createChatDelegate = self
//            Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.createChat, api_Type: apiType.POST.rawValue)
            
            if searchClick{
                self.pushToChatController(userName: self.searchChatListModel[indexPath.row].message_RecieverName!, chatId: self.searchChatListModel[indexPath.row].message_ChatId!, reciverId: self.searchChatListModel[indexPath.row].message_reciver_Id!)
            }else{
                self.pushToChatController(userName: self.chatListModal[indexPath.row].message_RecieverName!, chatId: self.chatListModal[indexPath.row].message_ChatId!, reciverId: self.chatListModal[indexPath.row].message_reciver_Id!)
            }
        }
    }
    
    //MARK:- User Defined fucntion
    
    func setTheBookingRquestData(data : [[String : Any]]){
        self.bookingRequestmodal.removeAll()
        for index in 0...data.count - 1{
            let bookingModal = BookingRequestModal()
            bookingModal.booking_Status = (data[index])["bookingStatus"]as? String
            bookingModal.booking_Type = (data[index])["bookingType"]as? String
            bookingModal.booking_Description = (data[index])["description"]as? String
            bookingModal.booking_Id = (data[index])["id"]as? String
            bookingModal.booked_UserProfileImage = !(data[index]["profileImage"] is NSNull) ? (data[index])["profileImage"]as? String : ""
            bookingModal.booking_StorageId = (data[index])["storageId"]as? String
            bookingModal.user_id = (data[index])["userId"]as? String
            bookingModal.booking_UserName = (data[index])["userName"]as? String
            bookingModal.booking_StorageName = ((data[index])["storageName"]as? String)
            self.bookingRequestmodal.append(bookingModal)
        }
        reload_RequestList()
    }
    
    func setTheChatListData(data : [[String : Any]]){
        self.chatListModal.removeAll()
        print("Set the chat list modal")
        for index in 0...data.count - 1{
            let list = ChatListModal()
            list.message_ChatId = (data[index])["chatId"]as? String
            list.message_lastMessage = ((data[index])["lastMessage"]as? String)!.isEmpty ? "No message found" : (data[index])["lastMessage"]as? String
            list.message_RecieverImage = !(data[index]["profileImage"] is NSNull) ? (data[index])["profileImage"]as? String : ""
            list.message_Time = (data[index])["time"]as? String
            list.message_RecieverName = ((data[index])["userName"]as? String)
            list.message_reciver_Id = (data[index])["userId"]as? String
            self.chatListModal.append(list)
        }
        reload_RequestList()
    }
    
    func setTheUserRequestData(data : [[String : Any]]){
        self.bookingRequestmodal.removeAll()
        for index in 0...data.count - 1{
            let bookingModal = BookingRequestModal()
            bookingModal.booking_Status = (data[index])["bookingStatus"]as? String
            bookingModal.booking_Type = (data[index])["bookingType"]as? String
            bookingModal.booking_Description = ""
            bookingModal.booking_Id = (data[index])["id"]as? String
            bookingModal.booked_UserProfileImage = !(data[index]["profileImage"] is NSNull) ? (data[index])["profileImage"]as? String : ""
            bookingModal.booking_StorageId = (data[index])["storageId"]as? String
            bookingModal.user_id = (data[index])["hostId"]as? String
            bookingModal.booking_UserName = ((data[index])["hostName"]as? String)
            bookingModal.booking_StorageName = (data[index])["hostStorageName"]as? String
            self.bookingRequestmodal.append(bookingModal)
        }
        reload_RequestList()
    }
    
    
    func reload_RequestList(){
        DispatchQueue.main.async {
            self.noDataFound_View.isHidden = true
            self.bookingRequestList.delegate =  self
            self.bookingRequestList.dataSource =  self
            self.bookingRequestList.reloadData()
        }
    }
    
    func updateBookingRequest(status : String , bookingID : String){
        Singelton.sharedInstance.service.updateBookingRequestDelegate =  self
        let param = "bookingStatus=\(String(describing: status))&id=\(String(describing: bookingID))"
        print("upadte booking paramter \(param)")
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.updateBookingRequest, api_Type: apiType.POST.rawValue)
    }
    
    //MARK:- Actions
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if(segment.selectedSegmentIndex==0){
            self.getRequests()
            currentSegment = Strings_Const.request
            (segment.subviews[0] as UIView).tintColor = UIColor.red
        }else{
            print("Message API")
            self.messageList()
            currentSegment = Strings_Const.message
            (segment.subviews[0] as UIView).tintColor = UIColor.red
        }
    }
    
    
}
