//
//  StatusViewCell.swift
//  BundleApp
//
//  Created by rohit on 03/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

protocol ClickRateDelegate {
    func click_Rate(_ cell: UITableViewCell, didPressButton: UIButton)
}

class StatusViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var curretnStatus: UILabel!
    
    @IBOutlet weak var statusButton: UIButton!
    
    var rateClickDelgate : ClickRateDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.userImage.layer.masksToBounds =  true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click_RateButton(_ sender: UIButton) {
        rateClickDelgate.click_Rate(self, didPressButton: sender)
    }
    
    
}
