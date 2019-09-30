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
        tableView.frame = CGRect(x: self.view.frame.width - 200, y: 300, width: 200, height: CGFloat(54 * Strings_Const.SideBarMenuItems.count))
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
        imageView.image = UIImage(named: "senderImage")
        imageView.frame = CGRect(x: self.tableView.x + 100, y: self.tableView.height - 150, width: 80 , height: 80)
        imageView.layer.cornerRadius = imageView.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    lazy var userName: UILabel = {
        let name = UILabel()
        name.text = Singelton.sharedInstance.userDataModel.userFirstName! + " "  + Singelton.sharedInstance.userDataModel.userLastName!
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
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(imageView)
        view.addSubview(userName)
    }
    
    func setTheName(){
        DispatchQueue.main.async {
            self.userName.text = "Rohit gupta"
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
        return Strings_Const.SideBarMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: Constants.fonts.ProximaNova_Regular , size: 18)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text  = Strings_Const.SideBarMenuItems[indexPath.row]
        print("cell width \(String(describing: cell.textLabel?.width))")
//        cell.textLabel?.backgroundColor = UIColor.blue
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .right
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select option form the side menu ")
        sideMenuViewController.hideViewController()
    }
}

