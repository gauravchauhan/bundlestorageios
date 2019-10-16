//
//  ChatViewController.swift
//  BundleApp
//
//  Created by rohit on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class Someone_sBubbleViewCell: MyBubbleViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var constraintForNickHidden: NSLayoutConstraint! // default 24 when hidden set 0
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var message_Time: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setBubbleData(data:LynnBubbleData, grouping:Bool, showNickName:Bool) {
        print(" in  setBubbleData   \(data)")
        print("Sender image \(Constants.AppUrls.baseUrl + Constants.AppUrls.showImage + Singelton.sharedInstance.senderImage)")
        self.userImage.setImageWith(URL(string : Constants.AppUrls.baseUrl + Constants.AppUrls.showImage + Singelton.sharedInstance.senderImage  ), placeholderImage: UIImage(named: "app_Logo"))
        self.message.text! = data.text!
        self.message_Time.text = data.date._stringFromDateFormat(Constants.Format.TIME)
        
//        self.setBubbleData(data: data)
    }
    
    override func setBubbleData(data: LynnBubbleData) {
        
        super.setBubbleData(data: data)
        
//        self.imgProfile.image = data.userData.userProfileImage
        
    }
    @objc func actProfile(sender : UIGestureRecognizer){
        self.gestureTarget?.userProfilePressed(cell: self)
    }
}
