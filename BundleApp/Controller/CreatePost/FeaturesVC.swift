//
//  FeaturesVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 29/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class FeaturesVC: UIViewController, GetFeatureDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var featureList: UITableView!
    
    var featureListModal = [ListingModal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.featureList.register(UINib(nibName:"ListingCell" , bundle: nil), forCellReuseIdentifier: "ListingTableViewCell")
        Singelton.sharedInstance.service.featureDelegate = self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.getAmenities, api_Type: apiType.GET.rawValue)
        self.setBackButtonWithTitle(title: "Create")
        self.setRightBarButtonItems(Step: "06")
    }
    
    //MARK:- Delegate
    
    func featureResponse(data: [String : Any]) {
        print("feature reponse \(data)")
        for listingArrayIndex in 0...(data["amenities"]as! NSArray).count - 1 {
            let list = ListingModal()
            list.listingType = (data["amenities"]as! NSArray).object(at: listingArrayIndex) as? String
            list.selectedStatus =  false
            self.featureListModal.append(list)
        }
        reloadFeatureList()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.featureListModal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.featureList.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath)as! ListingTableViewCell
        cell.typeName.text! = self.featureListModal[indexPath.row].listingType!
        if self.featureListModal[indexPath.row].selectedStatus!{
            cell.check.isHidden =  false
            cell.generalView.isHidden =  true
            cell.selectedView.isHidden =  false
        }else{
            cell.check.isHidden =  true
            cell.generalView.isHidden =  false
            cell.selectedView.isHidden =  true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.featureListModal[indexPath.row].selectedStatus?.toggle()
        self.reloadFeatureList()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    //MARK:- User Defined function
    
    func reloadFeatureList(){
        DispatchQueue.main.async {
            self.featureList.delegate = self
            self.featureList.dataSource = self
            self.featureList.reloadData()
        }
    }
    
    
    @IBAction func click_NextBttn(_ sender: Any) {
        let selectedValue = self.featureListModal.filter({$0.selectedStatus!}).map({$0.listingType})
        Singelton.sharedInstance.addStorageModal.storageFacility = selectedValue as NSArray
        self.pushToStorageChargeController()
    }
    
    
    
}
