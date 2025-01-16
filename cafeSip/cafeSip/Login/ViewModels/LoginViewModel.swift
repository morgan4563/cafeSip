//
//  LoginViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import SwiftUI

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var userName = ""
    
    func signIn() async {
        await AuthManager.shared.signIn(email: email, password: password)
    }
    
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, userName: userName)
        email = ""
        password = ""
        userName = ""
    }
}
