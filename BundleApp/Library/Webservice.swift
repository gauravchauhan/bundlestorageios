
//
//  Created by Rohit Gupta on 27/03/18.
//  Copyright © 2018 Jellyfish Technologies. All rights reserved.
//



import Foundation
import UIKit
import AFNetworking


enum methodType {
    
    case post,get,put
    
}

class webservices {
    
    init(){}
    
    let BaseURL = Constants.AppUrls.baseUrl
    
    var responseCode = 0;
    
    func startConnectionWithSting(_ getUrlString:NSString ,method_type:methodType, params getParams:[NSString : NSObject] ,outputBlock:@escaping (_ receivedData:NSDictionary)->Void ) {
        
        DispatchQueue.global().async {
            //AFHTTPSessionManager
            let manager = AFHTTPRequestOperationManager()
            
            manager.operationQueue.cancelAllOperations()
            
            //manager.securityPolicy.allowInvalidCertificates = YES;
            //  manager.securityPolicy.validatesDomainName = NO;
            
            //manager.securityPolicy.allowInvalidCertificates = true
            
            //    manager.securityPolicy.validatesDomainName = false
            
            manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
            
            manager.requestSerializer.setValue("JWT " + Singelton.sharedInstance.authToken , forHTTPHeaderField: "Authorization")
            
            let url = self.BaseURL + (getUrlString as String)
            
            print(url)
            
            manager.post(url as String, parameters: getParams, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    // print("JSON: " + responseObject.description)
                }
                
            }, failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
                
                self.responseCode = 2
                
                let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
                
                outputBlock(errorDist);
                
                print("Error: " + (error?.localizedDescription)!)
                
            })
        }
    }
    
    
    func startConnectionWithMultipleImages(imageDataArr:NSArray,fileName:String,imageparm:NSArray, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html", "text/plain", "text/json", "text/javascript", "audio/wav") as Set<NSObject>
        
        // manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let url =  self.BaseURL + (getUrlString as String)
        
        print(url)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
            
            for i in 0..<imageDataArr.count{
                
                formData?.appendPart(withFileData: (imageDataArr.object(at: i) as! Data), name:imageparm.object(at: i) as? String, fileName: fileName, mimeType: "image/jpeg")
                
            }
            //            conn.startConnectionWithfile(imageData, fileName: fileName, imageparm: "cover_image", getUrlString: "PublishBook", method_type:methodType.POST, params: param){receivedData in
            
        }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any?) -> Void in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
            }
            
        }, failure: { (operation:AFHTTPRequestOperation?, error:
            Error?) -> Void in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
        })
        
        
        
        
    }
    
    func startConnectionWithData(imageData:NSData,fileName:String,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        manager.requestSerializer.setValue("JWT " + Singelton.sharedInstance.authToken , forHTTPHeaderField: "Authorization")
        
        manager.requestSerializer.timeoutInterval = 120
        
        let url = self.BaseURL + (getUrlString as String)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
            
            formData!.appendPart(withFileData: imageData as Data?, name:imageparm, fileName: fileName, mimeType: "image/jpeg")
            
        }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any?) -> Void in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
            }
            
        }, failure: { (operation:AFHTTPRequestOperation?, error:
            Error?) -> Void in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
        })
    }
    
    func startConnectionWithfile1(_ imageData:NSArray,fileName:String,filetype:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        DispatchQueue.global().async {
            
            let manager = AFHTTPRequestOperationManager()
            
            manager.operationQueue.cancelAllOperations()
            
            manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
            
            let url = self.BaseURL + (getUrlString as String)
            
            manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
                //code
                
                for i in 0..<imageData.count{
                    
                    let imagedata:Data = imageData[i] as! Data
                    
                    let strname = String(format: "name%@", i)
                    
                    formData?.appendPart(withFileData: imagedata, name: strname, fileName: fileName, mimeType: filetype)
                    
                }
                
            }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any!) -> Void in
                
                print(responseObject)
                
                if(responseObject != nil){
                    
                    self.responseCode = 1
                    
                    outputBlock(responseObject! as! NSDictionary);
                    
                    print("JSON: " + (responseObject as AnyObject).description)
                }
                
            }, failure: { (operation:AFHTTPRequestOperation?, error:Error?) -> Void in
                
                self.responseCode = 2
                
                let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
                
                outputBlock(errorDist);
                
                print(error!)
                
            })
            
        }
    }
    
    //  Mark service for Document Picker
    
    func startConnectionWithFile(imageData:NSData,fileName:String,filetype:String,imageparm:String, getUrlString:NSString ,method_type:methodType, params getParams:[NSString:NSObject],outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        manager.requestSerializer.timeoutInterval = 180
        
        let url = self.BaseURL + (getUrlString as String)
        
        manager.post(url, parameters: getParams, constructingBodyWith: { (formData: AFMultipartFormData?) -> Void in
            
            formData!.appendPart(withFileData: imageData as Data?, name:imageparm, fileName: fileName, mimeType: filetype)
            
        }, success: { (operation:AFHTTPRequestOperation?, responseObject:Any?) -> Void in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
            }
            
        }, failure: { (operation:AFHTTPRequestOperation?, error:
            Error?) -> Void in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
        })
    }
    
    
    
    
    
    
    
    
    
    func startConnectionWithStringGetType(getUrlString:NSString ,outputBlock:@escaping (_ receivedData:NSDictionary)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.operationQueue.cancelAllOperations()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        let url = self.BaseURL + (getUrlString as String)
        
        print(url)
        
        manager.get(url as String, parameters: nil, success: { (operation: AFHTTPRequestOperation?,responseObject: Any?) in
            
            if(responseObject != nil){
                
                self.responseCode = 1
                
                outputBlock(responseObject! as! NSDictionary);
                
                // print("JSON: " + responseObject.description)
            }
        }, failure: { (operation: AFHTTPRequestOperation?,error: Error?) in
            
            self.responseCode = 2
            
            let errorDist:NSDictionary = ["Error" : error!.localizedDescription]
            
            outputBlock(errorDist);
            
            print("Error: " + (error?.localizedDescription)!)
        })
        
        
        
    }
}
