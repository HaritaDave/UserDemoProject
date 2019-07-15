//
//  ConnectionWrapper.swift
//  PSYCHOnline-Demo
//
//  Created by harita Bhatt on 15/07/19.
//  Copyright © 2019 Harita Dave. All rights reserved.
//

// This class works as a connection wrapper that gets and sets data from web service

import UIKit

import Alamofire
import SwiftyJSON

class ConnectionWrapper: NSObject {
    
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (JSON) -> Void) {
        
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if (responseObject.response?.statusCode == 200) {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            else {
                let error = JSON(responseObject.result.value!)
                failure(error)
            }
        }
    }
    
    class func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (JSON) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if (responseObject.response?.statusCode == 200) {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            else {
                let error = JSON(responseObject.result.value!)
                failure(error)
            }
        }
    }
    
    class func requestPUTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (JSON) -> Void){
        
        Alamofire.request(strURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error = JSON(responseObject.result.value!)
                failure(error)
            }
        }
    }
}
