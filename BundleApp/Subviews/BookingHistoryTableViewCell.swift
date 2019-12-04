//
//  BookingHistoryTableViewCell.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var storageImage: UIImageView!
    @IBOutlet weak var storageTitle: UILabel!
    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var status: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
