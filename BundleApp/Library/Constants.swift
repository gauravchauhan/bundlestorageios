import UIKit

struct Constants {
    
    struct AppUrls{
        static let baseUrl = "http://them.teamjft.com"
        static let experience = "/experience"
        static let learn = "/interest"
        static let signup = "/auth/register"
        static let login = "/auth/login"
    }
    
    struct Linkden_Credentials {
        
        static let webViewURLForLinkden = "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=\(Constants.Linkden_Credentials.linkdenClient_id)&redirect_uri=http://testthem.com/redirect&state=DCEeFWf45A53sdfKef424sw&scope=r_liteprofile%20r_emailaddress%20w_member_social"
        
        static let lindenGetAccessToken  = "https://www.linkedin.com/oauth/v2/accessToken"
        
        static let getEmailFromLinkden  = "https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))&oauth2_access_token="
        
        static let getNameFromLinkden  = "https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))&oauth2_access_token="
        
        static let linkdenClient_secret = "V5ThhZWUNEh2pSyU"
        static let linkdenClient_id = "81oyng2idahull"
        
    }
    
    struct Google_Credentials {
        static let googleClient_id = "16063448195-fr6rubcljrclhc9re3ria8hdipm24k8f.apps.googleusercontent.com"
    }
    
    struct Instagram_Credentials {
        
    }
    
    struct Colors{
        static let firstGradientColor : UInt32 = 0xe61225
        static let secondGradientColor : UInt32 = 0xac1421
        static let thirdGradientColor : UInt32 = 0xff4e5e
        static let textTitleColor : UInt32 = 0x999999
        static let textColor : UInt32 = 0x3c3c3c
        static let redText_borderColor : UInt32 = 0x3bc2331
    }
    
    struct networkConnectionErrorMessage{
        var status : String!
        var message : String!
        func toDictionary() -> [String : Any]{
            return ["status": status! ,"message": message!]
        }
    }
}
    

