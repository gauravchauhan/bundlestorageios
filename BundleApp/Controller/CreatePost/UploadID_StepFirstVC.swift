//
//  UploadID_StepFirstVC.swift
//  BundleApp
//
//  Created by Vijay Mishra on 20/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class UploadID_StepFirstVC: UIViewController, SelectedImage {

    @IBOutlet weak var proof_Image: UIImageView!
    
    var imagePicker : ImagePiker!
    var imageData : NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.setRightBarButtonItems(Step: "01")
        self.setBackButtonWithTitle(title: "Create")
        // Do any additional setup after loading the view.
        let tapUploadImage = UITapGestureRecognizer(target: self, action: #selector(self.clickImageButton))
        self.proof_Image.isUserInteractionEnabled = true
        self.proof_Image.addGestureRecognizer(tapUploadImage)
    }
    
    //MARK:- Delgate
    
    func pickerResponse(userImage: UIImage, imageData: Any) {
        print("get image \(userImage)   \(imageData)")
        self.proof_Image.image = userImage
        self.imageData = imageData as? NSData
    }
    
    //MARK:- user defined function
    
    @objc func clickImageButton(){
        imagePicker = ImagePiker(screen: self)
        imagePicker.delegate = self
        imagePicker.openPicker(pickerOpenType: "uploadProfile")
    }
    
    //MARK:- Actions
    
    @IBAction func click_UploadButton(_ sender: Any) {
        self.clickImageButton()
    }
    
    @IBAction func click_NextBttn(_ sender: Any) {
        self.pushToSpaceSelectController()
    }
}
