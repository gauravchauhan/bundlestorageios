//
//  StorageImageVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class StorageImageVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CrossButtonDelegate, SelectedImage{

    @IBOutlet weak var uploadImageList: UICollectionView!
    
    private var uploadImageModal  = [UploadImageModal]()
    var imagePicker : ImagePiker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("image Data \(uploadImageModal.count)")
        self.uploadImageList.register(UINib(nibName: "UploadImage", bundle: nil), forCellWithReuseIdentifier: "UploadImageCell")
        self.reloadImageList()
    }
    
    
    //MARK:- Delegate
    
    
    func click_Cross(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        print("click index \(cell.tag)")
        self.uploadImageModal.remove(at: cell.tag)
        self.reloadImageList()
    }
    
    func click_UplaodImage(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        print("click uplaod image button")
        imagePicker = ImagePiker(screen: self)
        imagePicker.delegate = self
        imagePicker.openPicker(pickerOpenType: "uploadProfile")
    }
    
    
    func pickerResponse(userImage: UIImage, imageData: Any) {
        print("Picker resposne")
        let image_Description = UploadImageModal()
        image_Description.uploadImage = userImage
        image_Description.uploadImageData = imageData
        image_Description.uploadImageID = ""
        self.uploadImageModal.append(image_Description)
        self.reloadImageList()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.uploadImageModal.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.uploadImageList.dequeueReusableCell(withReuseIdentifier: "UploadImageCell", for: indexPath)as! UploadImageCell
       //cell.backgroundColor = UIColor.red
        cell.tag = indexPath.row
        cell.crossDelegate = self
        if indexPath.row == self.uploadImageModal.count{
            print("uploadImageArray  ")
            cell.cross_Button.isHidden = true
            cell.storageImage.image = UIImage(named: "addButton")
            cell.uploadImageButton.isHidden = false
        }else{
            cell.cross_Button.isHidden = false
            cell.storageImage.image = self.uploadImageModal[indexPath.row].uploadImage
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
    
    //MARK:- User Defined function
    
    func reloadImageList(){
        DispatchQueue.main.async {
            self.uploadImageList.delegate = self
            self.uploadImageList.dataSource = self
            self.uploadImageList.reloadData()
        }
    }
    
    
}
