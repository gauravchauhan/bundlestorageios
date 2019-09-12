//
//  MessageViewCell.swift
//  BundleApp
//
//  Created by rohit on 02/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class RequestViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func payNowButtonClicked(_ sender: UIButton) {
        
    }
    
}
