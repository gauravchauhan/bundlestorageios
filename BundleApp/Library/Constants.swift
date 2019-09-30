import UIKit

struct Constants {
    
    /*
     All URLS declare which is used in to the application
     */
    
    struct AppUrls{
        static let baseUrl = "http://4aa6d9cf.ngrok.io"
        static let getListType = "/getListingType"
        static let getAmenities = "/getAmenities"
        static let login = "/login"
        static let signup = "/signup"
        static let socialLogin = "/socialLogin"
        static let verifyOtp = "/verifyOtp"
        static let addStorage = "/addStorage"
        static let getStorageList = "/filterStorage"
        static let govermentID = "/uploadGovernmentIssuedId"
        static let forgotPassword = "/forgotPassword"
        static let uploadFile = "/uploadFile"
        static let removeUploadFile = "/removeUploadFile"
        static let storageDetails = "/storageDetails"
        static let showImage = "/showImage?filePath="
        //storageDetails

    }
    
    struct Google_Credentials {
        static let googleClient_id = "16063448195-fr6rubcljrclhc9re3ria8hdipm24k8f.apps.googleusercontent.com"
        static let googleAPIKey = "AIzaSyAsU61d8SGFtVWNwKbmkaa-PnyUf0PFS08"
    }
    
    
    
    struct fonts {

        static let ProximaNova_Black = "ProximaNova-Black"
        static let ProximaNova_Bold = "ProximaNova-Bold"
        static let ProximaNova_Extrabld = "ProximaNova-Extrabld"
        static let ProximaNova_Light = "ProximaNova-Light"
        static let ProximaNova_Regular = "ProximaNova-Regular"
        static let ProximaNova_Semibold = "ProximaNova-Semibold"
        static let ProximaNova_Thin = "ProximaNova-Thin"
    }
    
    struct Colors{
        static let firstGradientColor : UInt32 = 0xe61225
        static let secondGradientColor : UInt32 = 0xac1421
        static let thirdGradientColor : UInt32 = 0xff4e5e
        static let textTitleColor : UInt32 = 0x999999
        static let textColor : UInt32 = 0x3c3c3c
        static let redText_borderColor : UInt32 = 0xFD0E35
        static let lightGrayColor : UInt32 = 0xF2F2F2
    }
    
    struct Format{
        static let TIME = "h:mm a"
    }
    
    struct networkConnectionErrorMessage{
        var status : String!
        var message : String!
        func toDictionary() -> [String : Any]{
            return ["status": status! ,"message": message!]
        }
    }
}

struct Strings_Const{
    
    static let app_Name = NSLocalizedString("Bundle App", comment: "")
    static let enter_First_Name = NSLocalizedString("Enter first name", comment: "")
    static let enter_Last_Name = NSLocalizedString("Enter last name", comment: "")
    
    static let enter_Email = NSLocalizedString("Enter email", comment: "")
    static let enter_valid_Email = NSLocalizedString("Enter valid email", comment: "")
    static let enter_mobile_Number = NSLocalizedString("Enter mobile number", comment: "")
    static let enter_valid_Mobile_Number = NSLocalizedString("Enter valid mobile number", comment: "")
    static let name_Contain = NSLocalizedString("Name doesn't contain special characters , numbers and symbols", comment: "")
    static let enter_Password = NSLocalizedString("Enter password", comment: "")
    static let enter_Confirm_Password = NSLocalizedString("Enter confirm password", comment: "")
    static let password_Same = NSLocalizedString("Password and confirm password should be same", comment: "")
    static let enter_Company_Name = NSLocalizedString("Enter company name", comment: "")
    static let enter_Email_Or_Phone = NSLocalizedString("Enter email or phone number", comment: "")
    static let enter_Business_Hours = NSLocalizedString("Business Hours", comment: "")
    static let by_appoinment = NSLocalizedString("By appoinment only", comment: "")
    static let select_Atleast_One = NSLocalizedString("Select atleast one item", comment: "")
    static let enter_Address = NSLocalizedString("Enter address", comment: "")
    static let enter_Length = NSLocalizedString("Enter length", comment: "")
    static let enter_Width = NSLocalizedString("Enter width", comment: "")
    static let enter_Storage_Name = NSLocalizedString("Enter Storage Name", comment: "")
    static let enter_Description = NSLocalizedString("Enter Description", comment: "")
    static let upload_Profile = NSLocalizedString("Please upload image", comment: "")
    static let profile = NSLocalizedString("Please upload image", comment: "")
    static let refer = NSLocalizedString("Refer bundle to a friend", comment: "")
    static let support = NSLocalizedString("Support", comment: "")
    static let switch_User = NSLocalizedString("Switch to a user", comment: "")
    static let earnings = NSLocalizedString("My Earnings", comment: "")
    static let logout = NSLocalizedString("logout", comment: "")
    static let someError = NSLocalizedString("Something error", comment: "")
    static let per_Day = NSLocalizedString("Enter per day price", comment: "")
    static let per_Week = NSLocalizedString("Enter per week price", comment: "")
    static let per_Month = NSLocalizedString("Enter per month price", comment: "")
    static let no_Desc = NSLocalizedString("NO description available", comment: "")

    static let message = NSLocalizedString("Message", comment: "")
    static let request = NSLocalizedString("Request", comment: "")
    static let SideBarMenuItems = [
        profile ,
        refer ,
        support ,
        switch_User ,
        earnings,
        logout
    ]
}

struct Image{
    static let CheckBox_Blank = "check_box_blank"
    static let CheckBox_Fill = "check_box_fill"
}
    

