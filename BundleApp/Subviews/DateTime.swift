//
//  DateTime.swift
//  DROR
//
//  Created by Rohit Gupta on 11/12/18.
//  Copyright © 2018 Rohit Gupta. All rights reserved.
//

import UIKit
protocol DateTimeDelegate {
    func doneBtnPressed()
    func cancelBtnPressed()
}

class DateTime: UIView {

    @IBOutlet var pickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate : DateTimeDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("DateTime", owner: self, options: nil)
        
        self.addSubview(pickerView)
        
        datePicker.timeZone = NSTimeZone.local
            }
    
    @IBAction func click_Cancel(_ sender: Any) {
        delegate.cancelBtnPressed()
    }
    
    @IBAction func click_Done(_ sender: Any) {
        delegate.doneBtnPressed()
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        
        
    }
    
    
}
