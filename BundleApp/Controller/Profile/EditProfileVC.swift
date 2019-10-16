//
//  EditProfileVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 04/10/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class EditProfileVC: UIViewController , SelectedImage, EditProfileDelegate{
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var firstName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lastName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var email: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var phoneNumber: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var address: SkyFloatingLabelTextFieldWithIcon!
    
    
    var imagePicker : ImagePiker!
    var profileImageData : NSData!
    var lat : Double!
    var lng : Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackButtonWithTitle(title: "Edit profile")
        imagePicker = ImagePiker(screen: self)
        imagePicker.delegate = self
    }
    
    
    func setData(){
        print("Singelton.sharedInstance.userDataModel.userProfilePic!   \(Singelton.sharedInstance.userDataModel.userProfilePic!)")
        self.profileImage.setImageWith(URL(string : Singelton.sharedInstance.userDataModel.userProfilePic!), placeholderImage: UIImage(named: "app_Logo"))
        self.firstName.text! = Singelton.sharedInstance.userDataModel.userFirstName!
        self.lastName.text! = Singelton.sharedInstance.userDataModel.userLastName!
        self.email.text! = Singelton.sharedInstance.userDataModel.email!
        self.phoneNumber.text! = Singelton.sharedInstance.userDataModel.userPhoneNumber!
        self.address.text! = Singelton.sharedInstance.userDataModel.userAddress!.storageAddress!
        
        if !self.address.text!.isEmpty{
            self.lat = Double(Singelton.sharedInstance.userDataModel.userAddress!.storageLat!)
            self.lng = Double(Singelton.sharedInstance.userDataModel.userAddress!.storageLng!)
        }
        
    }
    
    func editProfileResponse(data: [String : Any]) {
        print("editProfileResponse   \(data)")
        Indicator.shared.hideProgressView()
        data["status"]as! Bool ? DispatchQueue.main.async {
            var uploadResponse = (data["user"]as! [String : Any]).nullKeyRemoval();
            let location = (uploadResponse["location"]as! [String : Any]).nullKeyRemoval()
            uploadResponse.updateValue( location , forKey: "location")
            UserDefaults.standard.set(uploadResponse , forKey: "userData");
            Singelton.sharedInstance.setUserData(data: uploadResponse);
            } : alert(message: data["message"]as! String, Controller: self)
    }
    
    
    func pickerResponse(userImage: UIImage, imageData: Any) {
        print("Image selected")
        self.profileImage.image =  userImage
        self.profileImageData = imageData as? NSData
    }
    
    
    func validation_ForText(){
        guard let firstName : String = self.firstName.text , firstName != "" else {
            return alert(message: Strings_Const.enter_First_Name, Controller: self)
        }
        guard let secondName : String = self.lastName.text , secondName != "" else {
            return alert(message: Strings_Const.enter_Last_Name, Controller: self)
        }
        
        guard let email : String = self.email.text , email != "" else {
            return alert(message: Strings_Const.enter_Email, Controller: self)
        }
        guard let validEmail : String = self.email.text ,(Singelton.sharedInstance.validation.isValidEmail(validEmail))else {
            return alert(message: Strings_Const.enter_valid_Email , Controller: self)
        }
        guard let contactNumber : String = self.phoneNumber.text , contactNumber != "" else {
            return alert(message: "Enter phone number", Controller: self)
        }
        guard let address : String = self.address.text , address != "" else {
            return alert(message: "Enter address", Controller: self)
        }
        
        print("current image convert into image data \(String(describing: self.profileImage.image!.jpegData(compressionQuality: 0.2))))")
        profileImageData == nil ? (self.profileImageData = self.profileImage.image!.jpegData(compressionQuality: 0.2) as NSData?): nil
        
        let parameter : [NSString : NSObject] =  ["latitude" : self.lat  as NSObject, "longitude" : self.lng as NSObject,"address" : self.address.text! as NSObject, "email" : self.email.text! as NSObject, "mobileNumber" : self.phoneNumber.text! as NSObject, "firstName" : self.firstName.text! as NSObject, "lastName" : self.lastName.text! as NSObject]
        print("Parameter \(parameter)")
        Indicator.shared.showProgressView(self.view)
        Singelton.sharedInstance.service.editProfileDelegate = self
        Singelton.sharedInstance.service.uploadImageFile(image: self.profileImageData as NSData, imageParameter: "fileData", apiName: Constants.AppUrls.editProfile, parameter: parameter )
    }
    
    @IBAction func click_EditProfile(_ sender: Any) {
        imagePicker.openPicker(pickerOpenType: "uploadProfile")
    }
    
    @IBAction func click_Address(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func click_Submitbutton(_ sender: Any) {
        self.validation_ForText()
    }
    
    
}

extension EditProfileVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.address.text! =  place.formattedAddress!
        self.lat = place.coordinate.latitude
        self.lng = place.coordinate.longitude
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        //        placeAutocomplete()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func placeAutocomplete() {
        
        let   placesClient = GMSPlacesClient()
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        placesClient.autocompleteQuery("New Delhi", bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                for result in results {
                    print("Result \(result.attributedFullText) with placeID \(String(describing: result.placeID))")
                    
                }
            }
        })
    }
    
}

