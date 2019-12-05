//
//  BookingHistoryVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class BookingHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, BookingHistoryListDelegate{
    
    @IBOutlet weak var historyList: UITableView!
    
    var bookingHistoryModal = [BookingHistoryModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Singelton.sharedInstance.service.bookingHistoryListDelegate =  self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.bookingHistoryList, api_Type: apiType.GET.rawValue)
        self.historyList.register(UINib(nibName:"BookingHistoryCell" , bundle: nil), forCellReuseIdentifier: "BookingHistoryTableViewCell")
        setBackButtonWithTitle(title: "Booking history list")
    }
    
    //MRAK:- Delegate
    
    func bookingHistoryListResponse(data: [String : Any]) {
        print("bookingHistoryListResponse   \(data)")
        (data["status"]as! Bool) ? setBookingHistoryModal(historyData: data["bookingList"]as! [[String :  Any]]) : alert(message: "No data found", Controller: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookingHistoryModal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.historyList.dequeueReusableCell(withIdentifier: "BookingHistoryTableViewCell", for: indexPath)as! BookingHistoryTableViewCell
        cell.hostName.text! = self.bookingHistoryModal[indexPath.row].storage_HostName!
        cell.storageTitle.text! = self.bookingHistoryModal[indexPath.row].storage_List.storageName!
        cell.status.text! = self.bookingHistoryModal[indexPath.row].storage_Status!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected history cell")
    }
    
    //MARK:-  use Defined function
    
    
    func setBookingHistoryModal(historyData : [[String : Any]]){
        self.bookingHistoryModal.removeAll()
        for index in 0...historyData.count - 1{
            let historyObject = BookingHistoryModal()
            historyObject.storage_Status = historyData[index]["bookingStatus"]as? String
            historyObject.storage_Type = historyData[index]["bookingType"]as? String
            historyObject.storage_Description = historyData[index]["description"]as? String
            historyObject.storage_HostName = ((historyData[index]["host"]as! [String : Any])["firstName"]as? String)! + " \(String(describing: (historyData[index]["host"]as! [String : Any])["lastName"]as! String))"
            
            //-----------------------------------------------------------------------------------------------
            
            let storageData = historyData[index]["storage"]as? [String : Any]
            
//            var imageModal = [StorageImageModal]()
            let storageObj = StorageListModal()
            storageObj.storageName = (storageData!["storageName"]as? String)?.capitalized
            storageObj.stoargeID = storageData!["id"]as? String
            storageObj.storageHostId = storageData!["creator"]as? String
            storageObj.storageHostName = historyObject.storage_HostName
            storageObj.storageType = storageData!["storageType"]as? String
            storageObj.allAmenities = storageData!["amenities"]as? NSArray
            if let length : Int = storageData!["spaceHeight"]as? Int{
                storageObj.storageLength = "\(length)"
            }
            if let width : Int = storageData!["spaceWidth"]as? Int{
                storageObj.storageWidth = "\(width)"
            }
            storageData!["dailyPrice"] is NSNull ? (storageObj.storageDailyPrice  = "Null" ) :  (storageObj.storageDailyPrice  = "\(storageData!["dailyPrice"]as! Int)")
            storageData!["monthelyPrice"] is NSNull ? (storageObj.storageMonthlyPrice  = "Null" ) :  (storageObj.storageMonthlyPrice  = "\(storageData!["monthelyPrice"]as! Int)")
            storageData!["weeklyPrice"] is NSNull ? (storageObj.storageWeeklyPrice  = "Null" ) :  (storageObj.storageWeeklyPrice  = "\(storageData!["weeklyPrice"]as! Int)")
            if let type = storageData!["priceType"]as? String{
                storageObj.storagePriceType = type
            }else{
                storageObj.storagePriceType = ""
            }
//
//            for imageIndex in 0...(storageData["media"]as? [[String : Any]])!.count - 1{
//                let imageObj = StorageImageModal()
//                imageObj.imageURL = ((storageData["media"]as? [[String : Any]])![imageIndex])["url"]as? String
//                imageModal.append(imageObj)
//            }
            
            
//            storageObj.storageImage = imageModal
            
            storageObj.aboutStorage = (storageData!["descripton"] is NSNull) ? Strings_Const.no_Desc : storageData!["descripton"]as? String
            storageObj.offers = (storageData!["discount"] is NSNull) ? "No discount" : storageData!["discount"]as? String
            
            storageObj.availablity = storageData!["availability"]as? String
            
//            let addressModal = AddressModal()
//            addressModal.storageAddress = (data[index]["location"]as! [String : Any])["address"]as? String
//            addressModal.storageCity = (data[index]["location"]as! [String : Any])["city"]as? String
//            !((data[index]["location"]as! [String : Any])["latitude"] is NSNull) ? (addressModal.storageLat = (data[index]["location"]as! [String : Any])["latitude"]as? CGFloat) : ( addressModal.storageLat = 19.0176086425781)
//            !((data[index]["location"]as! [String : Any])["longitude"] is NSNull) ? (addressModal.storageLng = (data[index]["location"]as! [String : Any])["longitude"]as? CGFloat) : (addressModal.storageLng = 72.8561644)
//            print("stoarge lat \(addressModal.storageLat!)    \(addressModal.storageLng!)")
//            addressModal.storageState = (data[index]["location"]as! [String : Any])["state"]as? String
//            addressModal.zipCode = (data[index]["location"]as! [String : Any])["zipCode"]as? String
//            addressModal.storagePosition = CLLocationCoordinate2D(latitude: (CLLocationDegrees((addressModal.storageLat!))), longitude: (CLLocationDegrees((addressModal.storageLng!))))
            
//            storageObj.address = addressModal
            
            
            historyObject.storage_List = storageObj
            self.bookingHistoryModal.append(historyObject)
        }
        
        self.bookingHistoryModal.count != 0 ? self.reloadHistoryList() : nil
    }
    
    func reloadHistoryList(){
        DispatchQueue.main.async {
            self.historyList.delegate =  self
            self.historyList.dataSource = self
            self.historyList.reloadData()
        }
    }
    
    

}
