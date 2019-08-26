//
//  HostListTableViewCell.swift
//  BundleApp
//
//  Created by Vijay Mishra on 23/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class HostListTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var spaceName: UILabel!
    @IBOutlet weak var spaceType: UILabel!
    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var spaceDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
