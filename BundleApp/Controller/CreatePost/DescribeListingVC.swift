//
//  DescribeListingVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class DescribeListingVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GetListingTypeDelegate, UIGestureRecognizerDelegate {
    
    //MARK:- Outlets
    
    @IBOutlet weak var lisTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var list: UITableView!
    var listingModal = [ListingModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.list.register(UINib(nibName:"ListingCell" , bundle: nil), forCellReuseIdentifier: "ListingTableViewCell")
        Singelton.sharedInstance.service.getListingTypeDelegate =  self
        Singelton.sharedInstance.service.getService(apiName: Constants.AppUrls.getListType, api_Type: apiType.GET.rawValue)
        self.setBackButtonWithTitle(title: "Create")
        self.setRightBarButtonItems(Step: "03")
        //self.createPanGestureRecognizer()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Delegate
    
    func listingTypeResponse(data: [String : Any]) {
        print("lsting resposne \(data)")
        for listingArrayIndex in 0...(data["listingType"]as! NSArray).count - 1 {
            let list = ListingModal()
            list.listingType = (data["listingType"]as! NSArray).object(at: listingArrayIndex) as? String
            list.selectedStatus =  false
            self.listingModal.append(list)
        }
        reloadList()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listingModal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.list.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath)as! ListingTableViewCell
        cell.typeName.text! = self.listingModal[indexPath.row].listingType!
        if self.listingModal[indexPath.row].selectedStatus!{
            cell.generalView.isHidden =  true
            cell.selectedView.isHidden =  false
        }else{
            cell.generalView.isHidden =  false
            cell.selectedView.isHidden =  true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listingModal[indexPath.row].selectedStatus?.toggle()
        self.list.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    //MARK:- User Defined function
    
    func reloadList(){
        DispatchQueue.main.async {
            self.list.delegate = self
            self.list.dataSource = self
            self.list.reloadData()
        }
    }
    
}
