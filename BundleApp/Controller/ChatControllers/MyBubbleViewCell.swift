//
//  ChatViewController.swift
//  BundleApp
//
//  Created by rohit on 30/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class MyBubbleViewCell: UITableViewCell {
    
     //MARK:- Outlets
    @IBOutlet weak var lbText: UILabel?
    @IBOutlet weak var lbTime: UILabel!
    
    weak var gestureTarget:BubbleViewCellEventDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(longTap(sender:)))
        longPressed.delegate = self
        self.lbText?.addGestureRecognizer(longPressed)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setBubbleData(data:LynnBubbleData) {
        
        self.lbText!.text = data.text
        self.lbTime.text = data.date._stringFromDateFormat(Constants.Format.TIME)
        
    }
    
    @objc func longTap(sender : UIGestureRecognizer){
        print("Long tap")
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
            self.gestureTarget?.textLongPressed(cell: self)
//            self.gestureTarget?.textLongPressed?(cell:self, text:self.lbText!.text!)
        }
    }
    
//    func textLongPressed() {
//        
//    }
    
}
