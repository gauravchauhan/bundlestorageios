//
//  DiscountVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 29/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class DiscountVC: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var disclontList: UITableView!
    
    var discountArray = ["Discard offer discount", "Add 50%", "40%", "30%", "20%", "10%"]
    var discountModal = [ListingModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.disclontList.register(UINib(nibName:"ListingCell" , bundle: nil), forCellReuseIdentifier: "ListingTableViewCell")
        for i in 0...self.discountArray.count - 1{
            let list = ListingModal()
            list.listingType = discountArray[i]
            list.selectedStatus =  false
            self.discountModal.append(list)
        }
        reloadDiscontTable()
        self.setRightBarButtonItems(Step: "08")
        self.setBackButtonWithTitle(title: "Create")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discountModal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.disclontList.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath)as! ListingTableViewCell
        cell.typeName.text! = self.discountModal[indexPath.row].listingType!
        
        if self.discountModal[indexPath.row].selectedStatus!{
            cell.generalView.isHidden =  true
            cell.selectedView.isHidden =  false
            cell.check.isHidden =  false
        }else{
            cell.generalView.isHidden =  false
            cell.selectedView.isHidden =  true
            cell.check.isHidden =  true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let findIndex = self.discountModal.firstIndex(where: {
            $0.selectedStatus == true
        }){
            print("Index if selected \(findIndex)")
            self.discountModal[findIndex].selectedStatus?.toggle()
        }
        self.discountModal[indexPath.row].selectedStatus?.toggle()
        self.reloadDiscontTable()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    func reloadDiscontTable(){
        DispatchQueue.main.async {
            self.disclontList.delegate = self
            self.disclontList.dataSource = self
            self.disclontList.reloadData()
        }
    }
    
    
    
    
    @IBAction func click_NextBttn(_ sender: Any) {
        let status = self.discountModal.filter({$0.selectedStatus!})
        let selectedValue = self.discountModal.filter({$0.selectedStatus!}).map({$0.listingType})
        status.count != 0 ? Singelton.sharedInstance.addStorageModal.storageDiscount = selectedValue[0]! : alert(message: Strings_Const.select_Atleast_One, Controller: self)
        status.count != 0 ? self.pushToUploadStorageImageController() : alert(message: Strings_Const.select_Atleast_One, Controller: self)
        
    }
    
    

}
