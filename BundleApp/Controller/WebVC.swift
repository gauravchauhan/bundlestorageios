//
//  WebVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 12/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
protocol codeDelegate {
    func getCode(code : String)
}

class WebVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var redirectEdView: UIWebView!
    var delegate : codeDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.title = screenName!
        self.redirectEdView.delegate = self
        let url = URL (string: Constants.AppUrls.webViewURLForLinden)
        let requestObj = URLRequest(url: url!)
        redirectEdView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        //        Indicator.shared.showProgressView(self.view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //        Indicator.shared.hideProgressView()
        
        print("end loading")
        let currentURL = redirectEdView.request?.url
        print("Current URL   \(String(describing: currentURL!))")
        
        let urlGet = "\(String(describing: redirectEdView.request?.url))"
        
        if urlGet.contains("code="){
            print("Yes get code=")
            let codeSeperate = urlGet.components(separatedBy: "code=")[1]
            print("code \(codeSeperate)")
            let code = codeSeperate.components(separatedBy: "&state")[0]
            print("Cpde afetr seperation \(code)")
            delegate.getCode(code: code)
            self.navigationController?.popViewController(animated: true)
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
