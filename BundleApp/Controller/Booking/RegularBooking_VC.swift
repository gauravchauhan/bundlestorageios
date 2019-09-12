//
//  RegularBooking_VC.swift
//  BundleApp
//
//  Created by rohit on 06/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

class RegularBooking_VC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate, AddImageCellDelegate {
   
    

    @IBOutlet weak var startDateTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var endDatetextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var disclamerLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let imagePicker = UIImagePickerController()
    var imageMaxLimit = 5
    var tableViewItemCount = 0
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boldText  = "Disclamer:"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 11)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let normalText = " Booking includes whole space listed, or something of that style."
        let normalString = NSMutableAttributedString(string:normalText)
        attributedString.append(normalString)
        disclamerLabel.attributedText = attributedString
        
        descriptionTextView.text = "Describe what you will be using the space?"
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.delegate = self
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        imageCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
    }
    
    func addButtonTapped(_ tag: Int) {
        print("Button tapped at index:\(tag)")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        
        
        if let popoverController = imagePicker.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
           let selectedImage = image
            imageArray.append(selectedImage)
            self.imageCollectionView.reloadData()
        
       
        picker.dismiss(animated: true, completion: nil)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegularBooking_VC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if imageArray.count<imageMaxLimit{
            tableViewItemCount = imageArray.count+1
        }else{
            tableViewItemCount = imageMaxLimit
        }
        return tableViewItemCount
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row<tableViewItemCount-1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as!
                ImageCollectionViewCell
            if imageArray.count>0{
                cell.imageView.image = imageArray[indexPath.row]
            }
            return cell
        }else{
            if imageArray.count<imageMaxLimit{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
                cell.delegate = self
                cell.btnAdd.tag = indexPath.row
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as!
                ImageCollectionViewCell
                if imageArray.count>0{
                    cell.imageView.image = imageArray[indexPath.row]
                }
                return cell
            }
        }
    }
    
}
