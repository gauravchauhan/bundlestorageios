//
//  Extenson.swift
//  WIfiSwitchApp
//
//  Created by Rohit Gupta on 11/05/18.
//  Copyright © 2018 Rohit Gupta. All rights reserved.
//
import UIKit
import GoogleMaps

extension GMSMapView{
    
    func addMarker(position : CLLocationCoordinate2D, title : String){
        DispatchQueue.main.async
            {
                print(position)
                // 2. Perform UI Operations.
                let position = position
                let marker = GMSMarker(position: position)
                marker.title = title
                marker.map = self
                self.setMinZoom(4, maxZoom: 10)
        }
    }
    
    func setTheCameraPosition(firstPosition : CLLocationCoordinate2D , lastPosition : CLLocationCoordinate2D){
        DispatchQueue.main.async
            {
                let firstCordinates = firstPosition
                let lastCordinates = lastPosition
                let bounds = GMSCoordinateBounds(coordinate: firstCordinates, coordinate: lastCordinates)
                let camera = self.camera(for: bounds, insets: UIEdgeInsets())!
                self.camera = camera
        }
    }
    
}



protocol BackButtonDelegate {
    func click_BackButton()
}

let gradientLayer = CAGradientLayer()

func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
    let imageView: UIImageView = UIImageView(image: image)
    let layer = imageView.layer
    layer.masksToBounds = true
    layer.cornerRadius = radius
    UIGraphicsBeginImageContext(imageView.bounds.size)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return roundedImage!
}

//func currentLocation()-> (Double , Double){
//    var currentLocation: CLLocation!
//    if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//        CLLocationManager.authorizationStatus() ==  .authorizedAlways){
//        currentLocation = locManager.location
//        print(currentLocation.coordinate.latitude)
//        print(currentLocation.coordinate.longitude)
//    }
//    return (currentLocation.coordinate.latitude , currentLocation.coordinate.longitude)
//}

func makeFontBold (location : Int, length : Int , String :  String)-> NSAttributedString{
    
    let myMutableString = NSMutableAttributedString(
        string: String ,
        attributes: [:])
    
    myMutableString.addAttribute(
        NSAttributedString.Key.font,
        value: UIFont.fontNames(forFamilyName: "Montserrat-SemiBold"),
        range: NSRange(
            location:location,
            length:length))
    
    return myMutableString
}


func showActionsheet(viewController: UIViewController, title: String, message:String, actions: [[String:UIAlertAction.Style]], completion: @escaping (_ index: Int) -> ()) {
    
    let alertViewController = UIAlertController(title:title, message: message, preferredStyle: .actionSheet)
    let btn = UIButton()
    
    for (index,action) in actions.enumerated() {
        
        for actionContent in action {
            let action = UIAlertAction(title: actionContent.key, style: actionContent.value) { (action) in
                completion(index)
            }
            alertViewController.addAction(action)
        }
    }
    //    viewController.present(alertViewController, animated: true, completion: nil)
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad )
    {
        if let currentPopoverpresentioncontroller = alertViewController.popoverPresentationController{
            currentPopoverpresentioncontroller.sourceView = btn
            currentPopoverpresentioncontroller.sourceRect = btn.bounds;
            currentPopoverpresentioncontroller.permittedArrowDirections = UIPopoverArrowDirection.up;
            viewController.present(alertViewController, animated: true, completion: nil)
        }
    }else{
        viewController.present(alertViewController, animated: true, completion: nil)
    }
    
}

func colorString (location : Int, length : Int , String :  String, Color : UIColor)-> NSAttributedString{
    
    let myMutableString = NSMutableAttributedString(
        string: String ,
        attributes: [:])
    
    myMutableString.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: Color,
        range: NSRange(
            location:location,
            length:length))
    return myMutableString
}

func breZerPAth(View : UIView){
    let maskPath1 = UIBezierPath(roundedRect: View.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = View.bounds
    maskLayer1.path  = maskPath1.cgPath
    View.layer.mask = maskLayer1
}

func alert(message : String, Controller : UIViewController ){
    DispatchQueue.main.async {
        let alertView = UIAlertController(title: NSLocalizedString(Strings_Const.app_Name, comment: ""), message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(action)
        Controller.present(alertView, animated: true, completion: nil)
    }
}

func getPostString(params:[String:Any]) -> String
{
    var data = [String]()
    for(key, value) in params
    {
        data.append(key + "=\(value)")
    }
    return data.map { String($0) }.joined(separator: "&")
}

func setupGradientButtonBGView(gradientView:UIView , screen : UIViewController)
{
    gradientLayer.frame.size = gradientView.frame.size
    gradientLayer.colors = [ UIColor(hex: UInt32(Int32(Constants.Colors.firstGradientColor)), alpha: 1.0).cgColor , UIColor(hex: UInt32(Int32(Constants.Colors.secondGradientColor)), alpha: 1.0).cgColor, UIColor(hex: UInt32(Int32(Constants.Colors.thirdGradientColor)), alpha: 1.0).cgColor]
    gradientLayer.startPoint = CGPoint(x: 1, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    gradientLayer.frame.size.height = gradientView.height
    gradientLayer.frame.size.width = screen.view.width
    gradientView.layer.addSublayer(gradientLayer)
}

//func changeButtonGradientColor(gradientView:UIView , width : CGFloat , height : CGFloat){
//    gradientLayer.frame.size = gradientView.frame.size
//    gradientLayer.colors = [ UIColor(hex: UInt32(Int32(Constants.Colors.firstGradientColor)), alpha: 1.0).cgColor , UIColor(hex: UInt32(Int32(Constants.Colors.secondGradientColor)), alpha: 1.0).cgColor]
//    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//    gradientLayer.endPoint = CGPoint(x: 0.65, y: 1.0)
//    print("button width   \(width)")
//    gradientLayer.frame.size.height = height
//    gradientLayer.frame.size.width = width
//    gradientView.layer.addSublayer(gradientLayer)
//}

/*func animation(image : UIImageView){
 
 image.animationImages = [
 
 UIImage(named: "backImage_one")!,
 UIImage(named: "backImage_two")!,
 UIImage(named: "backImage_three")!,
 UIImage(named: "backImage_four")!,
 ]
 
 image.animationDuration = 7.5
 
 image.startAnimating()
 
 }*/

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}

func stringToDate(date : String , comingPattern : String , OutGoingPattern : String)-> Date{
    
    print("Date Coming \(date)")
    
    let dateFormatter = DateFormatter()
    
    //dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa"
    
    dateFormatter.dateFormat = comingPattern
    
    //let date = dateFormatter.date(from: date)
    
    let date = dateFormatter.date(from: date)
    
    //dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    dateFormatter.dateFormat = OutGoingPattern
    
    //  _ = dateFormatter.string(from: date!)
    
    print("Converted Date: \(date!)")
    
    return date!
    
}

extension UITableView{
    func reloaSpecificIndex(index : Int , section : Int){
        let indexPath = NSIndexPath(row: index, section: section)
        self.reloadRows(at: [indexPath as IndexPath], with: .fade)
    }
    
    func reloadTable(){
        DispatchQueue.main.async {
            self.delegate = self as? UITableViewDelegate
            self.dataSource = self as? UITableViewDataSource
            self.reloadData()
        }
    }
}

func relativeDateString(for date: Date) -> (String , Int) {
    
    let components : DateComponents = Calendar.current.dateComponents([.day, .weekOfYear, .month, .year, .hour, .minute, .second] , from: date, to: Date())
    
    print("Whole   \(components)")
    
    if components.year! > 0  {
        return ("years ago" , components.year!)
    }
    else if (components.month!) > 0 {
        return ("month ago" , components.month!)
    }
    else if components.weekOfYear! > 0 {
        return ("week ago", components.weekOfYear!)
    }
    else if components.day! > 0 {
        if components.day! > 1 {
            return ("days ago", components.day!)
        }
        else {
            return ("Yesterday" , components.day!)
        }
    }
    else if components.hour! > 0 {
        
        return ("Hours ago",  components.hour!)
        
    }else if components.minute! > 0 {
        
        return ("minutes ago", components.minute!)
    }
    
    return ("Today" , 0)
    
}


//extension Date{
//    var time: Time {
//        return Time(self)
//    }
//}

extension UINavigationBar {
    func setGradientBackground(colors: [UIColor]) {
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 1)
        endPoint = CGPoint(x: 0.8, y: 1)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}

func json(from object:Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}

extension String {
    
    func validateFB()->Bool {
        
        if self.range(of:"http://facebook.com/") != nil || self.range(of:"http://fb.com/") != nil || self.range(of:"https://facebook.com/") != nil || self.range(of:"http://fb.com/") != nil || self.range(of:"http://www.facebook.com/") != nil || self.range(of:"http://www.fb.com/") != nil || self.range(of:"https://www.facebook.com/") != nil || self.range(of:"http://www.fb.com/") != nil{
            
            return true
            
        }else{
            
            return false
        }
        
    }
    
    func validateUrl()-> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    
    private func matches(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(
            pattern: pattern,
            options: [.caseInsensitive])
        return regex.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: 0, length: utf16.count)) != nil
    }
    
    func isValidURL() -> Bool {
        guard let url = URL(string: self) else { return false }
        if !UIApplication.shared.canOpenURL(url) {
            return false
        }
        let urlPattern = "^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"
        return self.matches(pattern: urlPattern)
    }
}



extension String {
    
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    func retriveDate()-> String{
        
        var chr =  self.components(separatedBy: " ")
        
        return chr[0]
    }
    
    func retriveTime()-> String{
        
        var chr =  self.components(separatedBy: " ")
        
        return chr[1]
    }
    
    func split(regex pattern: String) -> [String] {
        
        guard let re = try? NSRegularExpression(pattern: pattern, options: [])
            else { return [] }
        
        let nsString = self as NSString // needed for range compatibility
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        
        return modifiedString.components(separatedBy: stop)
        
    }
    
    
    func trimeeCharacterWhiteSpace()-> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    func timeConversion()-> String{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"//this your string date format
        
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "h:mm a"///this is you want to convert format
        
        dateFormatter.timeZone = NSTimeZone.system
        
        let dateStamp = dateFormatter.string(from: date!)
        
        return dateStamp
    }
    
    func dateConversion(requiredFormat : String , comingFormat : String) -> (String , Date)
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = comingFormat//this your string date format
        
        let date = dateFormatter.date(from: self)
        
        //        dateFormatter.dateFormat = ""///this is you want to convert format
        dateFormatter.dateFormat = requiredFormat
        
        dateFormatter.timeZone = NSTimeZone.system
        
        let dateStamp = dateFormatter.string(from: date!)
        
        return (dateStamp , date!)
    }
    
    
    
    func dateFromService() -> String
    {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"//this your string date format
        
        let date = dateFormatter.date(from: self)
        
        print(date!)
        
        dateFormatter.dateFormat = "dd MMM, yyyy"///this is you want to convert format
        
        let timeStamp = dateFormatter.string(from: date!)
        
        print(timeStamp)
        
        return timeStamp
        
    }
    
    
    func dateFromServiceforFav() -> String
    {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d, yyyy"//this your string date format
        
        let date = dateFormatter.date(from: self)
        
        print(date!)
        
        dateFormatter.dateFormat = "dd MMM yyyy"///this is you want to convert format
        
        let timeStamp = dateFormatter.string(from: date!)
        
        
        print(timeStamp)
        
        return timeStamp
        
    }
    
    
    
    
    
    
    func fromDate() -> String
    {
        print(self)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"//this your string date format
        
        let date = dateFormatter.date(from: self)
        
        print(date!)
        
        dateFormatter.dateFormat = "dd MMM yyyy"///this is you want to convert format
        
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    
    func fromDateService() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"//this your string date format
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "yyyy-mm-dd"///this is you want to convert format
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
    
    
    func fromTimeService() -> String
    {   print(self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"//this your string date format
        let date = dateFormatter.date(from: self)
        
        
        dateFormatter.dateFormat = "hh:mm:ssa"///this is you want to convert format
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    
    func timeFromService() -> String
    {   print(self)
        if self != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"//this your string date format
            let date = dateFormatter.date(from: self)
            
            
            dateFormatter.dateFormat = "h:mm a"///this is you want to convert format
            let timeStamp = dateFormatter.string(from: date!)
            
            
            return timeStamp
            
        }
        else{
            
            return ""
        }
    }
    
}

extension UILabel
{
    var optimalWidth : CGFloat
    {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width:  CGFloat.greatestFiniteMagnitude, height:  self.frame.height))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            
            return label.frame.width
        }
    }
    
    var optimalHieght : CGFloat
    {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width , height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            
            label.sizeToFit()
            
            return label.frame.height
        }
    }
    
}

extension UIView {
    func cardView(cornerRadius: CGFloat = 20, shadowOffsetWidth: Int = 1, shadowOffsetHeight: Int = 3,shadowOpacity:Float = 0.8){
        
        
        //  let cornerRadius: CGFloat = 1
        
        //        let shadowOffsetWidth: Int = 0
        //        let shadowOffsetHeight: Int = 3
        let shadowColor: UIColor? = UIColor.gray
        // let shadowOpacity: Float = 0.8
        
        self.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        self.layer.masksToBounds = true
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = shadowPath.cgPath
        
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}


extension UILabel {
    
    //   func getUnderlineText() -> NSMutableAttributedString{
    //
    //        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.text!)
    //
    //        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
    //
    //        return attributeString
    //
    //    }
    //
}

extension UIView{
    
    func showAnimate()
    {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.removeFromSuperview()
            }
        });
    }
    
    func PopUpAnimatedView(){
        
        self.transform = CGAffineTransform(translationX: 0, y: +self.frame.size.height)
        
        UIView.animate(withDuration: 1.5, delay: 0.05 , usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }, completion: nil)
        
    }
    
    func PopDownAnimatedView(){
        
        self.transform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 1.5, delay: 0.05 , usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: +(self.frame.size.height + 50))
        }, completion: {_ in
            self.isHidden = true
        })
    }
    
    var width: CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            self.frame.size.height = newValue
        }
    }
    
    var size: CGSize  {
        get{
            return self.frame.size
        }
        set{
            self.frame.size = newValue
        }
    }
    
    var origin:CGPoint {
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin = newValue
        }
    }
    
    var x:          CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            
            self.frame.origin = CGPoint(x: newValue, y: self.frame.origin.y)
            
        }
    }
    
    var y:   CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: newValue)
        }
    }
    
    var centerX:    CGFloat {
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var centerY:    CGFloat {
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    var minX:       CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    
    var maxX:      CGFloat {
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }
    
    var minY:        CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    var maxY:     CGFloat {
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set{
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }
    
    convenience init(
        frame_:CGRect = CGRect.zero,
        backgroundColor:UIColor = UIColor.clear
        ){
        self.init(frame:frame_)
        self.backgroundColor=backgroundColor
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    /// The width of the layer's border, inset from the layer bounds. The border is composited above the layer's content and sublayers and includes the effects of the `cornerRadius' property. Defaults to zero. Animatable.
    
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    /// The color of the layer's border. Defaults to opaque black. Colors created from tiled patterns are supported. Animatable.
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable var shadowColor: UIColor?{
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    
}

extension UIProgressView{
    func setColorAccordingTOStrength(strength : String){
        switch strength {
        case "veryWeak":
            self.progress = 0.5
            self.progressTintColor = UIColor.red
        case "weak":
            self.progress = 0.25
            self.progressTintColor = UIColor.yellow
        case "strong":
            self.progress = 0.75
            self.progressTintColor = UIColor.green
        case "veryStrong":
            self.progress = 1.0
            self.progressTintColor = UIColor.purple
        default:
            self.progressTintColor = UIColor.red
        }
    }
}

extension UIImageView
{
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.3
        blurEffectView.frame = targetImageView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        targetImageView?.addSubview(blurEffectView)
        
    }
    
        func dropShadow() {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.layer.shadowRadius = 1
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }

}


extension UIViewController {
    
    func pushToSignUpController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    func pushToLoginController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    func pushToSignINController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    func pushToEnterCodeController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "EnterVerificationCodeVC") as! EnterVerificationCodeVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    func pushToResetCodeController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    
    func pushToStep_FirstController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "UploadID_StepFirstVC") as! UploadID_StepFirstVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToSpaceSelectController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "SpaceLocatedVC") as! SpaceLocatedVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToDescribeListingController(fromWhichScreen : String){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "DescribeListingVC") as! DescribeListingVC
            next.screnComingFrom = fromWhichScreen
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func openDiscountPopUp(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "DiscountPopUpController") as! DiscountPopUpController
            next.modalPresentationStyle = .overCurrentContext
            self.present(next, animated: true, completion: nil)
        }
    }
    
    func pushToStorageListController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "HostListOnMapVC") as! HostListOnMapVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToSpaceDimensionController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "SelectSpaceDimensionVC") as! SelectSpaceDimensionVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToFeatureController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "FeaturesVC") as! FeaturesVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToDisocuntController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "DiscountVC") as! DiscountVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToSpaceNameController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "SpaceNameVC") as! SpaceNameVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    
    func pushToDescriptionController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToStorageChargeController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "StorageChargeVC") as! StorageChargeVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToTabBarController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            next.selectedIndex = 1
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToUploadStorageImageController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "StorageImageVC") as! StorageImageVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToRegularBookingController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "RegularBooking_VC") as! RegularBooking_VC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToStorageDetailController(detail : StorageListModal){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            next.detailModal = detail
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func pushToChatController(){
        DispatchQueue.main.async {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    
    
    func setLeftButnEmpty(){
        let backBtn = UIButton()
        
        backBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        backBtn.setTitleColor(UIColor.black, for: .normal)
        
        let backNavBtn = UIBarButtonItem.init(customView: backBtn)
        
        backNavBtn.customView = backBtn
        
        let _ = navigationItem.backBarButtonItem
        
        self.navigationItem.leftBarButtonItems = [backNavBtn]
    }
    
    func setBackButtonWithTitle(title : String){
        let backBtn = UIButton()
        
        backBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        backBtn.setImage(UIImage(named:"backButton"), for: .normal)
        
        backBtn.setTitleColor(UIColor.black, for: .normal)
        
        backBtn.addTarget(self, action: #selector(self.click_BackButton), for: .touchUpInside)
        
        let backNavBtn = UIBarButtonItem.init(customView: backBtn)
        
        backNavBtn.customView = backBtn
        
        
        
        // Title Code
        
        let titleLbl = UIButton()
        
        titleLbl.setTitle(title, for: .normal)
        
        titleLbl.titleLabel?.font = UIFont(name: Constants.fonts.ProximaNova_Regular, size: 20)!
        
        titleLbl.frame = CGRect(x: 0, y: 0, width: (titleLbl.titleLabel?.optimalWidth)!, height: 40)
        
        titleLbl.setTitleColor(UIColor(hex: UInt32(Constants.Colors.redText_borderColor), alpha: 1), for: .normal)
        
        let leftItem = UIBarButtonItem.init(customView: titleLbl)
        
        leftItem.customView?.frame = CGRect(x: 0, y: 0, width: (titleLbl.titleLabel?.optimalWidth)!, height: 40)
        
        leftItem.customView = titleLbl
        
        let _ = navigationItem.backBarButtonItem
        
        self.navigationItem.leftBarButtonItems = [backNavBtn, leftItem]
    }
    
    @objc func click_BackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setRightBarButtonItems(Step : String){
        
        //Add right arrow code
        
        let leftArrow = UIButton()
        
        leftArrow.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        leftArrow.setImage(UIImage(named:"rightArrow"), for: .normal)
        
        leftArrow.setTitleColor(UIColor.black, for: .normal)
        
        let letftArrownNavBttn = UIBarButtonItem.init(customView: leftArrow)
        
        letftArrownNavBttn.customView = leftArrow
        
        // Add current step code
        
        let currentStep = UIButton()
        
        currentStep.setTitle("  \(Step)" , for: .normal)
        
        currentStep.titleLabel?.font = UIFont(name: Constants.fonts.ProximaNova_Regular, size: 20)!
        
        currentStep.frame = CGRect(x: 0, y: 0, width: (currentStep.titleLabel?.optimalWidth)!, height: 40)
        
        currentStep.setTitleColor(UIColor(hex: UInt32(Constants.Colors.textColor), alpha: 1), for: .normal)
        
        let currentStepNavBttn = UIBarButtonItem.init(customView: currentStep)
        
        currentStepNavBttn.customView?.frame = CGRect(x: 0, y: 0, width: (currentStep.titleLabel?.optimalWidth)!, height: 40)
        
        currentStepNavBttn.customView = currentStep
        
        
        // Add All step code
        
        let allStep = UIButton()
        
        allStep.setTitle("/ 10", for: .normal)
        
        allStep.titleLabel?.font = UIFont(name: Constants.fonts.ProximaNova_Regular, size: 20)!
        
        allStep.frame = CGRect(x: 0, y: 0, width: (allStep.titleLabel?.optimalWidth)!, height: 40)
        
        allStep.setTitleColor(UIColor(hex: UInt32(Constants.Colors.textTitleColor), alpha: 1), for: .normal)
        
        let allStepNavBttn = UIBarButtonItem.init(customView: allStep)
        
        allStepNavBttn.customView?.frame = CGRect(x: 0, y: 0, width: (allStep.titleLabel?.optimalWidth)!, height: 40)
        
        allStepNavBttn.customView = allStep
        
        // Add left Arrow code
        
        let rightArrow = UIButton()
        
        rightArrow.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        rightArrow.setImage(UIImage(named:"leftArrow"), for: .normal)
        
        rightArrow.setTitleColor(UIColor.black, for: .normal)
        
        let rightArrowNavButton = UIBarButtonItem.init(customView: rightArrow)
        
        rightArrowNavButton.customView = rightArrow
        
        let _ = navigationItem.backBarButtonItem
        
        // Add all the items into right navigation bar array
        
        self.navigationItem.rightBarButtonItems = [letftArrownNavBttn, allStepNavBttn , currentStepNavBttn, rightArrowNavButton]
    }
    
    func addDrawerButton(){
        let leftArrow = UIButton()
        leftArrow.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        leftArrow.setImage(UIImage(named:"menu"), for: .normal)
        leftArrow.setTitleColor(UIColor.black, for: .normal)
        leftArrow.addTarget(self, action: #selector(self.drwaerButtonClicked), for: .touchUpInside)
        let letftArrownNavBttn = UIBarButtonItem.init(customView: leftArrow)
        letftArrownNavBttn.customView = leftArrow
        navigationItem.leftBarButtonItem = letftArrownNavBttn
    }
    
    @objc func drwaerButtonClicked(){
        print("Click Drwaer")
        sideMenuViewController.presentRightMenuViewController()
    }
    
    //Set the notification and filter icon on the tabBar
    
    func setNotification_FilterButton(){
        
        //Notification button
        
        let notificationBtn = UIButton()
        
        notificationBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        notificationBtn.setImage(UIImage(named:"logout"), for: .normal)
        
        notificationBtn.setTitleColor(UIColor.black, for: .normal)
        
        notificationBtn.addTarget(self, action: #selector(self.logout_Click), for: .touchUpInside)
        
        let notificationNavBtn = UIBarButtonItem.init(customView: notificationBtn)
        
        notificationNavBtn.customView = notificationBtn
        
        // filter button
        
        let filterBttn = UIButton()
        
        filterBttn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        filterBttn.setImage(UIImage(named:"filter"), for: .normal)
        
        let filterNavButton = UIBarButtonItem.init(customView: filterBttn)
        
        filterNavButton.customView = filterBttn
        
        let _ = navigationItem.backBarButtonItem
        
        self.navigationItem.rightBarButtonItems = [notificationNavBtn, filterNavButton]
    }
    
    @objc func logout_Click(){
        
        var actions:[[String:UIAlertAction.Style]] = []
        actions.append(["Logout": UIAlertAction.Style.default])
        actions.append(["Cancel": UIAlertAction.Style.cancel])
        showActionsheet(viewController: self, title: "", message: "Are you sure want to logout?", actions: actions) { (index) in
            print("call action \(index)")
            if index == 0 {
                UserDefaults.standard.set(nil , forKey: "userData")
                UserDefaults.standard.set(nil , forKey: "authToken")
                self.pushToLoginController()
            }
        }
       
    }
    
}

extension UITextField{
    func setTheImageWithText(imageName : String){
        self.rightView?.frame = CGRect(x: 200 , y: 0, width: 20 , height:20)
        self.rightViewMode = .always
        self.rightView = UIImageView(image: UIImage(named: "\(imageName)"))
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension Dictionary {
    func nullKeyRemoval() -> Dictionary {
        var dict = self
        
        let keysToRemove = Array(dict.keys).filter { dict[$0] is NSNull }
        for key in keysToRemove {
//            dict.removeValue(forKey: key)
            dict[key] = "" as? Value
        }
        
        return dict
    }
}

extension UIFont {
    var bold: UIFont {
        return with(traits: .traitBold)
    } // bold
    
    var italic: UIFont {
        return with(traits: .traitItalic)
    } // italic
    
    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    } // boldItalic
    
    
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        } // guard
        
        return UIFont(descriptor: descriptor, size: 0)
    } // with(traits:)
} // extension
