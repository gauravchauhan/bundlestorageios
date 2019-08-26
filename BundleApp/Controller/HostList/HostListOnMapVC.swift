//
//  HostListOnMapVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 23/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class HostListOnMapVC: UIViewController, UITableViewDelegate , UITableViewDataSource, UIGestureRecognizerDelegate , GetStorageListDelegate{
    
    //MARK:- Outlets
    
    @IBOutlet weak var hostList: UITableView!
    @IBOutlet weak var hostListView: UIView!
    @IBOutlet weak var hostListBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var hostListheightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var arrow_Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.hostList.register(UINib(nibName:"HostListCell" , bundle: nil), forCellReuseIdentifier: "HostListTableViewCell")
        reloadHostList()
        self.hostList.isScrollEnabled = false
        createSwapGestureRecognizer()
        self.setBackButtonWithTitle(title: "")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        Indicator.shared.showProgressView(self.view)
        let param = "latitude=\(String(describing: 28.77))&longitude=\(String(describing: 77.0))"
        print("Parameter \(param)")
        Singelton.sharedInstance.service.getStorageListDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.getStorageList, api_Type: apiType.POST.rawValue)
    }
    
    //MARK:- Delagate
    
    func getStorageListResponse(data: [String : Any]) {
        Indicator.shared.hideProgressView()
        print("list resposne \(data)")
        !(data["status"]as! Bool) ? DispatchQueue.main.async {
            self.hostListheightConstraints.constant = 0 ; alert(message: data["message"]as! String , Controller: self)
            } : nil
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.hostList.dequeueReusableCell(withIdentifier: "HostListTableViewCell", for: indexPath)as! HostListTableViewCell
        cell.spaceName.text! = "Rohit gupta"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    func reloadHostList(){
        DispatchQueue.main.async {
            self.hostList.delegate =  self
            self.hostList.dataSource = self
            self.hostList.reloadData()
        }
    }
    
    @objc func touchView(){
        self.swipeUp_DownAction(height: 250)
    }
    
    //MARK:- User Defined fucntion
    
    func createSwapGestureRecognizer() {
        //Register swipegesture for up
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        swipeUp.delegate = self
        self.hostList.addGestureRecognizer(swipeUp)
        
        //Register swipegesture for down
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        swipeDown.delegate = self
        self.hostList.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                self.swipeUp_DownAction(height: self.view.height - 64)
            default:
                break
            }
        }
    }
    
    //MARK:- USerDefined function
    
    func swipeUp_DownAction(height : CGFloat){
        UIView.animate(withDuration: 0.5, animations: {
            self.hostListheightConstraints.constant = height
            self.hostList.isScrollEnabled = true
            self.arrow_Button.transform = self.arrow_Button.transform.rotated(by: CGFloat(Double.pi))
            self.hostListView.layoutIfNeeded()
        })
    }
    
    @IBAction func click_ArrowButton(_ sxender: Any) {
        print("Click button")
        (self.hostListheightConstraints.constant == 250) ? self.swipeUp_DownAction(height: self.view.height - 64) : self.swipeUp_DownAction(height: 250)
    }
    

}
