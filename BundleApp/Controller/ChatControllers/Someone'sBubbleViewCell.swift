//
//  ChatViewController.swift
//  BundleApp
//
//  Created by rohit on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class Someone_sBubbleViewCell: MyBubbleViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var constraintForNickHidden: NSLayoutConstraint! // default 24 when hidden set 0
    
    
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
        
        self.imgProfile.isHidden = grouping
        self.setBubbleData(data: data)
    }
    
    override func setBubbleData(data: LynnBubbleData) {
        
        super.setBubbleData(data: data)
        
//        self.imgProfile.image = data.userData.userProfileImage
        
    }
    @objc func actProfile(sender : UIGestureRecognizer){
        self.gestureTarget?.userProfilePressed(cell: self)
    }
}
