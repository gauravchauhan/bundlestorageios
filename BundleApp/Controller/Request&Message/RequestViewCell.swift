//
//  MessageViewCell.swift
//  BundleApp
//
//  Created by rohit on 02/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

protocol UpdateBookingRequest {
    func click_PayNow(_ cell: UITableViewCell, didPressButton: UIButton)
    func click_Approved(_ cell: UITableViewCell, didPressButton: UIButton)
    func click_Cancel(_ cell: UITableViewCell, didPressButton: UIButton)
}

class RequestViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var storageName: UILabel!
    @IBOutlet weak var accept_Deneid: UIStackView!
    @IBOutlet weak var payNow: UIButton!
    
    
    var requestDelagate : UpdateBookingRequest!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func payNowButtonClicked(_ sender: UIButton) {
        requestDelagate.click_PayNow(self, didPressButton: sender)
    }
    
    @IBAction func click_Approved(_ sender: UIButton) {
        requestDelagate.click_Approved(self, didPressButton: sender)
    }
    
    
    @IBAction func click_Cancel(_ sender: UIButton) {
        requestDelagate.click_Cancel(self, didPressButton: sender)
    }
    
    
}
