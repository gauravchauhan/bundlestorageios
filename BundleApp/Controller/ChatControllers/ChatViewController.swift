//
//  ChatViewController.swift
//  BundleApp
//
//  Created by rohit on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, LynnBubbleViewDataSource {
   
    //MARK:- Outlets
    @IBOutlet weak var messageTextView: UITextField!
    @IBOutlet weak var tableView: LynnBubbleTableView!
    @IBOutlet weak var message: TextField!
    
    var userName : String!
    
    //MARK:- Properties
     var arrChatTest:Array<LynnBubbleData> = []
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bubbleDelegate = self
        tableView.bubbleDataSource = self
        self.setBackButtonWithTitle(title: self.userName)
        Indicator.shared.showProgressView(self.view)
        DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string: Singelton.sharedInstance.userDataModel.userProfilePic!)!)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)!
                    print("Print image Data  \(self.image)")
                        Indicator.shared.hideProgressView()
                }
            }
            catch {
                // error
            }
        }
        
//        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- Delegate Methods
    
    func bubbleTableView(dataAt index: Int, bubbleTableView: LynnBubbleTableView) -> LynnBubbleData {
        return self.arrChatTest[index]
    }
    
    func bubbleTableView(numberOfRows bubbleTableView: LynnBubbleTableView) -> Int {
        return self.arrChatTest.count
    }
    
    func testChatData () {
       
        var messageMine = "Hi Elizabeth, what's do you have on this weekend? "
        var messageSomeone = "Urgent Work"
        
        let userMe = LynnUserData(userUniqueId: "123", userNickName: "me", userProfileImage: self.image, additionalInfo: nil)
        let userSomeone = LynnUserData(userUniqueId: "234", userNickName: "you", userProfileImage: UIImage(named: "ico_girlprofile"), additionalInfo: nil)
        let yesterDay = Date().addingTimeInterval(-60*60*24)
        for index in 0..<10 {
            
            if index % 4 == 0 {
                
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userMe, dataOwner: .me, message: messageMine, messageDate: yesterDay)
                
                self.arrChatTest.append(bubbleData)
                messageMine += " " + messageMine
            }else {
                
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: messageSomeone, messageDate: yesterDay)
                self.arrChatTest.append(bubbleData)
                messageSomeone += " " + messageSomeone
            }
            
        }
        
        messageMine = "Start Conversation by your name Please."
        messageSomeone = "Heelo Joe!"
        let tommorow = Date().addingTimeInterval(60*60*24)
        
        for index in 0..<10 {
            
            if index % 4 == 0 {
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userMe, dataOwner: .me, message: messageMine, messageDate: tommorow)
                
                self.arrChatTest.append(bubbleData)
                messageMine += " | " + messageMine
            }else {
                let bubbleData:LynnBubbleData = LynnBubbleData(userData: userSomeone, dataOwner: .someone, message: messageSomeone, messageDate: tommorow)
                self.arrChatTest.append(bubbleData)
                messageSomeone += " | " + messageSomeone
            }
            
        }
        self.tableView.reloadData()
    }
    
    
    @IBAction func click_SendMessageButton(_ sender: Any) {
        print("Click send button")
        guard let message : String = self.message.text , message != "" else {
            return alert(message: Strings_Const.message_empty, Controller: self)
        }
        let userMe = LynnUserData(userUniqueId: "123", userNickName: "roh_JFT", userProfileImage: self.image , additionalInfo: nil)
        let bubbleData:LynnBubbleData = LynnBubbleData(userData: userMe, dataOwner: .me, message: self.message.text!, messageDate: Date())
        print("send message data \(bubbleData)   \(userMe)")
        self.arrChatTest.append(bubbleData)
        self.tableView.reloadData()
        self.tableView.scrollToLastRow()
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

