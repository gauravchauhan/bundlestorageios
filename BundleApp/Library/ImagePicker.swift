//
//  ImagePicker.swift
//  DROR
//
//  Created by Rohit Gupta on 23/10/18.
//  Copyright © 2018 Rohit Gupta. All rights reserved.
//

import Foundation

protocol SelectedImage {
    func pickerResponse(userImage : UIImage,  imageData : Any)
}

class ImagePiker : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var controller : UIViewController!
    var actionSheet : UIAlertController!
    let image_Picker = UIImagePickerController()
    var delegate : SelectedImage!
    
    init(screen : UIViewController) {
        controller = screen
    }
    
    func openPicker(pickerOpenType : String){
        
        actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            switch pickerOpenType {
            case "uploadProfile":
                addGallery()
                addCamera()
                addCancel()
            case "camera":
                addCamera()
                addCancel()
            case "gallery":
                addGallery()
                addCancel()
            default:
                print("")
            }
        }else{
            addGallery()
            addCancel()
        }
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
        }else{
            controller.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func addCamera(){
        actionSheet.addAction(UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default, handler:
            { (alert:UIAlertAction!) -> Void in
                
                self.camera()
                
        }))
        
    }
    func addGallery(){
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default , handler: { (alert:UIAlertAction!) -> Void in
            self.image_Picker.navigationBar.barStyle = .blackTranslucent
            self.gallery()
        }))
    }
    
    func addCancel(){
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
            self.actionSheet.dismiss(animated: true, completion: nil)
        }))
    }
    
    func camera(){
        
        image_Picker.sourceType = .camera
        
        image_Picker.delegate = self
        
        controller.present(image_Picker, animated: true, completion: nil)
        
    }
    
    
    func gallery(){
        
        //        image_Picker.sourceType = .photoLibrary
        image_Picker.sourceType = .savedPhotosAlbum
        
        image_Picker.mediaTypes = ["public.image"]
        
        image_Picker.delegate = self
        
        controller.present(image_Picker, animated: true, completion: nil)
    }
    
    //MARK:- Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("In imagePickerController ")
        //        print("In imagePickerController ")
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        let imageData = UIImageJPEGRepresentation(image, 0.2)
        let imageData = UIImage.jpegData(image)
        delegate.pickerResponse(userImage: image , imageData : imageData)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        print("In imagePickerControllerDidCancel ")
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
}
