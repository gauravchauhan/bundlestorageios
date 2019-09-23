//
//  Request_MessageVC.swift
//  BundleApp
//
//  Created by rohit on 02/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class Request_MessageVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
   
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK:- Properties
    var currentSegment = Strings_Const.request
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RequestViewCell", bundle: nil), forCellReuseIdentifier: "RequestViewCell")
        tableView.register(UINib(nibName: "MessageViewCell", bundle: nil), forCellReuseIdentifier: "MessageViewCell")

        // Do any additional setup after loading the view.
        segment.selectedSegmentIndex = 0
        let font = UIFont.init(name: Constants.fonts.ProximaNova_Semibold, size: 14.0)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font!],
                                                for: .normal)
        
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if(segment.selectedSegmentIndex==0){
            currentSegment = Strings_Const.request
            (segment.subviews[0] as UIView).tintColor = UIColor.red
        }
        else{
            currentSegment = Strings_Const.message
            (segment.subviews[0] as UIView).tintColor = UIColor.red
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentSegment == Strings_Const.message{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell", for: indexPath) as! MessageViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestViewCell", for: indexPath) as! RequestViewCell
            return cell
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
