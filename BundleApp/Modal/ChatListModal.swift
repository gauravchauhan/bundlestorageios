//
//  ChatListModal.swift
//  BundleApp
//
//  Created by Vijay Mishra on 15/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import Foundation

class ChatListModal{
    /*chatId = "6041ddc5-1c42-4411-8686-8243d43fb351";
     lastMessage = hello;
     time = "10:28 AM";
     userName = "undefined undefined";*/
    
    private var chatId : String!
    private var lastMessage : String!
    private var time : String!
    private var userName : String!
    private var image : String!
    private var reciver_Id : String!
    
    var message_reciver_Id : String?{
        get{
            return reciver_Id
        }
        set{
            self.reciver_Id = newValue
        }
    }
    
    
    var message_ChatId : String?{
        get{
            return chatId
        }
        set{
            self.chatId = newValue
        }
    }
    
    var message_lastMessage : String?{
        get{
            return lastMessage
        }
        set{
            self.lastMessage = newValue
        }
    }
    
    var message_Time : String?{
        get{
            return time
        }
        set{
            self.time = newValue
        }
    }
    
    
    var message_RecieverName : String?{
        get{
            return userName
        }
        set{
            self.userName = newValue
        }
    }
    var message_RecieverImage : String?{
        get{
            return Constants.AppUrls.baseUrl + Constants.AppUrls.showImage + image
        }
        set{
            self.image = newValue
        }
    }
}
