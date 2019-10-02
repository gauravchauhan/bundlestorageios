//
//  StorageImageVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class StorageImageVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CrossButtonDelegate, SelectedImage, UploadStorageFileDelegate, RemoveFileDelegate{
    
    @IBOutlet weak var uploadImageList: UICollectionView!
    
    private var uploadImageModal  = [UploadImageModal]()
    var imagePicker : ImagePiker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightBarButtonItems(Step: "09")
        self.setBackButtonWithTitle(title: "Create")
        print("image Data \(uploadImageModal.count)")
        self.uploadImageList.register(UINib(nibName: "UploadImage", bundle: nil), forCellWithReuseIdentifier: "UploadImageCell")
        self.reloadImageList()
    }
    
    
    //MARK:- Delegate
    
    func removeFileResponse(data: [String : Any]) {
        print("removeFileResponse   \(data)")
    }
    
    func uploadStorageFileResponse(data: [String : Any]) {
        print("upload image resposne \(data)")
        Indicator.shared.hideProgressView()
        if data["status"] != nil{
            data["status"]as! Bool ? (self.uploadImageModal[self.uploadImageModal.count - 1].uploadImageID = data["id"]as? String) : DispatchQueue.main.async {
                alert(message: "", Controller: self); self.uploadImageModal.remove(at: self.uploadImageModal.count - 1); self.reloadImageList()
            }
        }
        
    }
    
    func click_Cross(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        print("click index \(cell.tag)")
        Singelton.sharedInstance.service.removeFileDelegate = self
        let param = "id=\(String(describing: self.uploadImageModal[cell.tag].uploadImageID!))"
        Singelton.sharedInstance.service.PostService(parameter: param , apiName: Constants.AppUrls.removeUploadFile, api_Type: apiType.POST.rawValue)
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
        guard let imageCount : Int = self.uploadImageModal.count , imageCount < 5 else {
            return alert(message: Strings_Const.max_Image, Controller: self)
        }
        Singelton.sharedInstance.service.uploadStorageFileDelegate = self
        Singelton.sharedInstance.service.uploadImageFile(image: imageData as! NSData, imageParameter: "fileData", apiName: Constants.AppUrls.uploadFile, parameter: ["userId" : Singelton.sharedInstance.userDataModel.userID! as NSObject])
        self.uploadImageModal.append(image_Description)
        Indicator.shared.showProgressView(self.view)
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
    
    //MARK:- Actions
    
    @IBAction func click_NexrButton(_ sender: Any) {
        //        Singelton.sharedInstance.addStorageModal.storageImages = \
        guard let imageCountNotBeZero : Int = self.uploadImageModal.count , imageCountNotBeZero != 0 else {
            return alert(message: Strings_Const.min_Image, Controller: self)
        }
        print(self.uploadImageModal.map({$0.uploadImageID}) as NSArray)
        Singelton.sharedInstance.addStorageModal.storageImages = self.uploadImageModal.map({$0.uploadImageID}) as NSArray
        self.pushToSpaceNameController()
    }
    
    
}
