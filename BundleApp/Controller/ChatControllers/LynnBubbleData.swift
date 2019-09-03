//
//  ChatViewController.swift
//  BundleApp
//
//  Created by rohit on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

extension Date {
    
    func _stringFromDateFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        let language = Bundle.main.preferredLocalizations.first! as String
        formatter.locale = Locale(identifier: language)
        formatter.dateFormat = format;
        return formatter.string(from: self)
    }
}

public enum BubbleDataType: Int {
    case none = -1
    case me = 0
    case someone
}

//extension BubbleDataType: Equatable {}
//public func ==(lhs: BubbleDataType, rhs: BubbleDataType) -> Bool {
//    return lhs.rawValue == rhs.rawValue
//}


public class LynnUserData :NSObject {
    
    private(set) public var userProfileImage: UIImage?
    private(set) public var userID:String
    private(set) public var userNickName:String?
    public var userInfo: AnyObject?
    
    init(userUniqueId userId:String, userNickName nick:String? = nil, userProfileImage profileImg:UIImage? = nil, additionalInfo userInfo:AnyObject? = nil) {
        
        self.userID = userId
        self.userNickName = nick
        self.userProfileImage = profileImg
        self.userInfo = userInfo
        
        super.init();
    }
}


public class LynnBubbleData: NSObject {
    
    private(set) public var userDataType:BubbleDataType = .none
    private(set) public var userData:LynnUserData = LynnUserData(userUniqueId: "")
    
    private(set) public var text:String?
    private(set) public var date:Date = Date()
    
 //   private(set) public var imageData: LynnAttachedImageData?
    
    convenience init(userData:LynnUserData, dataOwner type:BubbleDataType,
                     message text:String?, messageDate date:Date) {
        
        self.init()
        
        self.userDataType = type
        self.userData = userData
        self.text = text
        self.date = date
    }
    
    func isSameUser(_ data:LynnBubbleData) -> Bool {
        return self.userData.userID == data.userData.userID
    }
}


