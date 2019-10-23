//
//  PaymentStatusController.swift
//  BundleApp
//
//  Created by rohit on 04/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class PaymentStatusController: UIViewController {
    
    
    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var stoargeAddress: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    var paymentDetailModal = SummaryModal()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: " ");setPaymentData()
    }
    
    
    func setPaymentData(){
        print("setPaymentData  \(self.paymentDetailModal.storage_Address!)")
        DispatchQueue.main.async {
            self.stoargeAddress.text! = self.paymentDetailModal.storage_Address!
            self.hostName.text! = self.paymentDetailModal.storage_hostName!
            self.totalAmount.text! = self.paymentDetailModal.storage_TotalPrice!
            self.hostImage.setImageWith(URL(string : self.paymentDetailModal.storage_HostImage!), placeholderImage: UIImage(named: "app_Logo"))
            self.startDate.text! = self.paymentDetailModal.storage_storageDate!
        }
    }
}
