//
//  Service.swift
//  THEM
//
//  Created by Rohit Gupta on 14/03/19.
//  Copyright © 2019 Vijay Mishra. All rights reserved.
//

import Foundation

enum apiType : String{
    case POST, PUT, DELETE, GET
}

//MARK:- Post Delegates

protocol SignUpDelegate {
    func signUpResponse(data : [String : Any])
}

protocol SignInDelegate {
    func signInResponse(data : [String : Any])
}

protocol SocialLoginDelegate {
    func socialLoginResponse(data : [String : Any])
}

protocol AddStorageDelegate {
    func addStorageResponse(data : [String : Any])
}

protocol GetStorageListDelegate {
    func getStorageListResponse(data : [String : Any])
}

protocol UploadIDProofDelegate {
    func uploadIDProofResponse(data : [String : Any])
}
protocol ForgotPasswordDelegate {
    func forgotPasswordResponse(data : [String : Any])
}

protocol UploadStorageFileDelegate {
    func uploadStorageFileResponse(data : [String : Any])
}

protocol RemoveFileDelegate {
    func removeFileResponse(data : [String : Any])
}

protocol StorageDetailDelegate {
    func storageDetailResponse(data : [String : Any])
}

protocol BookingStorageDelegate {
    func bookingStorageResponse(data : [String : Any])
}

protocol EditProfileDelegate {
    func editProfileResponse(data : [String : Any])
}


protocol UpdateBookingRequestDelegate {
    func updateBookingRequestResponse(data : [String : Any])
}

protocol FilterDataDelegate {
    func filterDataRequestResponse(data : [String : Any])
}

protocol GetChatHistoryDelegate {
    func getChatHistoryResponse(data : [String : Any])
}

protocol CreateChatDelegate {
    func createChatResponse(data : [String : Any])
}

protocol SubmitReviewDelegate {
    func submitReviewResponse(data : [String : Any])
}

protocol StorageSummaryDelegate {
    func storageSummaryResponse(data : [String : Any])
}

protocol SendNonceDelegate {
    func sendNonceResponse(data : [String : Any])
}

protocol AddBAnkDetailDelegate {
    func addBAnkDetailResponse(data : [String : Any])
}

protocol RemoveParticularNotificationDelegate {
    func removeParticularNotificationResponse(data : [String : Any])
}
protocol UserSupportDelegate {
    func userSupport(data : [String : Any])
}

protocol QRCodeDelegate {
    func QRCodeResponse(data : [String : Any])
}


//MARK:- Get Delegates

protocol GetListingTypeDelegate {
    func listingTypeResponse(data : [String : Any])
}

protocol GetFeatureDelegate {
    func featureResponse(data : [String : Any])
}

protocol GetUpcomingBookinRequestDelegate {
    func getUpcomingBookinRequestResponse(data : [String : Any])
}

protocol UserBookinRequestDelegate {
    func userBookinRequestResponse(data : [String : Any])
}
protocol GetChatListDelegate {
    func getChatListResponse(data : [String : Any])
}

protocol GetClientTokenDelegate {
    func getClientTokenResponse(data : [String : Any])
}

protocol GetIdProofStatusDelegate {
    func getIdProofStatusResponse(data : [String : Any])
}

protocol GetHostStorageListDelegate {
    func getHostStorageListResponse(data : [String : Any])
}

protocol GetUserBookingStatusesListDelegate {
    func getUserBookingStatusesResponse(data : [String : Any])
}

protocol GetHostBookingStatusesListDelegate {
    func getHostBookingStatusesResponse(data : [String : Any])
}

protocol GetMyEarningsListDelegate {
    func getMyEarningsListResponse(data : [String : Any])
}

protocol GetNotificationListDelegate {
    func getNotificationListResponse(data : [String : Any])
}

protocol RemoveNotificationDelegate {
    func removeNotificationResponse(data : [String : Any])
}

protocol PrivacyPolicyDelgateDelegate {
    func privacyPolicyDelgateResponse(data : [String : Any])
}

protocol BookingHistoryListDelegate {
    func bookingHistoryListResponse(data : [String : Any])
}

protocol NotificationCountDelegate {
    func NotificationCountResponse(data : [String : Any])
}



protocol LogoutDelegate {
    func logouttResponse(data : [String : Any])
}

//MARK: Start Class

class Service{
    
    var connection = webservices()
    let errorMessage = Constants.networkConnectionErrorMessage.init(status: "networkError", message: "Check your internet connection")
    
    //MARK:- Post Delegates varriables
    
    var signUpDelegate : SignUpDelegate!
    var socialLoginDelegate : SocialLoginDelegate!
    var signInDelegate : SignInDelegate!
    var addStorageDelegate : AddStorageDelegate!
    var getStorageListDelegate : GetStorageListDelegate!
    var uploadIDProofDelegate : UploadIDProofDelegate!
    var forgotPasswordDelegate : ForgotPasswordDelegate!
    var uploadStorageFileDelegate : UploadStorageFileDelegate!
    var removeFileDelegate : RemoveFileDelegate!
    var storageDetailDelegate : StorageDetailDelegate!
    var bookingStorageDelegate : BookingStorageDelegate!
    var editProfileDelegate : EditProfileDelegate!
    var updateBookingRequestDelegate : UpdateBookingRequestDelegate!
    var filterDataDelegate : FilterDataDelegate!
    var getChatHistoryDelegate : GetChatHistoryDelegate!
    var createChatDelegate : CreateChatDelegate!
    var submitReviewDelegate : SubmitReviewDelegate!
    var storageSummaryDelegate : StorageSummaryDelegate!
    var sendNonceDelegate : SendNonceDelegate!
    var addBAnkDetailDelegate : AddBAnkDetailDelegate!
    var removeParticularNotificationDelegate : RemoveParticularNotificationDelegate!
    var userSupportDelegate : UserSupportDelegate!
    var qrCodeDelegate : QRCodeDelegate!
    
    
    //MARK:- Get Delegates varriables
    var getListingTypeDelegate : GetListingTypeDelegate!
    var featureDelegate : GetFeatureDelegate!
    var getUpcomingBookinRequestDelegate : GetUpcomingBookinRequestDelegate!
    var userBookinRequestDelegate : UserBookinRequestDelegate!
    var getChatListDelegate : GetChatListDelegate!
    var getClientTokenDelegate : GetClientTokenDelegate!
    var getIdProofStatusDelegate : GetIdProofStatusDelegate!
    var getHostStorageListDelegate : GetHostStorageListDelegate!
    var getUserBookingStatusesListDelegate : GetUserBookingStatusesListDelegate!
    var getHostBookingStatusesListDelegate : GetHostBookingStatusesListDelegate!
    var getMyEarningsListDelegate : GetMyEarningsListDelegate!
    var getNotificationListDelegate : GetNotificationListDelegate!
    var removeNotificationDelegate : RemoveNotificationDelegate!
    var privacyPolicyDelgateDelegate : PrivacyPolicyDelgateDelegate!
    var bookingHistoryListDelegate : BookingHistoryListDelegate!
    var notificationCountDelegate : NotificationCountDelegate!
    var logoutDelegate : LogoutDelegate!
    
    //MARK:- Post method
    
    func postWithAFNetworking(parameter : [NSString : NSObject], apiName : String){
        
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
            print("Network.reachability \(String(describing: Network.reachability.status))")
            //
            //            guard let networkStatus : String = "\(Network.reachability.status)",  networkStatus != "unreachable"else {
            //                print("Network error")
            //                return self.returnResponseToDelegate(apiName: apiName, response: errorMessage.toDictionary())
            //            }
            let parameter :[NSString: NSObject] = parameter
            print("Parameter \(parameter)")
            connection.startConnectionWithSting(apiName as NSString, method_type: methodType.post, params: parameter , outputBlock: {(recieveData)in
                self.returnResponseToDelegate(apiName: apiName, response: recieveData as! [String : Any])
            })
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
        
    }
    
    
    func PostService(parameter:String , apiName: String, api_Type : String){
        do {
//            try Network.reachability = Reachability(hostname: "www.google.com")
//            print("Network.reachability \(String(describing: Network.reachability.status))")
            print("api_Type\(String(describing: api_Type))")
            
            //            guard let networkStatus : String = "\(Network.reachability.status)",  networkStatus != "unreachable"else {
            //                print("Network error")
            //                return self.returnResponseToDelegate(apiName: apiName, response: errorMessage.toDictionary())
            //            }
            print("api name \(apiName)")
            let url : URL! = URL(string: Constants.AppUrls.baseUrl + apiName)
            print("reuest \(String(describing: url))")
            var request = URLRequest(url: url)
            request.httpMethod = api_Type
            let data = parameter.data(using:String.Encoding.ascii, allowLossyConversion: false)
            print("Parameter \(String(describing: data))")
            request.httpBody = data
            print(Singelton.sharedInstance.authToken)
            print(url as Any)
            Singelton.sharedInstance.authToken != "" ? request.addValue("JWT " + Singelton.sharedInstance.authToken , forHTTPHeaderField: "Authorization") : nil
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let dictionary = responseJSON as? [String: Any] {
                    self.returnResponseToDelegate(apiName: apiName, response: dictionary)
                }
            }
            task.resume()
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
    
    //MARK:- Upload Image Service
    
    func uploadImageFile(image: NSData , imageParameter : String , apiName : String , parameter : [NSString : NSObject]){
        
        do {
//            try Network.reachability = Reachability(hostname: "www.google.com")
//            print("Network.reachability \(String(describing: Network.reachability.status))")
            //
            //            guard let networkStatus : String = "\(Network.reachability.status)",  networkStatus != "unreachable"else {
            //                print("Network error")
            //                return self.returnResponseToDelegate(apiName: apiName, response: errorMessage.toDictionary())
            //            }
            
            print("Api name \(apiName)*******\n   imageParameter \(imageParameter)**********   \n parameter\(parameter)")
            let timeStamp = String(Date().timeIntervalSince1970 * 1000)
            connection.startConnectionWithData(imageData: image, fileName: timeStamp + ".jpeg", imageparm: imageParameter, getUrlString: apiName as NSString , method_type: methodType.post, params: parameter, outputBlock: {(recieveData)in
                self.returnResponseToDelegate(apiName: apiName, response: recieveData as! [String : Any])
            })
            
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
        
    }
    
    //MARK:- Get method
    
    func getService(apiName: String, api_Type : String){
        
        do {
//            try Network.reachability = Reachability(hostname: "www.google.com")
//            print("Network.reachability \(String(describing: Network.reachability.status))")
            
            //            guard let networkStatus : String = "\(Network.reachability.status)",  networkStatus != "unreachable"else {
            //                print("Network error")
            //                return self.returnResponseToDelegate(apiName: apiName, response: errorMessage.toDictionary())
            //            }
            //api.linkedin.com
            print("api \(apiName)")
            let url : URL!
            apiName.contains("api.linkedin.com") ? ( url = URL(string: apiName)!) : ( url = URL(string: Constants.AppUrls.baseUrl + apiName)!)
            
            //            let url = URL(string: Constants.AppUrls.baseUrl + apiName)!
            //            print("Api Name \(apiName)")
            var request = URLRequest(url: url)
            print(request)
            request.httpMethod = api_Type
            print("Singelton.sharedInstance.authToken     \(Singelton.sharedInstance.authToken)")
            Singelton.sharedInstance.authToken != "" ? request.addValue("JWT " + Singelton.sharedInstance.authToken , forHTTPHeaderField: "Authorization") : nil
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                print("responseJSON   \(responseJSON)")
                if let dictionary = responseJSON as? [String: Any] {
                    self.returnResponseToDelegate(apiName: apiName, response: dictionary)
                }
            }
            task.resume()
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
    
    //MARK:- Return functions
    
    func returnResponseToDelegate(apiName : String , response : [String : Any]){
        print("API name \(apiName)")
        switch apiName {
        case Constants.AppUrls.getListType:
            self.getListingTypeDelegate.listingTypeResponse(data: response)
        case Constants.AppUrls.signup:
            self.signUpDelegate.signUpResponse(data: response)
        case Constants.AppUrls.socialLogin:
            self.socialLoginDelegate.socialLoginResponse(data: response)
        case Constants.AppUrls.login:
            self.signInDelegate.signInResponse(data: response)
        case Constants.AppUrls.addStorage:
            self.addStorageDelegate.addStorageResponse(data: response)
        case Constants.AppUrls.getStorageList:
            self.getStorageListDelegate.getStorageListResponse(data: response)
        case Constants.AppUrls.getAmenities:
            self.featureDelegate.featureResponse(data: response)
        case Constants.AppUrls.govermentID:
            self.uploadIDProofDelegate.uploadIDProofResponse(data: response)
        case Constants.AppUrls.forgotPassword:
            self.forgotPasswordDelegate.forgotPasswordResponse(data: response)
        case Constants.AppUrls.uploadFile:
            self.uploadStorageFileDelegate.uploadStorageFileResponse(data: response)
        case Constants.AppUrls.removeUploadFile:
            self.removeFileDelegate.removeFileResponse(data: response)
        case Constants.AppUrls.storageDetails:
            self.storageDetailDelegate.storageDetailResponse(data: response)
        case Constants.AppUrls.bookingStorage:
            self.bookingStorageDelegate.bookingStorageResponse(data: response)
        case Constants.AppUrls.editProfile:
            self.editProfileDelegate.editProfileResponse(data: response)
        case Constants.AppUrls.getUpcomingBookingRequest:
            self.getUpcomingBookinRequestDelegate.getUpcomingBookinRequestResponse(data: response)
        case Constants.AppUrls.updateBookingRequest:
            self.updateBookingRequestDelegate.updateBookingRequestResponse(data: response)
        case Constants.AppUrls.userBookingRequest:
            self.userBookinRequestDelegate.userBookinRequestResponse(data: response)
        case Constants.AppUrls.filter_Data:
            self.filterDataDelegate.filterDataRequestResponse(data: response)
        case Constants.AppUrls.chatList:
            self.getChatListDelegate.getChatListResponse(data: response)
        case Constants.AppUrls.chatHistory:
            self.getChatHistoryDelegate.getChatHistoryResponse(data: response)
        case Constants.AppUrls.createChat:
            self.createChatDelegate.createChatResponse(data: response)
        case Constants.AppUrls.submitReview:
            self.submitReviewDelegate.submitReviewResponse(data: response)
        case Constants.AppUrls.storageSummery:
            self.storageSummaryDelegate.storageSummaryResponse(data: response)
        case Constants.AppUrls.client_token:
            self.getClientTokenDelegate.getClientTokenResponse(data: response)
        case Constants.AppUrls.sendNonce:
            self.sendNonceDelegate.sendNonceResponse(data: response)
        case Constants.AppUrls.idProof_Status:
            self.getIdProofStatusDelegate.getIdProofStatusResponse(data: response)
        case Constants.AppUrls.hostStorageList:
            self.getHostStorageListDelegate.getHostStorageListResponse(data: response)
        case Constants.AppUrls.userBookingStatuses:
            self.getUserBookingStatusesListDelegate.getUserBookingStatusesResponse(data: response)
        case Constants.AppUrls.hostStorageStatus:
            self.getHostBookingStatusesListDelegate.getHostBookingStatusesResponse(data: response)
        case Constants.AppUrls.hostEarning:
            self.getMyEarningsListDelegate.getMyEarningsListResponse(data: response)
        case Constants.AppUrls.addBankDetail:
            self.addBAnkDetailDelegate.addBAnkDetailResponse(data: response)
        case Constants.AppUrls.getAllNotifications:
            self.getNotificationListDelegate.getNotificationListResponse(data: response)
        case Constants.AppUrls.removeAllNotifications:
            self.removeNotificationDelegate.removeNotificationResponse(data: response)
        case Constants.AppUrls.removeNotification:
            self.removeParticularNotificationDelegate.removeParticularNotificationResponse(data: response)
        case Constants.AppUrls.privayPolicy:
            self.privacyPolicyDelgateDelegate.privacyPolicyDelgateResponse(data: response)
        case Constants.AppUrls.termsAndCondition:
            self.privacyPolicyDelgateDelegate.privacyPolicyDelgateResponse(data: response)
        case Constants.AppUrls.communityGuidelines:
            self.privacyPolicyDelgateDelegate.privacyPolicyDelgateResponse(data: response)
        case Constants.AppUrls.FAQs:
            self.privacyPolicyDelgateDelegate.privacyPolicyDelgateResponse(data: response)
        case Constants.AppUrls.bookingHistoryList:
            self.bookingHistoryListDelegate.bookingHistoryListResponse(data: response)
        case Constants.AppUrls.notificationCount:
            self.notificationCountDelegate.NotificationCountResponse(data: response)
        case Constants.AppUrls.userSupport:
            self.userSupportDelegate.userSupport(data: response)
        case Constants.AppUrls.qrCodeData:
            self.qrCodeDelegate.QRCodeResponse(data: response)
        case Constants.AppUrls.logout:
            print("logout resposne \(response)")
        default:
            return returnFromDefaultCase(apiName : apiName , response : response)
        }
    }
    
    func returnFromDefaultCase(apiName : String , response : [String : Any]){
    }
    
}
