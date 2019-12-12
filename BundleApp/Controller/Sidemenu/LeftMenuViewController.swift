//
//  LeftMenuViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 20/10/14.
//  Copyright (c) 2015 Sebastian Andersen. All rights reserved.
//

import Foundation
import UIKit

class LeftMenuViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        print("Singelton.sharedInstance.userDataModel.userRole! \(Singelton.sharedInstance.userDataModel.userRole!)")
        tableView.frame = CGRect(x: self.view.frame.width - 200, y: 160 , width: 200, height: CGFloat(54 * (Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? Strings_Const.SideBarMenuItems_host.count : Strings_Const.SideBarMenuItems_User.count)))
        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setImageWith(URL(string : Singelton.sharedInstance.userDataModel.userProfilePic!), placeholderImage: UIImage(named: "app_Logo"))
        imageView.frame = CGRect(x: self.tableView.x + 100, y: 80, width: 80 , height: 80)
        imageView.layer.cornerRadius = imageView.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    lazy var userName: UILabel = {
        let name = UILabel()
        name.text = Singelton.sharedInstance.userDataModel.userFirstName!.capitalized + " "  + Singelton.sharedInstance.userDataModel.userLastName!.capitalized
        print("tableView.x   \(tableView.x)")
        name.frame = CGRect(x: self.view.frame.width - 210  , y: imageView.y + imageView.height + 2, width: 200 , height: 50)
        name.font = UIFont(name: Constants.fonts.ProximaNova_Semibold, size: 22)
        name.textColor = UIColor.white
        name.textAlignment = .right
        return name
    }()
    
    var nav:UINavigationController = UINavigationController()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor =  UIColor(hex: Constants.Colors.redText_borderColor, alpha: 1.0)
        nav = sideMenuViewController?.contentViewController as! UINavigationController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(imageView)
        //view.addSubview(userName)
    }
    
    func setTheName(){
        DispatchQueue.main.async {
            print("set the user name")
            self.userName.text = Singelton.sharedInstance.userDataModel.userFirstName! + " " + Singelton.sharedInstance.userDataModel.userLastName!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK : TableViewDataSource & Delegate Methods

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? Strings_Const.SideBarMenuItems_host.count : Strings_Const.SideBarMenuItems_User.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        indexPath.row != 0 ?  (cell.textLabel?.font = UIFont(name: Constants.fonts.ProximaNova_Regular , size: 18)) : (cell.textLabel?.font = UIFont(name: Constants.fonts.ProximaNova_Bold , size: 20))
        cell.textLabel?.textColor = UIColor.white
        indexPath.row != 0 ? (cell.textLabel?.text  = Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? Strings_Const.SideBarMenuItems_host[indexPath.row] : Strings_Const.SideBarMenuItems_User[indexPath.row]) : (cell.textLabel?.text = Singelton.sharedInstance.userDataModel.userFirstName! + " " + Singelton.sharedInstance.userDataModel.userLastName! )
        print("cell width \(String(describing: cell.textLabel?.width))")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .right
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select option form the side menu ")
        let clickItemsInfo = ["click_Items" : indexPath.row ]
        NotificationCenter.default.post(name: Notification.Name(rawValue:"Click_MenuItems"), object: nil, userInfo: clickItemsInfo)
        if Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER"{
            switch indexPath.row {
            case 4:
                print("switch to HOST \(UserDefaults.standard.value(forKey: "userData") as! [String : Any])")
                var userData = UserDefaults.standard.value(forKey: "userData") as! [String : Any]
                userData.updateValue("ROLE_USER", forKey: "role")
                print("After change \(userData)")
                UserDefaults.standard.set(userData , forKey: "userData")
                Singelton.sharedInstance.setUserData(data: userData)
                tableView.frame = CGRect(x: self.view.frame.width - 200, y: 200, width: 200, height: CGFloat(54 * (Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? Strings_Const.SideBarMenuItems_host.count : Strings_Const.SideBarMenuItems_User.count)))
                self.tableView.reloadData()
                NotificationCenter.default.post(name: Notification.Name(rawValue:"Switch_User"), object: nil, userInfo: nil)
            default:
                print("default")
            }
        }else{
            switch indexPath.row {
            case 4:
                print("switch to user \(UserDefaults.standard.value(forKey: "userData") as! [String : Any])")
                var userData = UserDefaults.standard.value(forKey: "userData") as! [String : Any]
                userData.updateValue("ROLE_HOST", forKey: "role")
                print("After change \(userData)")
                UserDefaults.standard.set(userData , forKey: "userData")
                Singelton.sharedInstance.setUserData(data: userData)
                print(Singelton.sharedInstance.userDataModel.userRole!)
                tableView.frame = CGRect(x: self.view.frame.width - 200, y: 200, width: 200, height: CGFloat(54 * (Singelton.sharedInstance.userDataModel.userRole! != "ROLE_USER" ? Strings_Const.SideBarMenuItems_host.count : Strings_Const.SideBarMenuItems_User.count)))
                self.tableView.reloadData()
                NotificationCenter.default.post(name: Notification.Name(rawValue:"Switch_User"), object: nil, userInfo: nil)
            default:
                print("default")
            }
        }
        sideMenuViewController.hideViewController()
    }
}

