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

//MARK:- Get Delegates


//MARK:- Post Delegates
//MARK: Start Class

class Service{
    
    var connection = webservices()
    let errorMessage = Constants.networkConnectionErrorMessage.init(status: "networkError", message: "Check your internet connection")
    
    //MARK:- Get Delegates varriables
    
    
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
            let url : URL!
            apiName.contains("www.linkedin.com") ? ( url = URL(string: apiName )!) : ( url = URL(string: Constants.AppUrls.baseUrl + apiName )!)
            var request = URLRequest(url: url)
            request.httpMethod = api_Type
            let data = parameter.data(using:String.Encoding.ascii, allowLossyConversion: false)
            print("Parameter \(String(describing: data))")
            request.httpBody = data
            print(Singelton.sharedInstance.authToken)
            print(url)
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
    
    //MARK:- Return function
    
    func returnResponseToDelegate(apiName : String , response : [String : Any]){
//        print("API name \(apiName)")
//        //        print("response \(response)")
//        switch apiName {
//        case Constants.AppUrls.experience:
//            return self.experienceDelgate.experienceListResponse(data: response)
//        case Constants.AppUrls.learn:
//            return self.learnListDelegate.LearnListResponse(data: response)
//        case Constants.AppUrls.login:
//            self.loginDelegate.LoginResponse(data: response)
//        case Constants.AppUrls.signup:
//            self.signupDelegate.SignupResponse(data: response)
//        case Constants.AppUrls.postNews:
//            self.postNewsFeedDelegate.postNewsResponse(data: response)
//        case Constants.AppUrls.myNewsfeed:
//            self.myNewsfeedDelegate.myNewsfeedResponse(data: response)
//        case Constants.AppUrls.socialLogin:
//            self.socialLoginDelegate.socialLoginResponse(data: response)
//        case Constants.AppUrls.lindindAccess:
//            self.linkdinAccessTokenDelegate.linkdinAccessTokenResponse(data: response)
//        case Constants.AppUrls.updateInfo:
//            self.updateInfoDelegate.updateInfoResponse(data: response)
//        default:
//            return returnFromDefaultCase(apiName : apiName , response : response)
//        }
    }
    
    
    func returnFromDefaultCase(apiName : String , response : [String : Any]){
//        if apiName.contains("forgotPassword"){
//            self.forgotPasswordDelegate.forgotPasswordResponse(data: response)
//        }else if apiName.contains("thumbsup"){
//            self.thumbsUPDelegate.ThumbsUPResponse(data: response)
//        }else if apiName.contains("thumbsdown"){
//            self.thumbsDownDelegate.ThumbsDownResponse(data: response)
//        }else if apiName.contains("deleteNewsfeed"){
//            self.deleteNewsFeedDelegate.deleteNewsFeedResponse(data: response)
//        }else if apiName.contains("postComment"){
//            self.postCommentDelegate.PostCommentResponse(data: response)
//        }else if apiName.contains("comment"){
//            self.getAllCommentDelegate.getAllCommentResponse(data: response)
//        }else if apiName.contains("grade"){
//            self.gradeDelegate.gradeResponse(data: response)
//        }else if apiName.contains("newsfeed"){
//            self.getNewsFeedDelegate.getNewPostResponse(data: response)
//        }else if apiName.contains("api.linkedin.com/v2/emailAddres"){
//            self.getEmailFromLindinDelegate.getEmailFromLindinResponse(data: response)
//        }else if apiName.contains("api.linkedin.com/v2/me"){
//            self.getNameFromLindinDelegate.getNameFromLindinResponse(data: response)
//        }
    }
    
}
