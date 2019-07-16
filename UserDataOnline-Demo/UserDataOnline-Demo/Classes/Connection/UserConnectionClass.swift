//
//  UserConnectionClass.swift
//  
//
//  Created by harita Bhatt on 16/07/19.
//

import Foundation

class UserConnectionClass: NSObject {
    class func PerformUserLogin(email: String, password: String, success: @escaping (Bool) -> Void) {
        ConnectionWrapper.requestPOSTURL(GlobalConstants.kLoginWSURL, params: [GlobalConstants.kUserPassword:password as AnyObject, GlobalConstants.kUserEmail:email as AnyObject], headers: nil, success: { (JSON) in
            success(true)
        })
        { (Error) in
            success(true)
        }
    }
    
    class func PerformGetUserDetails(response: @escaping (_ success: Bool,_ resData: [UserModel]) -> Void) {
        
        ConnectionWrapper.requestGETURL(GlobalConstants.kUserDetailsWSURL, success: { (JSON) in
            
            var arrUserList = [UserModel]()
            
            if let resData = JSON["data"].arrayObject {
                let arrData = resData as! [[String:AnyObject]]
                arrUserList = UserConnectionClass.prepareUserData(arrData: arrData)
            }
            
            response(true,arrUserList)
            
        }) { (Error) in
            response(false,[UserModel]())
        }
    }
    
    class func PerformUpdateUserDetails(name: String, job: String, success: @escaping (_ success: Bool) -> Void) {
        
        ConnectionWrapper.requestPUTURL(GlobalConstants.kUpdateUserWSURL, params: [GlobalConstants.kUserName:name as AnyObject, GlobalConstants.kUserJob:job as AnyObject], headers: nil, success: { (JSON) in
            success(true)
        }) { (JSON) in
            success(false)
        }
    }
    
    
    
    class func prepareUserData(arrData: [[String:AnyObject]]) -> [UserModel] {
        var arrUserList = [UserModel]()
        
        for var dict in arrData {
            let userDetail = UserModel.init()
            
            userDetail.first_name = dict[GlobalConstants.kUserFName] as! String
            userDetail.last_name = dict[GlobalConstants.kUserLName] as! String
            userDetail.email = dict[GlobalConstants.kUserEmail] as! String
            userDetail.avatar = dict[GlobalConstants.kUserAvatar] as! String
            
            arrUserList.append(userDetail)
        }
        
        return arrUserList
    }
}
