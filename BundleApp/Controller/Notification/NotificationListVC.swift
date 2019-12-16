
//
//  NotificationListVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class NotificationListVC: UIViewController , UITableViewDelegate, UITableViewDataSource, GetNotificationListDelegate, RemoveNotificationDelegate, RemoveParticularNotificationDelegate{
    
    @IBOutlet weak var notificationList: UITableView!
    @IBOutlet weak var notNotificaon: UILabel!
    
    var notificationModal = [NotificatioModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.removeNotificationDelegate =  self
        self.getNotification()
        self.notificationList.register(UINib(nibName:"NotificationCell" , bundle: nil), forCellReuseIdentifier: "NotificationTableVieCell")
        setBackButtonWithTitle(title: "Notification list")
        self.setDeleteAllNotificationButton()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Delegate
    
    func removeParticularNotificationResponse(data: [String : Any]) {
        print("remove one notification \(data)")
    }
    
    func removeNotificationResponse(data: [String : Any]) {
        print("remove all notification \(data)")
        //Indicator.shared.showProgressView(self.view)
        (data["status"]as! Bool) ? self.getNotification() : alert(message: Strings_Const.someError, Controller: self)
    }
    
    func getNotificationListResponse(data: [String : Any]) {
        Indicator.shared.hideProgressView()
        print("Norificaion list \(data)")
        (data["data"]as! [[String : Any]]).count != 0 ? DispatchQueue.main.async {
            self.notificationList.isHidden =  false;self.notNotificaon.isHidden = true;self.setNotificatioNModal(data : data["data"]as! [[String : Any]])
            } : DispatchQueue.main.async {
                self.notificationList.isHidden =  true;self.notNotificaon.isHidden = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationModal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.notificationList.dequeueReusableCell(withIdentifier: "NotificationTableVieCell", for: indexPath)as! NotificationTableVieCell
        cell.notificationTitle.text! = self.notificationModal[indexPath.row].notification_Title!
        cell.notificationContent.text! = self.notificationModal[indexPath.row].notification_Description!
        cell.notificationTime.text! = self.notificationModal[indexPath.row].notification_Time!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected history cell")
    }
    
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .normal, title: "" , handler: { (action,view,completionHandler ) in
            //do stuff
            completionHandler(true)
            print("Delete tapped")

            let param = "notificationId=\(String(describing: self.notificationModal[indexPath.row].notification_ID!))"
            Singelton.sharedInstance.service.removeParticularNotificationDelegate =  self
            Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.removeNotification, api_Type: apiType.POST.rawValue)
            self.notificationModal.remove(at: indexPath.row)
            self.reloadNotificationList()
        })
        action.image = UIImage(named: "delete")
        action.backgroundColor = UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0)
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }
    
    
    //MARK:-  use Defined function
    
    func getNotification(){
        Singelton.sharedInstance.service.getNotificationListDelegate =  self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.getAllNotifications, api_Type: apiType.GET.rawValue)
    }
    
    
    func setNotificatioNModal(data : [[String : Any]]){
        self.notificationModal.removeAll()
        for index in 0...data.count - 1{
            let notificationObj = NotificatioModal()
            notificationObj.notification_Time = (data[index]["createdAt"]as? String)
            notificationObj.notification_ID = (data[index]["id"]as? String)
            notificationObj.notification_Description = (data[index]["data"]as! [String : Any])["message"]as? String
            notificationObj.notification_Title = ((data[index]["data"]as! [String : Any])["title"]as? String)?.capitalized
            self.notificationModal.append(notificationObj)
        }
        self.reloadNotificationList()
    }
    
    func reloadNotificationList(){
        DispatchQueue.main.async {
            self.notificationList.delegate =  self
            self.notificationList.dataSource = self
            self.notificationList.reloadData()
        }
    }
}
