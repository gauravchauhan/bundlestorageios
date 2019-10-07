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

//MARK:- Get Delegates

protocol GetListingTypeDelegate {
    func listingTypeResponse(data : [String : Any])
}

protocol GetFeatureDelegate {
    func featureResponse(data : [String : Any])
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
    
    //MARK:- Get Delegates varriables
    var getListingTypeDelegate : GetListingTypeDelegate!
    var featureDelegate : GetFeatureDelegate!
    
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
            try Network.reachability = Reachability(hostname: "www.google.com")
            print("Network.reachability \(String(describing: Network.reachability.status))")
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
            try Network.reachability = Reachability(hostname: "www.google.com")
            print("Network.reachability \(String(describing: Network.reachability.status))")
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
            try Network.reachability = Reachability(hostname: "www.google.com")
            print("Network.reachability \(String(describing: Network.reachability.status))")
            
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
        default:
            return returnFromDefaultCase(apiName : apiName , response : response)
        }
    }
    
    func returnFromDefaultCase(apiName : String , response : [String : Any]){
    }
    
}
