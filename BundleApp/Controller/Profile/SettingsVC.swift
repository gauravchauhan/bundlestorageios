//
//  SettingsVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 11/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var settingsList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "Settings")
        self.settingsList.register(UINib(nibName:"ListingCell" , bundle: nil), forCellReuseIdentifier: "ListingTableViewCell")
        reloadSettingsList()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Strings_Const.Settings_Items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingsList.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath)as! ListingTableViewCell
        cell.typeName.text! = Strings_Const.Settings_Items[indexPath.row]
        cell.generalView.isHidden = true
        cell.generalView.isHidden = true
        cell.check.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    //MARK:- User Defined fucntion
    
    func reloadSettingsList(){
        DispatchQueue.main.async {
            self.settingsList.delegate = self
            self.settingsList.dataSource = self
            self.settingsList.reloadData()
        }
    }
    
    
}
