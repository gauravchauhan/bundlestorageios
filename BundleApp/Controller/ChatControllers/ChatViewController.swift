//
//  ChatViewController.swift
//  BundleApp
//
//  Created by rohit on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import SocketIO

private struct SendMessage {
    var message : String
    var chatId : String
    var userId : String
    var receiverId : String!
    func toDictionary()-> NSDictionary{
        return ["message": message, "chatId": chatId ,"userId": userId , "receiverId" : receiverId]
    }
}

class ChatViewController: UIViewController, LynnBubbleViewDataSource, GetChatHistoryDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var messageTextView: UITextField!
    @IBOutlet weak var tableView: LynnBubbleTableView!
    @IBOutlet weak var message: TextField!
    
    var userName : String!
    var chatID : String?
    var hostId : String?
    
    
    var chatHistoryModal = [ChatListModal]()
    
    //    var hostDetailModal = StorageListModal()
    
    //MARK:- Properties
    var chat_Array:Array<LynnBubbleData> = []
    var image = UIImage()
    let manager = SocketManager(socketURL: URL(string: Constants.AppUrls.baseUrl)!, config: [.log(true), .compress])
    var userMe : LynnUserData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bubbleDelegate = self
        tableView.bubbleDataSource = self
        self.setBackButtonWithTitle(title: self.userName)
        Indicator.shared.showProgressView(self.view)
        self.connectToSocket()
//        DispatchQueue.global(qos: .background).async {
//            do
//            {
//                let data = try Data.init(contentsOf: URL.init(string: Singelton.sharedInstance.userDataModel.userProfilePic!)!)
//                DispatchQueue.main.async {
////                    self.image = UIImage(data: data)!
//                    print("Print image Data  \(self.image)")
//                    //                    self.userMe = LynnUserData(userUniqueId: Singelton.sharedInstance.userDataModel.userID!, userNickName: Singelton.sharedInstance.userDataModel.userFirstName! + Singelton.sharedInstance.userDataModel.userLastName!, userProfileImage: self.image , additionalInfo: nil)
//                    //                    let param = "chatId=\(String(describing: self.chatID!))"
//                    //                    print("Parameter \(param)")
//                    //                    Singelton.sharedInstance.service.getChatHistoryDelegate = self
//                    //                    Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.chatHistory, api_Type: apiType.POST.rawValue)
//                }
//            }
//            catch {
//                // error
//            }
//        }
        
        self.userMe = LynnUserData(userUniqueId: Singelton.sharedInstance.userDataModel.userID!, userNickName: Singelton.sharedInstance.userDataModel.userFirstName! + Singelton.sharedInstance.userDataModel.userLastName!, userProfileImage: nil , additionalInfo: nil)
        let param = "chatId=\(String(describing: self.chatID!))"
        print("Parameter \(param)")
        Singelton.sharedInstance.service.getChatHistoryDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.chatHistory, api_Type: apiType.POST.rawValue)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        manager.disconnect()
    }
    
    
    //MARK:- user Defined function
    
    func connectToSocket(){
        DispatchQueue.main.async {
            let socket = self.manager.defaultSocket
            socket.on(clientEvent: .connect) {data, ack in
            }
            self.socketData()
            socket.connect()
        }
    }
    
    func socketEmit(messageDict : NSDictionary){
        DispatchQueue.main.async {
            let socket = self.manager.defaultSocket
            socket.emit(self.chatID!, messageDict)
            self.message.text! = ""
        }
    }
    
    func socketData(){
        let socket = self.manager.defaultSocket
        socket.on("\(self.chatID!)client") {data, ack in
            print("Socket Data \(data)")
            self.socketResponse(Data: data)
        }
    }
    
    
    func socketResponse(Data : [Any]){
        print("")
        let messageDict = (Data[0]as! [String : Any])
        print("message distionary   \(messageDict)")
        let status = (messageDict["userId"]as! String == Singelton.sharedInstance.userDataModel.userID!)
        if !status{
            Singelton.sharedInstance.senderImage = !(messageDict["profileImage"]is NSNull) ? messageDict["profileImage"]as? String : ""
            let bubbleData:LynnBubbleData = LynnBubbleData(userData: self.userMe, dataOwner: status ? .me : .someone , message: messageDict["message"]as? String , messageDate: Date())
            self.chat_Array.append(bubbleData)
            self.tableView.reloadData()
            //            self.tableView.scrollToLastRow()
        }
    }
    
    //MARK:- Delegate Methods
    
    func getChatHistoryResponse(data: [String : Any]) {
        print("chat Hitory  \(data)")
        data["status"]as! Bool ? self.setChatHistoryData(data: data["message"]as! [[String :  Any]]) : Indicator.shared.hideProgressView()
    }
    
    func bubbleTableView(dataAt index: Int, bubbleTableView: LynnBubbleTableView) -> LynnBubbleData {
        return self.chat_Array[index]
    }
    
    func bubbleTableView(numberOfRows bubbleTableView: LynnBubbleTableView) -> Int {
        return self.chat_Array.count
    }
    
    
    func setChatHistoryData(data : [[String : Any]]){
        self.chatHistoryModal.removeAll()
        print("Set the chat list modal")
        Singelton.sharedInstance.senderImage = !((data[0])["profileImage"] is NSNull) ? (data[0])["profileImage"]as? String : ""
        for index in 0...data.count - 1{
            
            let status = (data[index])["userId"]as? String == Singelton.sharedInstance.userDataModel.userID!
            let bubbleData:LynnBubbleData = LynnBubbleData(userData: self.userMe, dataOwner: status ? .me : .someone , message: (data[index])["message"]as? String, messageDate: Date())
            self.chat_Array.append(bubbleData)
        }
        
        DispatchQueue.main.async {
//            self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - UIScreen.main.bounds.height), animated: true)
            self.tableView.reloadData()
            print("nimber of sections  \(self.tableView.numberOfSections)    \(self.tableView.numberOfRows(inSection: 0))   \(self.tableView.numberOfSections(in: self.tableView))")
            Indicator.shared.hideProgressView()
        }
    }
    
    func scrollToBottom()  {
//        let point = CGPoint(x: 0, y: self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.frame.height)
//        if point.y >= 0{
//            self.tableView.setContentOffset(point, animated: true)
//        }
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 7 , section: 2)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    @IBAction func click_SendMessageButton(_ sender: Any) {
        print("Click send button")
        guard let message : String = self.message.text , message != "" else {
            return alert(message: Strings_Const.message_empty, Controller: self)
        }
        self.appendMessageToChatArray(senderStatus: true, message: self.message.text!)
    }
    
    
    func appendMessageToChatArray(senderStatus : Bool , message : String ){
        let bubbleData:LynnBubbleData = LynnBubbleData(userData: self.userMe, dataOwner: senderStatus ? .me : .someone , message: message, messageDate: Date())
        let sendMessage = SendMessage(message: self.message.text!, chatId: self.chatID!, userId: Singelton.sharedInstance.userDataModel.userID!, receiverId: self.hostId!)
        self.socketEmit(messageDict: sendMessage.toDictionary())
        self.chat_Array.append(bubbleData)
        self.tableView.reloadData()
        //        self.tableView.scrollToLastRow()
    }
    
}


extension ChatViewController : LynnBubbleViewDelegate {
    // optional
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didSelectRowAt index: Int) {
        
    }
    
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didLongTouchedAt index: Int) {
        
    }
    
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didTouchedAttachedImage image: UIImage, at index: Int) {
        
    }
    
    func bubbleTableView(_ bubbleTableView: LynnBubbleTableView, didTouchedUserProfile userData: LynnUserData, at index: Int) {
    }
    
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

