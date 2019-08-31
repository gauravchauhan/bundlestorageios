//
//  NWSImageToken.swift
//  BundleApp
//
//  Created by Rohit Gupta on 28/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import NWSTokenView

open class NWSImageToken: NWSToken {

    
    @IBOutlet weak var titleLabel: UILabel!
  
    
    open class func initWithTitle(_ title: String) -> NWSImageToken?
    {
        if let token = UINib(nibName: "NWSImageToken", bundle:nil).instantiate(withOwner: nil, options: nil)[0] as? NWSImageToken
        {
            token.backgroundColor = UIColor(hex: Constants.Colors.lightGrayColor, alpha: 1)
            let oldTextWidth = token.titleLabel.bounds.width
            token.titleLabel.text = title
            token.titleLabel.font = UIFont(name: Constants.fonts.ProximaNova_Semibold, size: 11)
            token.titleLabel.backgroundColor = UIColor(hex: Constants.Colors.lightGrayColor, alpha: 1)
            token.titleLabel.sizeToFit()
            token.titleLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
            let newTextWidth = token.titleLabel.bounds.width

            token.layer.cornerRadius = 12.0
            token.clipsToBounds = true
            
            // Resize to fit text
            token.frame.size = CGSize(width: token.frame.size.width+(newTextWidth-oldTextWidth), height: token.frame.height)
           // token.setNeedsLayout()
            token.frame = token.frame
            
            return token
        }
        return nil
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
