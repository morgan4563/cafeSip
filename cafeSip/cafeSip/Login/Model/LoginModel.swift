//
//  LoginModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/19/25.
//

import Foundation

struct LoginModel {
    var email: String
    var password: String
    var userName: String
    
    init() {
        self.email = ""
        self.password = ""
        self.userName = ""
    }
    
    mutating func clear() {
        self.email = ""
        self.password = ""
        self.userName = ""
    }
}
