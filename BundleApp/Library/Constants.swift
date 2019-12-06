import UIKit

struct Constants {
    
    /*
     All URLS declare which is used in to the application
     */
    //http://bundle.teamjft.com
    struct AppUrls{
        static let baseUrl = "http://1dac5659.ngrok.io"
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
        static let bookingStorage = "/bookingStorage"
        static let editProfile = "/editProfile"
        static let getUpcomingBookingRequest = "/getUpcomingBookingRequest"
        static let updateBookingRequest = "/updateBookingRequest"
        static let userBookingRequest = "/userBookingRequest"
        static let filter_Data = "/filterStorage1"
        static let chatList = "/getChatsList"
        static let chatHistory = "/chatHistory"
        static let createChat = "/createChat"
        static let submitReview = "/submitReview"
        static let storageSummery = "/storageSummery"
        static let client_token = "/client_token"
        static let sendNonce = "/checkout"
        static let idProof_Status = "/getIdproofStatus"
        static let hostStorageList = "/hostStorageList"
        static let userBookingStatuses = "/userBookingDetailStatus"
        static let hostStorageStatus = "/hostStorageStatus"
        static let hostEarning = "/hostEarning"
        static let addBankDetail = "/addBankDetails"
        static let logout = "/logout"
        static let getAllNotifications = "/getAllNotifications"
        static let removeAllNotifications = "/removeAllNotifications"
        static let removeNotification = "/removeNotification"
        static let privayPolicy = "/privayPolicy"
        static let termsAndCondition = "/termsAndCondition"
        static let communityGuidelines = "/communityGuidelines"
        static let FAQs = "/FAQs"
        static let userSupport = "/userSupport"
        static let bookingHistoryList = "/bookingHistoryList"
        static let notificationCount = "/notificationCount"
        static let qrCodeData = "/qrCodeData"
        //qrCodeData

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
    static let profile = NSLocalizedString("Profile", comment: "")
    static let refer = NSLocalizedString("Refer bundle to a friend", comment: "")
    static let support = NSLocalizedString("Support", comment: "")
    static let switch_User = NSLocalizedString("Switch to a user", comment: "")
    static let switch_Host = NSLocalizedString("Switch to a host", comment: "")
    static let earnings = NSLocalizedString("My Earnings", comment: "")
    static let savings = NSLocalizedString("My Savings", comment: "")
    static let my_storage = NSLocalizedString("My Storage", comment: "")
    static let logout = NSLocalizedString("logout", comment: "")
    static let someError = NSLocalizedString("Something error", comment: "")
    static let per_Day = NSLocalizedString("Enter per day price", comment: "")
    static let per_Week = NSLocalizedString("Enter per week price", comment: "")
    static let per_Month = NSLocalizedString("Enter per month price", comment: "")
    static let no_Desc = NSLocalizedString("NO description available", comment: "")
    static let allow_Location = NSLocalizedString("Allow Location", comment: "")
    static let max_Image = NSLocalizedString("Storage Image", comment: "")
    static let min_Image = NSLocalizedString("Minimum image", comment: "")
    static let describe_What_Space = NSLocalizedString("Describe what you will be using the space?", comment: "")
    static let storage_Book_Message = NSLocalizedString(" Booking includes whole space listed, or something of that style.", comment: "")
    static let select_StartDate = NSLocalizedString( "Select start date first.", comment: "")
    
    static let small_item = NSLocalizedString( "Small item", comment: "")
    static let medium_item = NSLocalizedString( "Medium item", comment: "")
    static let large_item = NSLocalizedString( "Big item", comment: "")
    
    static let small_items = NSLocalizedString( "Small items", comment: "")
    static let medium_items = NSLocalizedString( "Medium items", comment: "")
    static let large_items = NSLocalizedString( "Big items", comment: "")
    static let end_date = NSLocalizedString( "End date", comment: "")
    static let select_start_date = NSLocalizedString( "Select start date", comment: "")
    static let select_end_date = NSLocalizedString( "Select end date", comment: "")
    static let message_empty = NSLocalizedString( "Message can't be empty", comment: "")
    
    //"My Storage"

    static let message = NSLocalizedString("Message", comment: "")
    static let request = NSLocalizedString("Request", comment: "")
    static let SideBarMenuItems_host = [
        profile ,
        refer ,
        support ,
        switch_User,
        earnings,
        my_storage,
        logout
    ]
    
    static let SideBarMenuItems_User = [
        profile ,
        refer ,
        support ,
        switch_Host,
        savings,
        logout
    ]
    
    
    /*"Support" = "Support";
     "Community guidlines" = "Community guidlines";
     "Terms & Conditions" = "Terms & Conditions";
     "Privacy Policy" = "Privacy Policy";
     "User Licensing Agreement" = "User Licensing Agreement";
     "FAQ's" = "FAQ's";
     "Web Link" = "Web Link"
     Goverment ID;
     Booking history list
     Contact Us*/
    
    static let setting_Support = NSLocalizedString( "Support", comment: "")
    static let setting_Community = NSLocalizedString( "Community guidlines", comment: "")
    static let setting_Terms = NSLocalizedString( "Terms & Conditions", comment: "")
    static let setting_Policy = NSLocalizedString( "Privacy Policy", comment: "")
    static let setting_License = NSLocalizedString( "User Licensing Agreement", comment: "")
    static let setting_FAQ = NSLocalizedString( "FAQ's", comment: "")
    static let setting_WebLink = NSLocalizedString( "Web Link", comment: "")
    static let setting_GovermentId = NSLocalizedString( "Goverment ID", comment: "")
    static let booking_HistoryList = NSLocalizedString( "Booking history list", comment: "")
    
    static let contact_US = NSLocalizedString( "Contact Us", comment: "")
    
    static let Settings_Items = [
        setting_GovermentId,
        booking_HistoryList,
        setting_Support ,
        setting_Community ,
        setting_Terms ,
        setting_Policy,
        setting_License,
        setting_FAQ,
        setting_WebLink,
    ]
    
}

struct Image{
    static let CheckBox_Blank = "check_box_blank"
    static let CheckBox_Fill = "check_box_fill"
}
    

