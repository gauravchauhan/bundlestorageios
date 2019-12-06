//
//  ScanQRVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class ScanQRVC: UIViewController, QRScannerViewDelegate, QRCodeDelegate {

    @IBOutlet weak var scannerView: QRScannerView!{
        didSet {
            scannerView.delegate = self
        }
    }
    
    var storageID : String?
    var bookingID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "Scan QR code")
        print("Coming QR code \(storageID!)")
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    func QRCodeResponse(data: [String : Any]) {
        print("QRCodeResponse   \(data)")
        (data["status"]as! Bool) ? DispatchQueue.main.async {
            let alertController = UIAlertController(title: Strings_Const.app_Name, message: "Congratulation, Qr code successfully matched." , preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                _ = self.navigationController?.popViewController(animated: true)
            }
            // Add the actions
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            } : alert(message: "QR code not match, Please check and try again", Controller: self)
    }
    

    func qrScanningDidStop() {
         print("Scanner did stop")
    }
    
    func qrScanningDidFail() {
       // presentAlert(withTitle: "Error", message: "Scanning Failed. Please try again")
        print("Scanner did fail")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        print("Scan data \(String(describing: str!))")
        print("\(self.storageID! == str!)")
        self.storageID! == str! ?  DispatchQueue.main.async {
            Singelton.sharedInstance.service.qrCodeDelegate =  self;
            let param = "booking=\(String(describing: self.storageID!))&storage=\(String(describing: self.bookingID!))";
            Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.qrCodeData, api_Type: apiType.POST.rawValue)
            }: alert(message: "QR code not match, Please check and try again", Controller: self)
    }

}
