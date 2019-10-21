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

class PaymentDetailController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var dashedView: UIView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var payNowButton: UIButton!
    
    
    var clientToken : String?
    
    //MARK:- Properties
    let uncheckImage = UIImage(named: Image.CheckBox_Blank)
    let checkImage = UIImage(named: Image.CheckBox_Fill)
    
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
        fetchClientToken()
    }
    
    
    
    @IBAction func payNowButtonClicked(_ sender: UIButton) {
        self.showDropIn(clientTokenOrTokenizationKey: self.clientToken!)
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
    
    
    func fetchClientToken() {
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            Indicator.shared.hideProgressView()
            self.clientToken = String(data: data!, encoding: String.Encoding.utf8)
            print("clientToken   \(String(describing: self.clientToken))")
            //            self.showDropIn(clientTokenOrTokenizationKey: clientToken!)
            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
            }.resume()
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        //        request.applePayDisabled = true
        print("client token \(clientTokenOrTokenizationKey)")
        
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR   \(error.debugDescription)")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                print("result \(String(describing: result.paymentMethod?.nonce))")
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }

}
