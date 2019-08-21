import UIKit

struct Constants {
    
    struct AppUrls{
        static let baseUrl = "http://them.teamjft.com"
        static let experience = "/experience"
        static let learn = "/interest"
        static let signup = "/auth/register"
        static let login = "/auth/login"
    }
    
    struct Google_Credentials {
        static let googleClient_id = "16063448195-fr6rubcljrclhc9re3ria8hdipm24k8f.apps.googleusercontent.com"
        static let googleAPIKey = "AIzaSyD0a5zNMv7YgIGjVYYbMXgJx1W8kUYOY7w"
        //
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
    }
    
    struct networkConnectionErrorMessage{
        var status : String!
        var message : String!
        func toDictionary() -> [String : Any]{
            return ["status": status! ,"message": message!]
        }
    }
}
    

