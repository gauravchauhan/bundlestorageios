//
//  DescribeListingVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class DescribeListingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- Outlets
    
    @IBOutlet weak var list: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.list.register(UINib(nibName:"ListingCell" , bundle: nil), forCellReuseIdentifier: "ListingTableViewCell")
        DispatchQueue.main.async {
            self.list.delegate = self
            self.list.dataSource = self
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.list.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath)as! ListingTableViewCell
        if indexPath.row % 2 == 0 {
            cell.selectedView.isHidden = false
            cell.generalView.isHidden = true
        }else{
            cell.selectedView.isHidden = true
            cell.generalView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    //MARK:- User Defined function
    
    
}
