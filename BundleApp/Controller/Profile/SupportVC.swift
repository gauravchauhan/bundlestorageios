
//
//  SupportVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 05/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SupportVC: UIViewController, UserSupportDelegate {
    
    //MARK :- Outlets
    
    @IBOutlet weak var agendaText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var agendaDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "Support")
    }
    
    //MARK:- Delegate
    
    func userSupport(data: [String : Any]) {
        Indicator.shared.hideProgressView()
        print("userSupport    \(data)")
        (data["status"]as! Bool) ? DispatchQueue.main.async {
            let alertController = UIAlertController(title: Strings_Const.app_Name, message: Strings_Const.contact_US , preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            _ = self.navigationController?.popViewController(animated: true)
            }
            // Add the actions
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            } : alert(message: Strings_Const.someError, Controller: self)
    }
    
    @IBAction func click_problemTypeBttn(_ sender: Any) {
        var actions:[[String:UIAlertAction.Style]] = []
        actions.append(["Dispute": UIAlertAction.Style.default])
        actions.append(["Misconduct": UIAlertAction.Style.default])
        actions.append(["other": UIAlertAction.Style.default])
        showActionsheet(viewController: self, title: Strings_Const.app_Name, message: "Please select from the below", actions: actions) { (index) in
            print("call action \(index)")
            if index == 0 {
                self.agendaText.text! = "Dispute"
            }else if index == 1{
                self.agendaText.text! = "Misconduct"
            }else if index == 2{
                self.agendaText.text! = "other"
            }
        }
    }
    
    @IBAction func click_SubmitBttn(_ sender: Any) {
        guard let agenda : String = self.agendaText.text , agenda != "" else {
            return alert(message: "Please select agenda", Controller: self)
        }
        guard let desc : String = self.agendaDescription.text , desc != "" else {
            return alert(message: "Please enter description", Controller: self)
        }
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.userSupportDelegate =  self
        let param = "problemTypes=\(String(describing: self.agendaText.text!))&problem=\(String(describing: self.agendaDescription.text!))"
        print("support parameter \(param)")
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.userSupport, api_Type: apiType.POST.rawValue)
    }
}
