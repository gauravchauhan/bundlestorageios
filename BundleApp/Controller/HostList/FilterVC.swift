//
//  FilterVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 11/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet weak var hostName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var storageType: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var length: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var width: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var locatio_Value: UILabel!
    @IBOutlet weak var price_Value: UILabel!
    @IBOutlet weak var rating_Value: UILabel!
    @IBOutlet weak var locationSlider: UISlider!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var ratingSlider: UISlider!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "Filter")
        self.locatio_Value.text! = "\(Int(self.locationSlider.value))" + "mt"
        self.price_Value.text! = "$" + "\(Int(self.priceSlider.value))"
        self.rating_Value.text! = "\(Int(self.ratingSlider.value))" + " /5"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func localtion_Slider(_ sender: Any) {
        self.locatio_Value.text! = "\(Int(self.locationSlider.value))" + "mt"
    }
    
    
    @IBAction func price_Slider(_ sender: Any) {
        self.price_Value.text! = "$" + "\(Int(self.priceSlider.value))"
    }
    

    @IBAction func rating_Slider(_ sender: Any) {
        self.rating_Value.text! = "\(Int(self.ratingSlider.value))" + " /5"
    }
}
