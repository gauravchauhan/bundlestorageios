//
//  AddImageCollectionViewCell.swift
//  BundleApp
//
//  Created by rohit on 06/09/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit

protocol AddImageCellDelegate: class {
    func addButtonTapped(_ tag: Int)
}

class AddImageCollectionViewCell: UICollectionViewCell {

    //MARK:- Outlets
    @IBOutlet weak var btnAdd: UIButton!
    //MARK:- Properties
    var delegate: AddImageCellDelegate?
    
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.lightGray.cgColor
        yourViewBorder.lineDashPattern = [5, 2]
        yourViewBorder.frame = btnAdd.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: btnAdd.bounds).cgPath
        btnAdd.layer.addSublayer(yourViewBorder)
    }
    
    
    @IBAction func addImageButtonClicked(_ sender: UIButton) {
        self.delegate?.addButtonTapped(sender.tag)
    }
    
}
