//
//  RegularBooking_VC.swift
//  BundleApp
//
//  Created by rohit on 06/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class RegularBooking_VC: UIViewController , UITextViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource , CrossButtonDelegate, SelectedImage, UploadStorageFileDelegate , RemoveFileDelegate , DateTimeDelegate, BookingStorageDelegate{
    
    
    //MARK:- Outlets
    @IBOutlet weak var startDateTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var endDatetextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var disclamerLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var datePicker: DateTime!
    
    var startDate : Date!
    var endDate : Date!
    var storageId : String?
    var hostId : String?
    
    //MARK:- Properties
    
    var storageImageModal = [UploadImageModal]()
    var imagePicker : ImagePiker!
    var startDateClick : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButtonWithTitle(title: "Book Space")
        self.datePicker.delegate = self
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
    
    
    //MARK:- User Defined functions
    
    func validatio_For_Field(){
        guard let imageCountNotBeZero : Int = self.storageImageModal.count , imageCountNotBeZero != 0 else {
            return alert(message: Strings_Const.min_Image, Controller: self)
        }
        guard let startDateText : String = self.startDateTextField.text , startDateText != "" else {
            return alert(message: Strings_Const.select_end_date, Controller: self)
        }
        guard let endDateText : String = self.endDatetextField.text , endDateText != "" else {
            return alert(message: Strings_Const.select_start_date, Controller: self)
        }
        guard let desc : String = self.descriptionTextView.text , desc != "" else {
            return alert(message: Strings_Const.enter_Description, Controller: self)
        }
        //self.uploadImageModal.map({$0.uploadImageID}) as NSArra
        
        let param = "startDate=\(String(describing: self.startDateTextField.text!))&endDate=\(String(describing: self.endDatetextField.text!))&bookingType=regular&storage=\(String(describing: self.storageId!))&host=\(String(describing: self.hostId!))&media=\(String(describing: self.storageImageModal.map({$0.uploadImageID}) as NSArray))&description=\(String(describing: self.descriptionTextView.text!))"
        print("Paramter \(param)")
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.bookingStorageDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.bookingStorage, api_Type: apiType.POST.rawValue)
        
    }
    
    func reloadImageList(){
        DispatchQueue.main.async {
            self.imageCollectionView.delegate = self
            self.imageCollectionView.dataSource = self
            self.imageCollectionView.reloadData()
        }
    }
    
    
    //MARK:- Delagte
    
    func bookingStorageResponse(data: [String : Any]) {
        print("Storage response \(data)")
        Indicator.shared.hideProgressView()
        data["status"]as! Bool ? self.pushToPaymentController() : alert(message: data["message"]as! String, Controller: self)
        
    }
    
    func doneBtnPressed() {
        print("Done pressed")
        if self.startDateClick{
            self.startDate =  self.datePicker.datePicker.date
            self.startDateTextField.text! = "\(self.datePicker.datePicker.date)".dateConversion (requiredFormat: "MM/dd/yyyy" , comingFormat: "yyyy-MM-dd HH:mm:ss Z").0
        }else{
            print("date validate check \(self.datePicker.datePicker.date > self.startDate)")
            (self.datePicker.datePicker.date > self.startDate) ? DispatchQueue.main.async {
                (self.endDatetextField.text! = "\(self.datePicker.datePicker.date)".dateConversion (requiredFormat: "MM/dd/yyyy" , comingFormat: "yyyy-MM-dd HH:mm:ss Z").0); (self.endDate =  self.datePicker.datePicker.date)
                } : alert(message: Strings_Const.end_date , Controller: self)
        }
        self.cancelBtnPressed()
    }
    
    func cancelBtnPressed() {
        print("cancel pressed")
        self.datePicker.isHidden = true
    }
    
    func uploadStorageFileResponse(data: [String : Any]) {
        print("upload resposne  \(data)")
        Indicator.shared.hideProgressView()
        if data["status"] != nil{
            data["status"]as! Bool ? (self.storageImageModal[self.storageImageModal.count - 1].uploadImageID = data["id"]as? String) : DispatchQueue.main.async {
                alert(message: "", Controller: self); self.storageImageModal.remove(at: self.storageImageModal.count - 1); self.reloadImageList()
            }
        }
    }
    
    func removeFileResponse(data: [String : Any]) {
        print("remove response \(data)")
    }
    
    func pickerResponse(userImage: UIImage, imageData: Any) {
        let image_Description = UploadImageModal()
        image_Description.uploadImage = userImage
        image_Description.uploadImageData = imageData
        image_Description.uploadImageID = ""
        guard let imageCount : Int = self.storageImageModal.count , imageCount < 5 else {
            return alert(message: Strings_Const.max_Image, Controller: self)
        }
        Singelton.sharedInstance.service.uploadStorageFileDelegate = self
        Singelton.sharedInstance.service.uploadImageFile(image: imageData as! NSData, imageParameter: "fileData", apiName: Constants.AppUrls.uploadFile, parameter: ["userId" : Singelton.sharedInstance.userDataModel.userID! as NSObject])
        Indicator.shared.showProgressView(self.view)
        self.storageImageModal.append(image_Description)
        self.reloadImageList()
    }
    
    
    func click_Cross(_ cell: UICollectionViewCell, didPressButton: UIButton) {
        print("Cross clicked \(cell.tag)")
        Singelton.sharedInstance.service.removeFileDelegate = self
        let param = "id=\(String(describing: self.storageImageModal[cell.tag].uploadImageID!))"
        Singelton.sharedInstance.service.PostService(parameter: param , apiName: Constants.AppUrls.removeUploadFile, api_Type: apiType.POST.rawValue)
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
    
    
        //MARK:- Actions
    @IBAction func click_StartDate(_ sender: Any) {
        self.startDateClick = true
        self.datePicker.isHidden = false
        self.datePicker.PopUpAnimatedView()
    }
    
    @IBAction func click_EndDate(_ sender: Any) {
        self.startDateClick = false
        self.datePicker.isHidden = false
        self.datePicker.PopUpAnimatedView()
    }
    
    @IBAction func click_SubmitButton(_ sender: Any) {
        self.validatio_For_Field()
    }
    
}

