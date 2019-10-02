//
//  RegularBooking_VC.swift
//  BundleApp
//
//  Created by rohit on 06/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class RegularBooking_VC: UIViewController , UITextViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource , CrossButtonDelegate, SelectedImage {
    
    
    //MARK:- Outlets
    @IBOutlet weak var startDateTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var endDatetextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var disclamerLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK:- Properties
    
    var storageImageModal = [UploadImageModal]()
    var imagePicker : ImagePiker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButtonWithTitle(title: "Regular Booking")
        
        let boldText  = "Disclamer:"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 11)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let normalText = Strings_Const.storage_Book_Message
        let normalString = NSMutableAttributedString(string:normalText)
        attributedString.append(normalString)
        disclamerLabel.attributedText = attributedString
        
        descriptionTextView.text = Strings_Const.describe_What_Space
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageCollectionView.register(UINib(nibName: "UploadImage", bundle: nil), forCellWithReuseIdentifier: "UploadImageCell")
        reloadImageList()
    }
    
    //MARK:- Actions
    
    
    //MARK:- User Defined functions
    
    func reloadImageList(){
        DispatchQueue.main.async {
            self.imageCollectionView.delegate = self
            self.imageCollectionView.dataSource = self
            self.imageCollectionView.reloadData()
        }
    }
    
    
    //MARK:- Delagte
    
    func pickerResponse(userImage: UIImage, imageData: Any) {
        let image_Description = UploadImageModal()
        image_Description.uploadImage = userImage
        image_Description.uploadImageData = imageData
        image_Description.uploadImageID = ""
        self.storageImageModal.append(image_Description)
        self.reloadImageList()
    }
    
    
    func click_Cross(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        print("Cross clicked \(cell.tag)")
        self.storageImageModal.remove(at: cell.tag)
        self.reloadImageList()
    }
    
    func click_UplaodImage(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        imagePicker = ImagePiker(screen: self)
        imagePicker.delegate = self
        imagePicker.openPicker(pickerOpenType: "uploadProfile")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Describe what you will be using the space?"
            descriptionTextView.textColor = UIColor.lightGray
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.storageImageModal.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: "UploadImageCell", for: indexPath)as! UploadImageCell
        //cell.backgroundColor = UIColor.red
        cell.tag = indexPath.row
        cell.crossDelegate = self
        if indexPath.row == self.storageImageModal.count{
            print("uploadImageArray  ")
            cell.cross_Button.isHidden = true
            cell.storageImage.image = UIImage(named: "addButton")
            cell.uploadImageButton.isHidden = false
        }else{
            cell.cross_Button.isHidden = false
            cell.storageImage.image = self.storageImageModal[indexPath.row].uploadImage
            cell.uploadImageButton.isHidden = true
        }
        return cell
    }
    
    
}

