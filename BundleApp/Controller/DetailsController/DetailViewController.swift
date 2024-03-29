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

class DetailViewController: UIViewController, NWSTokenDataSource, NWSTokenDelegate, UIScrollViewDelegate , CreateChatDelegate, StorageDetailDelegate{
   
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
    @IBOutlet weak var storage_LengthWidth: UILabel!
    @IBOutlet weak var requestStorageButton: TGFlingActionButton!
    @IBOutlet weak var availablity: UILabel!
    @IBOutlet weak var book_MessageView: UIStackView!
    
    //MARK:- PROPERTIES
    var detailModal = StorageListModal()
    var selectedContacts = [NWSTokenData]()
    var contact: NWSTokenData!
    let tokenViewMinHeight: CGFloat = 40.0
    let tokenViewMaxHeight: CGFloat = 150.0
    var readMoreButtonTitle = "readmore...."
    var storageImages = [SDWebImageSource]()
    
    var storageListID : String!
    var chatId : String!
    var comingFromMyStorage : Bool = false
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.reques==
//        requestStorageButton.
        
        storageTypeLabel.roundCorners(corners: .topLeft, radius: 10)
        self.setData_OnDetailController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let param = "storageId=\(String(describing: self.detailModal.stoargeID!))"
        print("Parameter \(param)")
        Singelton.sharedInstance.service.storageDetailDelegate = self
        Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.storageDetails, api_Type: apiType.POST.rawValue)
        setBackButtonWithTitle(title: "\(self.detailModal.storageName!)")
//        self.requestStorageButton
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view did disappear")
        self.requestStorageButton.reset()
    }
    
    // Swipe button "Request Single from Storage"
    
    func storageDetailResponse(data: [String : Any]) {
        print("storage detail response \(data)")
        data["status"]as! Bool ? (self.chatId = data["chatId"]as? String) : (self.chatId = "")
    }
    
    
    //MARK:- Actions
    @IBAction func drag_SingleStorageButton(_ sender: TGFlingActionButton) {
        print(self.requestStorageButton.swipe_direction)
        self.pushToSingleBookingController(storageId: self.detailModal.stoargeID!, hostID:  self.detailModal.storageHostId!)
    }
    

    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        self.pushToRegularBookingController(storageId: self.detailModal.stoargeID!, hostID:  self.detailModal.storageHostId!)
    }
    
    @IBAction func messageButtonClicked(_ sender: UIButton) {
        if self.chatId.isEmpty{
            let param = "user=\(String(describing: self.detailModal.storageHostId!))"
            print("Parameter \(param)")
            Singelton.sharedInstance.service.createChatDelegate = self
            Singelton.sharedInstance.service.PostService(parameter: param, apiName: Constants.AppUrls.createChat, api_Type: apiType.POST.rawValue)
        }else{
            self.pushToChatController(userName: self.detailModal.storageHostName!, chatId: self.chatId! , reciverId: self.detailModal.storageHostId!)
        }
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
    
    @IBAction func click_OfferButton(_ sender: Any) {
        detailModal.offers != "Discard offer discount" ? self.openDiscountPopUp(offerData: detailModal.offers!) : alert(message: "No discount", Controller: self)
        
    }
    //MARK:- User defined function
    
    func createChatResponse(data: [String : Any]) {
        print("craete chat respnse  \(data)")
        data["status"]as! Bool ? self.pushToChatController(userName: self.detailModal.storageHostName!, chatId: data["chatId"]as! String, reciverId: self.detailModal.storageHostId!) : alert(message: data["message"]as! String, Controller: self)
    }
    
    
    
    
    func setData_OnDetailController(){
        self.storageTypeLabel.text! = self.detailModal.storageType!
        self.listingTitle.text! = self.detailModal.storageName!
        self.priceLabel.text! = "$" + self.detailModal.storageDailyPrice! + " per day | $ " + self.detailModal.storageWeeklyPrice! + " per week | $ " + self.detailModal.storageMonthlyPrice! + " per month"
        self.storage_LengthWidth.text! = "Length " + self.detailModal.storageLength! + " ft. " + "Width " + self.detailModal.storageWidth! + " ft."
        self.descriptionLabel.text! = self.detailModal.aboutStorage!
        self.companyName.text! = self.detailModal.storageHostName!
        self.availablity.text! = "AVAILABILITY " + self.detailModal.availablity!
        
        tokenView.layoutIfNeeded()
        tokenView.dataSource = self
        tokenView.delegate = self
        tokenView.textView.isEditable = false
        (self.descriptionLabel.text! == Strings_Const.no_Desc) ? DispatchQueue.main.async {
            self.readmoreButton.isHidden = true
            } : DispatchQueue.main.async {
                self.readmoreButton.isHidden = false
        }
        //Set images into the slider show of image
        
        for data in self.detailModal.allAmenities! {
            print("data   \(data)")
            selectedContacts.append(NWSTokenData.init(name: data as! String))
        }
        tokenView.reloadData()
        tokenView.tintColor = .white
        tokenView.endEditing(true)
        
        self.requestStorageButton.currentImage?.stretchableImage(withLeftCapWidth: 20, topCapHeight: 20)
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
        
        for data in self.detailModal.storageImage!{
            print("Image URl \(data.imageURL!)")
            storageImages.append(SDWebImageSource(urlString: data.imageURL!)!)
            
        }
        //            sliderImages.append(storageImages)
        imageSlideShow.setImageInputs(storageImages)
    }

    // MARK: NWSTokenDataSource
    
    func numberOfTokensForTokenView(_ tokenView: NWSTokenView) -> Int
    {
        return self.detailModal.allAmenities!.count
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

