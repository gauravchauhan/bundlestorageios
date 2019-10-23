//
//  PaymentDetailController.swift
//  BundleApp
//
//  Created by rohit on 11/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree

class PaymentDetailController: UIViewController , StorageSummaryDelegate, GetClientTokenDelegate, SendNonceDelegate{

    //MARK:- Outlets
    @IBOutlet weak var dashedView: UIView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var payNowButton: UIButton!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var Storage_Description: UILabel!
    @IBOutlet weak var storag_Price: UILabel!
    @IBOutlet weak var bunndle_Fee_Price: UILabel!
    @IBOutlet weak var discount_Price: UILabel!
    
    @IBOutlet weak var host_Discount: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var total_Price: UILabel!
    @IBOutlet weak var durations: UILabel!
    
    var clientToken : String?
    var storageID : String?
    var bookingID : String?
    
    //MARK:- Properties
    let uncheckImage = UIImage(named: Image.CheckBox_Blank)
    let checkImage = UIImage(named: Image.CheckBox_Fill)
    var summaryModal = SummaryModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Indicator.shared.showProgressView(self.view)
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.lightGray.cgColor
        yourViewBorder.lineDashPattern = [3]
        yourViewBorder.frame = dashedView.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: dashedView.bounds).cgPath
        dashedView.layer.addSublayer(yourViewBorder)
        // Do any additional setup after loading the view.
        payNowButton.isEnabled = false
        payNowButton.alpha = 0.5
        offerLabel.font = offerLabel.font.italic
        setBackButtonWithTitle(title: "Summary")
        let param = "storageId=\(String(describing: self.storageID! ))&id=\(String(describing: self.bookingID!))"
        print("Param \(param)")
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.storageSummaryDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.storageSummery, api_Type: apiType.POST.rawValue)
    }
    
    
    func sendNonceResponse(data: [String : Any]) {
        print("sendNonceResponse   \(data)")
        data["status"]as! Bool ?  self.pushToThankYouController(summarymodal: self.summaryModal) : alert(message: data["message"]as! String, Controller: self)
    }
    
    func getClientTokenResponse(data: [String : Any]) {
        print("vgetClientTokenResponse   \(data)")
        Indicator.shared.hideProgressView()
        data["status"]as! Bool ? DispatchQueue.main.async {
            (self.clientToken = data["clientToken"]as? String);
            self.showDropIn(clientTokenOrTokenizationKey: self.clientToken!)
            } : nil
    }
    
    
    func storageSummaryResponse(data: [String : Any]) {
        Indicator.shared.hideProgressView()
        print("storageSummaryResponse   \(data)")
        if data["status"]as! Bool{
            DispatchQueue.main.async {
                
                self.summaryModal.storage_Address = (data["storageDetail"]as! [String : Any])["address"]as? String
                self.summaryModal.storage_Charge = "\((data["storageDetail"]as! [String : Any])["storageprice"]as! Double)"
                self.summaryModal.storage_Description = (data["storageDetail"]as! [String : Any])["description"]as? String
                self.summaryModal.storage_DiscountPrice = "\((data["storageDetail"]as! [String : Any])["discountprice"]as! Double)"
                self.summaryModal.storage_DiscountValue = ((data["storageDetail"]as! [String : Any])["discount"]as! String)
                self.summaryModal.storage_Duration = ((data["storageDetail"]as! [String : Any])["duration"]as! String)
                self.summaryModal.storage_HostImage = ((data["storageDetail"]as! [String : Any])["hostprofileImage"]as! String)
                self.summaryModal.storage_storageDate = ((data["storageDetail"]as! [String : Any])["bookingStartDate"]as! String)
                self.summaryModal.storage_hostName = ((data["storageDetail"]as! [String : Any])["hostname"] is NSNull) ? "" :  ((data["storageDetail"]as! [String : Any])["hostname"]as! String)
                 
                self.host_Discount.text! = "(" + ((data["storageDetail"]as! [String : Any])["discount"]as! String) + "%)"
                self.duration.text! = "Duration: " + ((data["storageDetail"]as! [String :    Any])["duration"]as! String)
                self.address.text! = (data["storageDetail"]as! [String : Any])["address"]as! String
                self.Storage_Description.text! = (data["storageDetail"]as! [String : Any])["description"]as! String
                self.storag_Price.text! = "$" + "\((data["storageDetail"]as! [String : Any])["storageprice"]as! Double)"
                self.bunndle_Fee_Price.text! = "+$" + "\((data["storageDetail"]as! [String : Any])["bunDleCharge"]as! Double)"
                
                let totalValaue = (data["storageDetail"]as! [String : Any])["totalprice"]as! CGFloat
                let total_Price = String(format: "%.2f", totalValaue)
                self.total_Price.text! = "$" + "\(total_Price)"
                self.summaryModal.storage_TotalPrice = "\(total_Price)"
                self.discount_Price.text! = "-$" + "\((data["storageDetail"]as! [String : Any])["discountprice"]as! Double)"
                self.durations.text! = "(" + ((data["storageDetail"]as! [String : Any])["duration"]as! String) + ")"
            }
        }
    }
    
    @IBAction func payNowButtonClicked(_ sender: UIButton) {
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.getClientTokenDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.client_token, api_Type: apiType.GET.rawValue)
    }
    
    @IBAction func agreeButtonClicked(_ sender: UIButton) {
        if agreeButton.image(for: .normal) == uncheckImage{
            agreeButton.setImage(checkImage, for: .normal)
            payNowButton.isEnabled = true
            payNowButton.alpha = 1.0
        }else{
            agreeButton.setImage(uncheckImage, for: .normal)
            payNowButton.isEnabled = false
            payNowButton.alpha = 0.5
        }
    }
    
    //MARK:- Brain tree dropin function
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR   \(error.debugDescription)")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                print("result \(String(describing: result.paymentMethod!.nonce))")
                let param = "paymentMethodNonce=\(String(describing: result.paymentMethod!.nonce ))&amount=\(String(describing: self.total_Price.text!.replacingOccurrences(of: "$", with: "") ))&booking=\(String(describing: self.bookingID!))"
                print("Param \(param)")
                Singelton.sharedInstance.service.sendNonceDelegate = self
                Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.sendNonce, api_Type: apiType.POST.rawValue)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }

}
