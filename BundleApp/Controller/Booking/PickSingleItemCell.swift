//
//  PickSingleItemCell.swift
//  BundleApp
//
//  Created by rohit on 12/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class PickSingleItemCell: UITableViewCell {

    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var ItemDesclabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
