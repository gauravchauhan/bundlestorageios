import UIKit

struct Constants {
    
    struct AppUrls{
        static let baseUrl = "http://them.teamjft.com"
        static let experience = "/experience"
        static let learn = "/interest"
        static let signup = "/auth/register"
        static let login = "/auth/login"
        static let socialLogin = "/auth/socialLogin"
        static let forgotPassword = "/auth/forgotPassword"
        static let getPostNews = "/newsfeed"
        static let postNews = "/postNewsfeed"
//        static let thumbsup = "/newsfeed/\(Singelton.sharedInstance.id!)/thumbsup"
//        static let thumbsdown = "/newsfeed/\(Singelton.sharedInstance.id!)/thumbsdown"
//        static let postComment = "/newsfeed/\(Singelton.sharedInstance.id!)/postComment"
//        static let getAllComment = "/newsfeed/\(Singelton.sharedInstance.id!)/comment"
        static let deleteNewsfeed = "/deleteNewsfeed"
        static let updateNewsfeed = "/updateNewsfeed"
        static let follow = "/user/follow"
        static let unfollow = "/user/unfollow"
        static let updateInfo = "/user/updateInfo"
        static let myNewsfeed = "/newsfeed/my"
        static let grade = "/newsfeed/"
        
        static let webViewURLForLinden = "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=81ajiso572f7n9&redirect_uri=http://testthem.com/redirect&state=DCEeFWf45A53sdfKef424sw&scope=r_liteprofile%20r_emailaddress%20w_member_social"
        static let lindindAccess  = "https://www.linkedin.com/oauth/v2/accessToken"
        static let getEmailFromLinkdin  = "https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))&oauth2_access_token="
        static let getNameFromLinkdin  = "https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))&oauth2_access_token="
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
    

