//
//  LoginModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/19/25.
//

import Foundation

struct LoginModel {
    private var email: String
    private var password: String
    private var userName: String
    
    init() {
        self.email = ""
        self.password = ""
        self.userName = ""
    }
    
    func getEmail() -> String {
        return email
    }
    
    mutating func setEmail(newValue: String) {
        self.email = newValue
    }
    
    func getPassword() -> String {
        return password
    }
    
    mutating func setPassword(newValue: String) {
        self.password = newValue
    }
    
    func getUserName() -> String {
        return userName
    }
    
    mutating func setUserName(newValue: String) {
        self.userName = newValue
    }
    
    mutating func clear() {
        self.email = ""
        self.password = ""
        self.userName = ""
    }
}
