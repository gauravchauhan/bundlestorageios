//
//  PaymentDetailController.swift
//  BundleApp
//
//  Created by rohit on 11/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class PaymentDetailController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var dashedView: UIView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var payNowButton: UIButton!
    
    //MARK:- Properties
    let uncheckImage = UIImage(named: Image.CheckBox_Blank)
    let checkImage = UIImage(named: Image.CheckBox_Fill)
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    
    
    @IBAction func payNowButtonClicked(_ sender: UIButton) {
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
