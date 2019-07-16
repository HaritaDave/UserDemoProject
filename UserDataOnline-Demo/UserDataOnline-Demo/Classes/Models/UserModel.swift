//
//  UserModel.swift
//  PSYCHOnline-Demo
//
//  Created by harita Bhatt on 15/07/19.
//  Copyright © 2019 Harita Dave. All rights reserved.
//

import UIKit

class UserModel {
    
    //MARK: Login Properties
    var email: String
    var password: String
    
    //MARK: User Properties
    var first_name: String
    var last_name: String
    var avatar: String
    
    init() {
        // Initialize stored properties.
        self.email = ""
        self.first_name = ""
        self.last_name = ""
        self.avatar = ""
        self.password = ""
    }
    
    init(email: String, first_name: String, last_name: String, avatar: String) {
        // Initialize stored properties.
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.avatar = avatar
        self.password = ""
    }
}
