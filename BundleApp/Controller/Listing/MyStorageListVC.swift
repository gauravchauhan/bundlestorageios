//
//  MyStorageListVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 22/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import CoreLocation

class MyStorageListVC: UIViewController , GetHostStorageListDelegate, UITableViewDelegate, UITableViewDataSource, DeleteButtonDelegate{
    
    
    var myStorageModal = [StorageListModal]()
    @IBOutlet weak var myStorageList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "My Storage List")
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.getHostStorageListDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.hostStorageList, api_Type: apiType.GET.rawValue)
        self.myStorageList.register(UINib(nibName:"HostListCell" , bundle: nil), forCellReuseIdentifier: "HostListTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- delegate
    
    func click_DeleteButton(_ cell: UITableViewCell, didPressButton: UIButton) {
        print("Delete button click")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myStorageModal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myStorageList.dequeueReusableCell(withIdentifier: "HostListTableViewCell", for: indexPath)as! HostListTableViewCell
        cell.deleteBttn.isHidden = false
        cell.delegate = self
        cell.tag =  indexPath.row
        cell.spaceName.text! = self.myStorageModal[indexPath.row].storageName!
        cell.hostName.text! = self.myStorageModal[indexPath.row].storageName!
        cell.spaceType.text! = " " +  self.myStorageModal[indexPath.row].storageType!.capitalized + " "
        cell.spaceDescription.text! = "$" + self.myStorageModal[indexPath.row].storageDailyPrice! + " per day | $ " + self.myStorageModal[indexPath.row].storageWeeklyPrice! + " per week | $ " + self.myStorageModal[indexPath.row].storageMonthlyPrice! + " per month"
        cell.hostImage.setImageWith(URL(string : self.myStorageModal[indexPath.row].storageImage![0].imageURL! ), placeholderImage: UIImage(named: "app_Logo"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK:- User Defined fucntion
    
    func getHostStorageListResponse(data: [String : Any]) {
        Indicator.shared.hideProgressView()
        print("MyStorageListVC   \(data)")
        !(data["status"]as! Bool) ?
             alert(message: data["message"]as! String , Controller: self)
             : self.setDataIntoModal(data: data["storageList"]as! [[String : Any]])
    }
    
    
    func setDataIntoModal(data :  [[String : Any]]){
        self.myStorageModal.removeAll()
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
            self.myStorageModal.append(storageObj)
        }
        print("Storage modal count \(self.myStorageModal.count)")
        self.reloadMyStorageList()
    }
    
    
    func reloadMyStorageList(){
        DispatchQueue.main.async {
            self.myStorageList.delegate =  self
            self.myStorageList.dataSource = self
            self.myStorageList.reloadData()
        }
    }
    

}
