//
//  LoginViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import SwiftUI

@Observable
class LoginViewModel {
    private var loginModel: LoginModel = LoginModel()
    
    var emailValidationMessage = ""
    var passwordValidationMessage = ""
    
    var email: String {
        get { loginModel.email }
        set { loginModel.email = newValue }
    }
    
    var password: String {
        get { loginModel.password }
        set { loginModel.password = newValue }
    }
    
    var userName: String {
        get { loginModel.userName }
        set { loginModel.userName = newValue }
    }
    
    func signIn() async {
        await AuthManager.shared.signIn(email: email, password: password)
        
        if let storeId = AuthManager.shared.currentUser?.storeId {
            await StoreManager.shared.loadCurrentStoreData(storeId: storeId)
        }
    }
    
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, userName: userName)
        clearUserInput()
    }
    
    func setInvalidEmailMessage() {
        emailValidationMessage = "이메일 형식이 올바르지 않습니다"
    }
    
    func setEmailValidationMessage() {
        emailValidationMessage = ""
    }
    
    func setInvalidPasswordMessage() {
        passwordValidationMessage = "비밀번호 형식이 올바르지 않습니다"
    }
    
    func setPasswordValidationMessage() {
        passwordValidationMessage = ""
    }
    
    func clearUserInput() {
        loginModel.clear()
    }
}
