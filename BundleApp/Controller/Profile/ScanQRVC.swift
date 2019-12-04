//
//  ScanQRVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class ScanQRVC: UIViewController, QRScannerViewDelegate {

    @IBOutlet weak var scannerView: QRScannerView!{
        didSet {
            scannerView.delegate = self
        }
    }
    
    var storageID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "Scan QR code")
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
    }

}
