//
//  DetailViewController.swift
//  BundleApp
//
//  Created by Rohit Gupta on 27/08/19.
//  Copyright © 2019 Rohit Gupta. All rights reserved.
//

import UIKit
import NWSTokenView
import ImageSlideshow

class DetailViewController: UIViewController, NWSTokenDataSource, NWSTokenDelegate, UIScrollViewDelegate{
   
    // MARK: OUTLETS
    @IBOutlet weak var showOfferButton: UIButton!
    @IBOutlet weak var storageTypeLabel: UILabel!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tokenViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var tokenView: NWSTokenView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readmoreButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    
    //MARK:- PROPERTIES
    var selectedContacts = [NWSTokenData]()
    var contact: NWSTokenData!
    let tokenViewMinHeight: CGFloat = 40.0
    let tokenViewMaxHeight: CGFloat = 150.0
    var readMoreButtonTitle = "readmore...."
    let dataArray : [String] = ["Thor", "Lights Out", "Captian America", "Resident Evil", "Mission Impossible", "MasterMind", "Spiderman", "GodZilla", "Dinasaures", "Titanic"]
   var sliderImages =  [BundleImageSource(imageString: "image1"), BundleImageSource(imageString: "image2"), BundleImageSource(imageString: "image3"), BundleImageSource(imageString: "image1"), BundleImageSource(imageString: "image2"), BundleImageSource(imageString: "image3")]
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        storageTypeLabel.roundCorners(corners: .topLeft, radius: 10)
        
        tokenView.layoutIfNeeded()
        tokenView.dataSource = self
        tokenView.delegate = self
        
        for data in dataArray {
            selectedContacts.append(NWSTokenData.init(name: data))
        }
        tokenView.reloadData()
        tokenView.tintColor = .white
        tokenView.resignFirstResponder()
        tokenView.endEditing(true)
        
        imageSlideShow.slideshowInterval = 5.0
        imageSlideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.gray
        
        imageSlideShow.pageIndicator = pageControl
        imageSlideShow.activityIndicator = DefaultActivityIndicator()
        imageSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal:.center, vertical: .customBottom(padding: 60))
        imageSlideShow.delegate = self
        imageSlideShow.setImageInputs(sliderImages)
        
    }
    
    // Swipe button "Request Single from Storage"
    @IBAction func requestActionCallback(_ sender: TGFlingActionButton) {
        print("action performed")
    }
    
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func messageButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func readMoreButtonClicked(_ sender: UIButton) {
        if readMoreButtonTitle == "readmore...."{
            descriptionLabel.numberOfLines = 0
            descriptionLabel.sizeToFit()
            readmoreButton.setTitle("readless....", for: .normal)
            readMoreButtonTitle = "readless...."
        }else{
            readMoreButtonTitle = "readmore...."
            descriptionLabel.numberOfLines = 2
            readmoreButton.setTitle("readmore....", for: .normal)
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

    // MARK: NWSTokenDataSource
    func numberOfTokensForTokenView(_ tokenView: NWSTokenView) -> Int
    {
        return dataArray.count
    }
    
    func insetsForTokenView(_ tokenView: NWSTokenView) -> UIEdgeInsets?
    {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func titleForTokenViewLabel(_ tokenView: NWSTokenView) -> String?
    {
        return nil
    }
    
    func fontForTokenViewLabel(_ tokenview: NWSTokenView) -> UIFont? {
        return nil
    }
    
    func textColorForTokenViewLabel(_ tokenview: NWSTokenView) -> UIColor? {
        return nil
    }
    
    func titleForTokenViewPlaceholder(_ tokenView: NWSTokenView) -> String?
    {
        return ""
    }
    
    func fontForTokenViewTextView(_ tokenview: NWSTokenView) -> UIFont? {
        return nil
    }
    
    func textColorForTokenViewPlaceholder(_ tokenview: NWSTokenView) -> UIColor? {
        return nil
    }
    
    func textColorForTokenViewTextView(_ tokenview: NWSTokenView) -> UIColor? {
        return nil
    }
    
    func tokenView(_ tokenView: NWSTokenView, viewForTokenAtIndex index: Int) -> UIView?
    {
            let token = NWSImageToken.initWithTitle(selectedContacts[index].name!)
            return token!
        
    }
    
    // MARK: NWSTokenDelegate
    func tokenView(_ tokenView: NWSTokenView, didSelectTokenAtIndex index: Int)
    {
//        let token = tokenView.tokenForIndex(index) as! NWSImageToken
//        token.backgroundColor = UIColor.blue
    }
    
    func tokenView(_ tokenView: NWSTokenView, didDeselectTokenAtIndex index: Int)
    {
//        let token = tokenView.tokenForIndex(index) as! NWSImageToken
//        token.backgroundColor = UIColor.black
    }
    
    func tokenView(_ tokenView: NWSTokenView, didDeleteTokenAtIndex index: Int)
    {
       /// No Use
    }
    
    func tokenView(_ tokenViewDidBeginEditing: NWSTokenView)
    {
       // No Use
    }
    
    func tokenViewDidEndEditing(_ tokenView: NWSTokenView)
    {
        // NO use
    }
    
    func tokenView(_ tokenView: NWSTokenView, didChangeText text: String)
    {
       // No use
    }
    
    func tokenView(_ tokenView: NWSTokenView, didEnterText text: String)
    {
       // NO use
    }
    
    func tokenView(_ tokenView: NWSTokenView, contentSizeChanged size: CGSize)
    {
        self.tokenViewHeightConstraints.constant = max(tokenViewMinHeight,min(size.height, self.tokenViewMaxHeight))
        self.view.layoutIfNeeded()
    }
    
    func tokenView(_ tokenView: NWSTokenView, didFinishLoadingTokens tokenCount: Int)
    {
        
    }

    
}


class NWSTokenData: NSObject
{
    var name: String?
    
    init(name: String)
    {
        self.name = name
    }
}

class NWSTokenViewExampleCell: UITableViewCell
{
    @IBOutlet weak var userTitleLabel: UILabel!
    
    var contact: NWSTokenData!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Round corners

    }
    
    func loadWithContact(_ contact: NWSTokenData)
    {
        self.contact = contact
        userTitleLabel.text = contact.name
    }
    
    //MARK:- rohit code
    
}

extension DetailViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
       
    }
}

