//
//  UploadImageCell.swift
//  BundleApp
//
//  Created by Vijay Mishra on 26/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

protocol CrossButtonDelegate {
    func click_Cross(_ cell: UICollectionViewCell, didPressButton: UIButton)
    func click_UplaodImage(_ cell: UICollectionViewCell, didPressButton: UIButton)
}


class UploadImageCell: UICollectionViewCell {
    
    @IBOutlet weak var storageImage: UIImageView!
    @IBOutlet weak var cross_Button: UIButton!
    @IBOutlet weak var uploadImageButton: UIButton!
    
    var crossDelegate : CrossButtonDelegate!
    
    @IBAction func click_CrossButton(_ sender: UIButton) {
        self.crossDelegate.click_Cross(self, didPressButton: sender)
    }
    
    @IBAction func click_UplaodImage(_ sender: UIButton) {
            self.crossDelegate.click_UplaodImage(self, didPressButton: sender)
    }
    
    
    
}
