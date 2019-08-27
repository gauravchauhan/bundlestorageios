//
//  HostListOnMapVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 23/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GoogleMaps

class HostListOnMapVC: UIViewController, UITableViewDelegate , UITableViewDataSource, UIGestureRecognizerDelegate , GetStorageListDelegate{
    
    //MARK:- Outlets
    
    @IBOutlet weak var hostList: UITableView!
    @IBOutlet weak var hostListView: UIView!
    @IBOutlet weak var hostListBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var hostListheightConstraints: NSLayoutConstraint!
    @IBOutlet weak var arrow_Button: UIButton!
    @IBOutlet weak var storageMapView: GMSMapView!
    
    var storageModal = [StorageListModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.hostList.register(UINib(nibName:"HostListCell" , bundle: nil), forCellReuseIdentifier: "HostListTableViewCell")
        self.hostList.isScrollEnabled = false
        createSwapGestureRecognizer()
        self.addDrawerButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchView))
        self.view.addGestureRecognizer(tapGesture)
        self.navigationController?.navigationItem.hidesBackButton = true
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
            } : self.setTheStorageDataIntoModal(data: data["storageList"]as! [[String : Any]])
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storageModal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.hostList.dequeueReusableCell(withIdentifier: "HostListTableViewCell", for: indexPath)as! HostListTableViewCell
        cell.spaceName.text! = self.storageModal[indexPath.row].storageName!
        cell.hostName.text! = self.storageModal[indexPath.row].storageName!
        cell.spaceType.text! = self.storageModal[indexPath.row].storageType!.capitalized
        cell.spaceDescription.text! = "$" + self.storageModal[indexPath.row].storagePrice! + " " + self.storageModal[indexPath.row].storagePriceType!
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
    
    func updateDataOnMap(){
        for index in 0...self.storageModal.count - 1 {
            self.storageMapView.addMarker(position: (self.storageModal[index].address?.storagePosition!)!, title: self.storageModal[index].storageName!)
        }
        self.storageMapView.setTheCameraPosition(firstPosition: (self.storageModal[0].address?.storagePosition!)!, lastPosition: (self.storageModal[self.storageModal.count - 1].address?.storagePosition!)!)
    }
    
    @objc func touchView(){
        self.swipeUp_DownAction(height: 250)
    }
    
    //MARK:- User Defined fucntion
    
    func setTheStorageDataIntoModal(data : [[String : Any]]){
        for index in 0...data.count - 1{
            let storageObj = StorageListModal()
            storageObj.storageName = data[index]["storageName"]as? String
            storageObj.stoargeID = data[index]["id"]as? String
//            storageObj.storageImage = (data[index]["media"]as! [[String : Any]])[0]["url"]as? String
            storageObj.storageType = data[index]["storageType"]as? String
            print("data[index] price as? String   \(String(describing: data[index]["price"]as? Int))")
            storageObj.storagePrice = "\(data[index]["price"]as! Int)"
            storageObj.storagePriceType = data[index]["priceType"]as? String
            storageObj.availablity = data[index]["availability"]as? String
            
            let addressModal = AddressModal()
            addressModal.storageAddress = (data[index]["location"]as! [String : Any])["address"]as? String
            addressModal.storageCity = (data[index]["location"]as! [String : Any])["city"]as? String
            addressModal.storageLat = (data[index]["location"]as! [String : Any])["latitude"]as? CGFloat
            addressModal.storageLng = (data[index]["location"]as! [String : Any])["latitude"]as? CGFloat
            print("stoarge lat \(addressModal.storageLat!)    \(addressModal.storageLng!)")
            addressModal.storageState = (data[index]["location"]as! [String : Any])["state"]as? String
            addressModal.zipCode = (data[index]["location"]as! [String : Any])["zipCode"]as? String
            addressModal.storagePosition = CLLocationCoordinate2D(latitude: (CLLocationDegrees((addressModal.storageLat!))), longitude: (CLLocationDegrees((addressModal.storageLat!))))
            
            storageObj.address = addressModal
            self.storageModal.append(storageObj)
        }
        print("Storage modal count \(self.storageModal.count)")
        updateDataOnMap()
        reloadHostList()
    }
    
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
    
    @IBAction func click_adStorageButton(_ sender: Any) {
        self.pushToStep_FirstController()
    }

}
