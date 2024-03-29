//
//  HostListOnMapVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 23/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GoogleMaps
import Crashlytics

class HostListOnMapVC: UIViewController, UITableViewDelegate , UITableViewDataSource, UIGestureRecognizerDelegate , GetStorageListDelegate  , CurrentLocationDelegate, UISearchBarDelegate, FilterDataDelegate, FilterParameterDelgate, FilterButtonClick, GMSMapViewDelegate{
    
    //MARK:- Outlets
    @IBOutlet weak var hostList: UITableView!
    @IBOutlet weak var hostListView: UIView!
    @IBOutlet weak var hostListBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var hostListheightConstraints: NSLayoutConstraint!
    @IBOutlet weak var arrow_Button: UIButton!
    @IBOutlet weak var storageMapView: GMSMapView!
    @IBOutlet weak var zipCode: UISearchBar!
    
    // MARK: PROPERTIES
    private var storageModal = [StorageListModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.SwitchUserObserverActions), name: NSNotification.Name(rawValue:"Switch_User"), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        filterButtonClickObserver =  self
        self.zipCode.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        self.hostList.register(UINib(nibName:"HostListCell" , bundle: nil), forCellReuseIdentifier: "HostListTableViewCell")
        self.hostList.isScrollEnabled = false
        createSwapGestureRecognizer()
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.location.setLatLong()
        Singelton.sharedInstance.location.current_Delegate = self
        Singelton.sharedInstance.location.getCurrentLocation()
        storageMapView.delegate = self
    }
    
    //MARK:- Delagate
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let storageInfoWindow = UIView(frame: CGRect.init(x: 0, y: 0, width: 310, height: 80))
        storageInfoWindow.backgroundColor = UIColor.white
        storageInfoWindow.cornerRadius = 10
        storageInfoWindow.borderWidth = 1.0
        storageInfoWindow.borderColor = UIColor(hex: Constants.Colors.textColor, alpha: 1.0)
        storageInfoWindow.layer.cornerRadius = 6
        print("Map view title \(String(describing: self.storageMapView.selectedMarker!.title!))")
        let findIndex = self.storageModal.firstIndex(where: {
            $0.storageName! == self.storageMapView.selectedMarker!.title!
        })
        
        let storageImage = UIImageView(frame: CGRect.init(x: 8, y: 8, width: 40, height: 40))
        storageImage.setImageWith(URL(string : self.storageModal[findIndex!].storageImage![0].imageURL! ), placeholderImage: UIImage(named: "app_Logo"))
        storageInfoWindow.addSubview(storageImage)
        
        let storageName = UILabel(frame: CGRect.init(x: storageImage.x + storageImage.width + 5 , y: 8, width: view.frame.size.width - 16, height: 20))
        storageName.textColor = UIColor(hex: Constants.Colors.textColor, alpha: 1.0)
        storageName.text = "Storage Name: " + self.storageModal[findIndex!].storageName!
        storageName.font  = UIFont(name: Constants.fonts.ProximaNova_Regular, size: 14)
        print("character count \(storageName.text!.count)")
        let nameLength = storageName.text!.count - 13
        print(nameLength)
        storageName.attributedText = colorString(location: 13, length: nameLength , String: storageName.text!, Color: UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0))
        
        storageInfoWindow.addSubview(storageName)
        
        let storageType = UILabel(frame: CGRect.init(x: storageName.x , y: storageName.y + storageName.height + 2, width: view.frame.size.width - 16, height: 20))
        storageType.textColor = UIColor(hex: Constants.Colors.textColor, alpha: 1.0)
        storageType.text = "Storage Type: " + self.storageModal[findIndex!].storageType!
        storageType.font  = UIFont(name: Constants.fonts.ProximaNova_Regular, size: 14)
        let typeLength = storageType.text!.count - 13
        print(typeLength)
        storageType.attributedText = colorString(location: 13, length: typeLength , String: storageType.text!, Color: UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0))
        storageInfoWindow.addSubview(storageType)
        
        
        let storagePrice = UILabel(frame: CGRect.init(x: storageName.x , y: storageType.y + storageType.height , width: view.frame.size.width - 16, height: 20))
        storagePrice.textColor = UIColor(hex: Constants.Colors.textColor, alpha: 1.0)
//        storagePrice.backgroundColor = UIColor.red
        storagePrice.font  = UIFont(name: Constants.fonts.ProximaNova_Regular, size: 12)
        storagePrice.numberOfLines = 3
        storagePrice.text = "Price $" + self.storageModal[findIndex!].storageDailyPrice! + " per day | $ " + self.storageModal[findIndex!].storageWeeklyPrice! + " per week | $ " + self.storageModal[findIndex!].storageMonthlyPrice! + " per month"
        storageInfoWindow.addSubview(storagePrice)
        
        return storageInfoWindow
    }
    
    
    func filterClick() {
        print("filter clcik")
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
            next.filterDelgate = self
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func getFilterParameter(param: String) {
        print("filter screen paarmater \(param)")
        Singelton.sharedInstance.service.filterDataDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.filter_Data, api_Type: apiType.POST.rawValue)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Change   \(searchText)")
        searchText.isEmpty ? Singelton.sharedInstance.location.getCurrentLocation() : nil
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("text \(searchBar.text!)")
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        let param = "zipCode=\(String(describing: self.zipCode.text!))"
        print("Parameter \(param)")
        Singelton.sharedInstance.service.filterDataDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.filter_Data, api_Type: apiType.POST.rawValue)
    }
    
    
    func filterDataRequestResponse(data: [String : Any]) {
        print("filter response \(data)")
        !(data["status"]as! Bool) ? DispatchQueue.main.async {
            alert(message: "No storage found for \(self.zipCode.text!) zipcode" , Controller: self)
            } : self.setTheStorageDataIntoModal(data: data["storageList"]as! [[String : Any]])
    }
    
    func currentLocationResponse(lat: CLLocationDegrees, lng: CLLocationDegrees) {
        print("current location response \(lat) \(lng)")
        self.view.endEditing(true)
        let param = "latitude=\(String(describing: lat))&longitude=\(String(describing: lng))"
        print("Parameter \(param)")
        Singelton.sharedInstance.service.getStorageListDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.getStorageList, api_Type: apiType.POST.rawValue)
    }
    
    func LocationPermissionDenied() {
        print("Permission denied")
        Indicator.shared.hideProgressView()
        self.hostListheightConstraints.constant = 80
        alert(message: Strings_Const.allow_Location, Controller: self)
    }
    
    
    func getStorageListResponse(data: [String : Any]) {
        
        Indicator.shared.hideProgressView()
        print("list resposne \(data)")
        let left = LeftMenuViewController()
        left.setTheName()
        !(data["status"]as! Bool) ? DispatchQueue.main.async {
            self.view.endEditing(true);
            self.hostListheightConstraints.constant = 80 ; alert(message: data["message"]as! String , Controller: self)
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
        cell.deleteBttn.isHidden = true
        cell.spaceName.text! = self.storageModal[indexPath.row].storageName!
        cell.hostName.text! = self.storageModal[indexPath.row].storageName!
        cell.spaceType.text! = " " + self.storageModal[indexPath.row].storageType!.capitalized + " "
        cell.spaceDescription.text! = "$" + self.storageModal[indexPath.row].storageDailyPrice! + " per day | $ " + self.storageModal[indexPath.row].storageWeeklyPrice! + " per week | $ " + self.storageModal[indexPath.row].storageMonthlyPrice! + " per month"
        cell.hostImage.setImageWith(URL(string : self.storageModal[indexPath.row].storageImage![0].imageURL! ), placeholderImage: UIImage(named: "app_Logo"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushToStorageDetailController(detail: self.storageModal[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func reloadHostList(){
        DispatchQueue.main.async {
            self.view.endEditing(true)
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
//        self.storageMapView.setMinZoom(4, maxZoom: 10)
        let left = LeftMenuViewController()
        left.setTheName()
    }
    
    @objc func touchView(){
        self.swipeUp_DownAction(height: 250)
    }
    
    //MARK:- User Defined fucntion
    
    func setTheStorageDataIntoModal(data : [[String : Any]]){
        self.storageModal.removeAll()
        self.hostListheightConstraints.constant = 250
        for index in 0...data.count - 1{
            var imageModal = [StorageImageModal]()
            let storageObj = StorageListModal()
            storageObj.storageName = (data[index]["storageName"]as? String)?.capitalized
            storageObj.stoargeID = data[index]["storageId"]as? String
            storageObj.storageHostId = data[index]["hostId"]as? String
            storageObj.storageHostName = data[index]["hostName"]as? String
            storageObj.storageType = data[index]["storageType"]as? String
            storageObj.allAmenities = data[index]["amenities"]as? NSArray
            if let length : Int = data[index]["spaceHeight"]as? Int{
                storageObj.storageLength = "\(length)"
            }
            if let width : Int = data[index]["spaceWidth"]as? Int{
                storageObj.storageWidth = "\(width)"
            }
            data[index]["dailyPrice"] is NSNull ? (storageObj.storageDailyPrice  = "Null" ) :  (storageObj.storageDailyPrice  = "\(data[index]["dailyPrice"]as! Int)")
            data[index]["monthelyPrice"] is NSNull ? (storageObj.storageMonthlyPrice  = "Null" ) :  (storageObj.storageMonthlyPrice  = "\(data[index]["monthelyPrice"]as! Int)")
            data[index]["weeklyPrice"] is NSNull ? (storageObj.storageWeeklyPrice  = "Null" ) :  (storageObj.storageWeeklyPrice  = "\(data[index]["weeklyPrice"]as! Int)")
            if let type = data[index]["priceType"]as? String{
                storageObj.storagePriceType = type
            }else{
                storageObj.storagePriceType = ""
            }
            
            for imageIndex in 0...(data[index]["media"]as? [[String : Any]])!.count - 1{
                let imageObj = StorageImageModal()
                imageObj.imageURL = ((data[index]["media"]as? [[String : Any]])![imageIndex])["url"]as? String
                imageModal.append(imageObj)
            }
            
            
            storageObj.storageImage = imageModal
            storageObj.aboutStorage = (data[index]["descripton"] is NSNull) ? Strings_Const.no_Desc : data[index]["descripton"]as? String
            storageObj.offers = (data[index]["discount"] is NSNull) ? "No discount" : data[index]["discount"]as? String
            
            storageObj.availablity = data[index]["availability"]as? String
            
            let addressModal = AddressModal()
            addressModal.storageAddress = (data[index]["location"]as! [String : Any])["address"]as? String
            addressModal.storageCity = (data[index]["location"]as! [String : Any])["city"]as? String
            !((data[index]["location"]as! [String : Any])["latitude"] is NSNull) ? (addressModal.storageLat = (data[index]["location"]as! [String : Any])["latitude"]as? CGFloat) : ( addressModal.storageLat = 19.0176086425781)
            !((data[index]["location"]as! [String : Any])["longitude"] is NSNull) ? (addressModal.storageLng = (data[index]["location"]as! [String : Any])["longitude"]as? CGFloat) : (addressModal.storageLng = 72.8561644)
            print("stoarge lat \(addressModal.storageLat!)    \(addressModal.storageLng!)")
            addressModal.storageState = (data[index]["location"]as! [String : Any])["state"]as? String
            addressModal.zipCode = (data[index]["location"]as! [String : Any])["zipCode"]as? String
            addressModal.storagePosition = CLLocationCoordinate2D(latitude: (CLLocationDegrees((addressModal.storageLat!))), longitude: (CLLocationDegrees((addressModal.storageLng!))))
            
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
    
    @objc  func SwitchUserObserverActions(notification: Notification){
        print("User Change")
    }
    
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
        print("Singelton.sharedInstance.userDataModel.uploadIDProofStatus!    \(Singelton.sharedInstance.userDataModel.uploadIDProofStatus!)")
        Singelton.sharedInstance.userDataModel.uploadIDProofStatus! ? self.pushToSpaceSelectController()  : self.pushToStep_FirstController(comingFromSettings: false)
    }

}
