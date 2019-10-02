//
//  SingleItemRequest_VC.swift
//  BundleApp
//
//  Created by rohit on 12/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class SingleItemRequest_VC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , CrossButtonDelegate, SelectedImage ,  UITableViewDataSource, UITableViewDelegate{
    
    //MARK:- Outlets
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var itemList : UITableView!
    @IBOutlet weak var disclamerLabel: UILabel!
    
    //MARK:- Properties
    
    var singleStorageImageModal = [UploadImageModal]()
    var imagePicker : ImagePiker!
    var itemListModal = [ListingModal]()
    var itemListContent = [Strings_Const.small_item, Strings_Const.medium_item, Strings_Const.large_item]
    var itemListDescribtion = [Strings_Const.small_items, Strings_Const.medium_items, Strings_Const.large_items]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonWithTitle(title: "Single item storage")
        let boldText  = "Disclamer:"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 11)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let normalText = " Item size is approximate, estimate as best as you can."
        let normalString = NSMutableAttributedString(string:normalText)
        attributedString.append(normalString)
        disclamerLabel.attributedText = attributedString
        // Do any additional setup after loading the view.
        for index in 0...self.itemListContent.count - 1{
            let list = ListingModal()
            list.listingType = self.itemListContent[index]
            list.selectedStatus = false
            self.itemListModal.append(list)
        }
        
        self.imageCollectionView.register(UINib(nibName: "UploadImage", bundle: nil), forCellWithReuseIdentifier: "UploadImageCell")
        itemList.register(UINib(nibName: "PickSingleItemCell", bundle: nil), forCellReuseIdentifier: "PickSingleItemCell")
        self.reloadImagList()
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func addAnotherButtonClicked(_ sender: UIButton) {
    }
    
    //MARK:- User Defined function
    
    func reloadImagList(){
        DispatchQueue.main.async {
            self.imageCollectionView.delegate = self
            self.imageCollectionView.dataSource = self
            self.imageCollectionView.reloadData()
        }
    }
    
    
    //MARK:- Delegate
    
    func pickerResponse(userImage: UIImage, imageData: Any) {
        let image_Description = UploadImageModal()
        image_Description.uploadImage = userImage
        image_Description.uploadImageData = imageData
        image_Description.uploadImageID = ""
        self.singleStorageImageModal.append(image_Description)
        self.reloadImagList()
    }
    
    
    func click_Cross(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        print("Cross clicked \(cell.tag)")
        self.singleStorageImageModal.remove(at: cell.tag)
        self.reloadImagList()
    }
    
    func click_UplaodImage(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        imagePicker = ImagePiker(screen: self)
        imagePicker.delegate = self
        imagePicker.openPicker(pickerOpenType: "uploadProfile")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.singleStorageImageModal.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: "UploadImageCell", for: indexPath)as! UploadImageCell
        //cell.backgroundColor = UIColor.red
        cell.tag = indexPath.row
        cell.crossDelegate = self
        if indexPath.row == self.singleStorageImageModal.count{
            print("uploadImageArray  ")
            cell.cross_Button.isHidden = true
            cell.storageImage.image = UIImage(named: "addButton")
            cell.uploadImageButton.isHidden = false
        }else{
            cell.cross_Button.isHidden = false
            cell.storageImage.image = self.singleStorageImageModal[indexPath.row].uploadImage
            cell.uploadImageButton.isHidden = true
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 80 , height:  100)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListModal.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  self.itemList.dequeueReusableCell(withIdentifier: "PickSingleItemCell", for: indexPath) as! PickSingleItemCell
        cell.itemTitleLabel.text! = self.itemListModal[indexPath.row].listingType!
        cell.ItemDesclabel.text! = self.itemListDescribtion[indexPath.row]
        if self.itemListModal[indexPath.row].selectedStatus!{
            cell.generalView.isHidden =  true
            cell.selectedView.isHidden =  false
        }else{
            cell.generalView.isHidden =  false
            cell.selectedView.isHidden =  true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let findIndex = self.itemListModal.firstIndex(where: {
            $0.selectedStatus == true
        }){
            print("Index if selected \(findIndex)")
            self.itemListModal[findIndex].selectedStatus?.toggle()
        }
        self.itemListModal[indexPath.row].selectedStatus?.toggle()
        self.itemList.reloadData()
    }
    
    
}

//MARK:- Extensions
