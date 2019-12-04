//
//  BookingHistoryVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 03/12/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class BookingHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var historyList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyList.register(UINib(nibName:"BookingHistoryCell" , bundle: nil), forCellReuseIdentifier: "BookingHistoryTableViewCell")
        setBackButtonWithTitle(title: "Booking history list")
        reloadHistoryList()
    }
    
    //MRAK:- Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.historyList.dequeueReusableCell(withIdentifier: "BookingHistoryTableViewCell", for: indexPath)as! BookingHistoryTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected history cell")
    }
    
    //MARK:-  use Defined function
    
    func reloadHistoryList(){
        DispatchQueue.main.async {
            self.historyList.delegate =  self
            self.historyList.dataSource = self
            self.historyList.reloadData()
        }
    }
    
    

}
