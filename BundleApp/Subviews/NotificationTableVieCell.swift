//
//  NotificationTableVieCell.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class NotificationTableVieCell: UITableViewCell {
    
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationContent: UILabel!
    @IBOutlet weak var notificationTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
